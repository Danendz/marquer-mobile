import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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
  bool _uploadingAvatar = false;
  bool _uploadingCover = false;

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

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null || !mounted) return;

    setState(() => _uploadingAvatar = true);
    await ref.read(profileProvider.notifier).uploadAvatar(File(image.path));
    if (mounted) setState(() => _uploadingAvatar = false);
  }

  Future<void> _pickCover() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null || !mounted) return;

    setState(() => _uploadingCover = true);
    await ref.read(profileProvider.notifier).uploadCover(File(image.path));
    if (mounted) setState(() => _uploadingCover = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final userName = ref.watch(authProvider).user?.name ?? '';
    final profile = ref.watch(profileProvider).asData?.value;

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
            // Avatar
            Center(
              child: GestureDetector(
                onTap: _uploadingAvatar ? null : _pickAvatar,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: cs.surfaceContainer,
                      backgroundImage: profile?.avatarUrl != null
                          ? NetworkImage(profile!.avatarUrl!)
                          : null,
                      child: profile?.avatarUrl == null
                          ? Icon(Icons.person, size: 48,
                              color: cs.onSurfaceVariant)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: cs.primary,
                          shape: BoxShape.circle,
                        ),
                        child: _uploadingAvatar
                            ? const SizedBox(
                                width: 16, height: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white))
                            : Icon(Icons.camera_alt, size: 16,
                                color: cs.onPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Cover change button
            Center(
              child: TextButton.icon(
                onPressed: _uploadingCover ? null : _pickCover,
                icon: _uploadingCover
                    ? const SizedBox(
                        width: 14, height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.image_outlined, size: 18),
                label: const Text('Change Cover'),
              ),
            ),
            const SizedBox(height: 12),
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
