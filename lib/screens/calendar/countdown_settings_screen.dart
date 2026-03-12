import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/update_countdown_request.dart';
import 'package:marquer/providers/calendar/countdowns_provider.dart';
import 'package:marquer/utils/format.dart';

class CountdownSettingsScreen extends ConsumerStatefulWidget {
  final Countdown countdown;

  const CountdownSettingsScreen({super.key, required this.countdown});

  @override
  ConsumerState<CountdownSettingsScreen> createState() => _CountdownSettingsScreenState();
}

class _CountdownSettingsScreenState extends ConsumerState<CountdownSettingsScreen> {
  late final TextEditingController _nameController;
  late DateTime _selectedDate;
  late String _selectedBg;
  late bool _isPinned;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.countdown.name);
    _selectedDate = DateTime.parse(widget.countdown.targetDate);
    _selectedBg = widget.countdown.bgImage;
    _isPinned = widget.countdown.isPinned;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickBackground() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => _BgPickerSheet(
        selected: _selectedBg,
        onSelect: (img) {
          setState(() => _selectedBg = img);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    ref.read(countdownsProvider.notifier).edit(
      widget.countdown,
      UpdateCountdownRequest(
        name: name,
        targetDate: formatDate(_selectedDate),
        isPinned: _isPinned,
        bgImage: _selectedBg,
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Settings'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Set as default'),
            subtitle: const Text('Show on home screen'),
            value: _isPinned,
            onChanged: (v) => setState(() => _isPinned = v),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Name'),
            subtitle: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Countdown name',
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Date'),
            subtitle: Text(DateFormat('MMMM d, yyyy').format(_selectedDate)),
            trailing: const Icon(Icons.chevron_right),
            onTap: _pickDate,
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Background'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    'assets/timer_bg/$_selectedBg',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: _pickBackground,
          ),
        ],
      ),
    );
  }
}

class _BgPickerSheet extends StatefulWidget {
  final String selected;
  final void Function(String) onSelect;

  const _BgPickerSheet({required this.selected, required this.onSelect});

  @override
  State<_BgPickerSheet> createState() => _BgPickerSheetState();
}

class _BgPickerSheetState extends State<_BgPickerSheet> {
  List<String> _images = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final assets = manifest
          .listAssets()
          .where((k) => k.startsWith('assets/timer_bg/'))
          .map((k) => k.split('/').last)
          .toList()
        ..sort();
      if (mounted) setState(() { _images = assets; _isLoading = false; });
    } catch (e) {
      debugPrint('Failed to load background images: $e');
      if (mounted) setState(() { _images = []; _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose Background', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _images.isEmpty
                ? const Center(child: Text('No images found'))
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final img = _images[index];
                      final isSelected = img == widget.selected;
                      return GestureDetector(
                        onTap: () => widget.onSelect(img),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                'assets/timer_bg/$img',
                                fit: BoxFit.cover,
                              ),
                              if (isSelected)
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
