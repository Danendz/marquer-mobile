import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/profile/upsert_profile_request.dart';
import 'package:marquer/providers/auth/auth_provider.dart';
import 'package:marquer/providers/profile/profile_provider.dart';
import 'package:marquer/services/toast_service.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _statusController;
  late TextEditingController _locationController;
  late TextEditingController _bioController;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider).asData?.value;
    _usernameController = TextEditingController(text: profile?.username ?? '');
    _statusController = TextEditingController(text: profile?.status ?? '');
    _locationController = TextEditingController(text: profile?.location ?? '');
    _bioController = TextEditingController(text: profile?.bio ?? '');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _statusController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final request = UpsertProfileRequest(
      username: _usernameController.text.isEmpty
          ? null
          : _usernameController.text,
      status: _statusController.text.isEmpty ? null : _statusController.text,
      location:
          _locationController.text.isEmpty ? null : _locationController.text,
      bio: _bioController.text.isEmpty ? null : _bioController.text,
    );

    await ref.read(profileProvider.notifier).updateProfile(request);

    if (!mounted) return;
    setState(() => _saving = false);
    ToastService.showSuccess('Profile updated');
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final userName = ref.watch(authProvider).user?.name ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Name display (read-only, editing name requires Auth service)
            Text(
              'Name',
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: cs.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                userName,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Name can be changed from Auth settings',
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 20),
            _buildField(
              label: 'Username',
              controller: _usernameController,
              hint: 'your_username',
              maxLength: 20,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (value.length < 3) return 'At least 3 characters';
                  if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                    return 'Only letters, numbers, and underscores';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildField(
              label: 'Status',
              controller: _statusController,
              hint: 'What are you up to?',
              maxLength: 100,
            ),
            const SizedBox(height: 20),
            _buildField(
              label: 'Location',
              controller: _locationController,
              hint: 'Where are you from?',
              maxLength: 100,
            ),
            const SizedBox(height: 20),
            _buildField(
              label: 'Bio',
              controller: _bioController,
              hint: 'Tell us about yourself',
              maxLength: 500,
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int? maxLength,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }
}
