# Marquer Mobile

Flutter mobile app for notes, tasks, calendar, study timer, and OTA updates. Part of the Danendz services ecosystem.

## Tech Stack

| | |
|---|---|
| **Framework** | Flutter (Dart >= 3.10.3) |
| **State management** | Riverpod + Provider |
| **HTTP client** | Dio |
| **Navigation** | GoRouter |
| **Rich text editor** | Flutter Quill |
| **Error tracking** | Sentry / GlitchTip |
| **Audio** | audioplayers |
| **Background tasks** | flutter_foreground_task |

## Features

- **Notes** — rich text editor (Flutter Quill), create/edit/delete
- **Tasks** — todo lists with folders, categories, and filters
- **Calendar** — recurring plans (daily/weekly/interval/monthly), countdowns, weekly overview
- **Study Timer** — Pomodoro-style timer with foreground service, subjects, stats
- **OTA Updates** — version check against backend, APK download and sideload, update dialog with changelog

## Getting Started

**Prerequisites:**
- Flutter SDK (stable channel)
- Java 17 (for Android builds)
- Android emulator or physical device

```bash
# 1. Copy and configure environment
cp .env.example .env   # or create .env manually (see below)

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

## Environment Variables

Create a `.env` file in the project root:

```env
AUTH_API_URL=http://10.0.2.2:8082/api/auth
MARQUER_API_URL=http://10.0.2.2:8081/api/marquer
GLITCHTIP_DSN=
```

- `10.0.2.2` is the Android emulator loopback to the host machine
- `GLITCHTIP_DSN` — leave empty to disable error reporting locally

## Build & CI

```bash
# Release APK
flutter build apk --release

# Static analysis
flutter analyze
```

**GitHub Actions workflows:**

| Workflow | Trigger | Action |
|---|---|---|
| `pr-title.yml` | PR opened/edited | Validates PR title format |
| `build.yml` | Push to `main` | Builds release APK, uploads to S3, notifies backend |
| `pr-build.yml` | PR to `main` | Build gate — ensures APK compiles before merge |

OTA update flow:
1. CI builds release APK
2. Uploads to MinIO (S3)
3. Notifies Marquer Backend at `/internal/app-releases` via GitHub OIDC
4. App checks `/app/latest` on launch and prompts user to update

## PR Conventions

All PRs must follow: `<type>: <description>`

| Type | Changelog effect |
|---|---|
| `feat`, `fix`, `hotfix` | Individual bullet in update dialog |
| `chore`, `refactor`, `docs`, `test`, `bump` | Collapsed into "Performance improvements and minor bug fixes" |

Examples: `feat: dark mode support`, `fix: crash on task creation`, `bump: 1.1.7`
