import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:marquer/utils/colors.dart';

Future<int?> showCategoryPickerSheet(BuildContext context, WidgetRef ref) async {
  final folders = await ref.read(taskFoldersProvider.future);
  if (folders.isEmpty) return null;
  if (!context.mounted) return null;

  return showModalBottomSheet<int>(
    context: context,
    builder: (context) {
      final colors = getColors(context);
      return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: colors.onSurface.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Text(
                  'Select Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                ...folders.expand((folder) => folder.categories.map((category) {
                  return ListTile(
                    leading: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorFromHex(category.color) ?? Colors.white,
                      ),
                    ),
                    title: Text(category.name),
                    subtitle: Text(folder.name, style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.5),
                      fontSize: 12,
                    )),
                    onTap: () => Navigator.pop(context, category.id),
                  );
                })),
              ],
            ),
          ),
        ),
      );
    },
  );
}
