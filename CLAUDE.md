# Marquer Mobile — Claude guidance

## Git Workflow Rules

- Never commit changes without explicit user confirmation first.
- Never push changes without explicit user confirmation first.
- Never create a PR without explicit user confirmation first.
- Always show what will be committed/pushed and ask before proceeding.
- Never push directly to main — all changes must go through a branch and PR.

## Code Generation (Freezed + json_serializable)

Generated files (`*.freezed.dart`, `*.g.dart`) are gitignored. After modifying any `@freezed` model in `lib/api/models/`, regenerate with:

```bash
dart run build_runner build --delete-conflicting-outputs
```

CI runs this automatically before analyze/test/build. Locally, use `watch` mode during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## PR Title Convention

All PRs must follow: `<type>: <description>`

| Type | Changelog effect |
|------|-----------------|
| `feat` | Individual bullet in changelog |
| `fix` | Individual bullet in changelog |
| `hotfix` | Individual bullet in changelog |
| `chore` | Collapsed → "Performance improvements and minor bug fixes" |
| `refactor` | Collapsed → "Performance improvements and minor bug fixes" |
| `docs` | Collapsed → "Performance improvements and minor bug fixes" |
| `test` | Collapsed → "Performance improvements and minor bug fixes" |
| `bump` | Collapsed → "Performance improvements and minor bug fixes" |

Examples:
- `feat: dark mode support`
- `fix: crash on task creation`
- `bump: 1.0.9`

The `pr-title.yml` workflow enforces this on every PR.

## Changelog Flow (CI)

Version bumps follow: `pubspec.yaml` version → CI tag `v{version}`.

**On every push to main:**
1. Read version from `pubspec.yaml`
2. Check if `v{version}` tag exists in git
   - **Tag exists** → rebuild (same version), skip changelog generation, skip tagging
   - **Tag missing** → new release:
     a. Find previous tag via `git describe --tags --abbrev=0 HEAD^`
     b. Collect commits between previous tag and HEAD
     c. For each commit, fetch associated PR title via GitHub API
     d. Categorize: `feat`/`fix`/`hotfix` → individual bullets; rest → generic line
     e. Send changelog to backend with release notification
     f. Create and push `v{version}` tag

**Example:**
- `v1.0.8` tag at commit A
- Merge "feat: dark mode" → CI: tag exists for 1.0.8 → skip
- Merge "bump: 1.0.9" → CI: no `v1.0.9` tag → generate changelog for all PRs since `v1.0.8`

## Update Dialog

Shows version number and changelog in a scrollable area:
```text
Update available (v1.0.9)

What's new:
• Dark mode support
• Fix crash on task creation
• Performance improvements and minor bug fixes
```

Falls back to "A new version is available. Download now?" when no changelog is available.
