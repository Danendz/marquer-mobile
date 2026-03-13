import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountdownConfigSection extends StatelessWidget {
  final int countDownMinutes;
  final bool customCountDown;
  final TextEditingController countDownCtrl;
  final ValueChanged<int> onPresetSelected;
  final VoidCallback onCustomSelected;
  final ValueChanged<int> onCustomChanged;

  const CountdownConfigSection({
    super.key,
    required this.countDownMinutes,
    required this.customCountDown,
    required this.countDownCtrl,
    required this.onPresetSelected,
    required this.onCustomSelected,
    required this.onCustomChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );

    return Padding(
      key: const ValueKey('countdown'),
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Duration',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ...[30, 60, 90, 120].map(
                (m) => ChoiceChip(
                  label: Text('${m}m'),
                  selected: !customCountDown && countDownMinutes == m,
                  onSelected: (_) => onPresetSelected(m),
                ),
              ),
              ChoiceChip(
                label: const Text('Custom'),
                selected: customCountDown,
                onSelected: (_) => onCustomSelected(),
              ),
            ],
          ),
          if (customCountDown) ...[
            const SizedBox(height: 12),
            TextField(
              controller: countDownCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (v) {
                final parsed = int.tryParse(v) ?? 1;
                final clamped = parsed.clamp(1, 600);
                onCustomChanged(clamped);
                if (clamped != parsed) {
                  countDownCtrl.text = clamped.toString();
                  countDownCtrl.selection = TextSelection.fromPosition(
                    TextPosition(offset: countDownCtrl.text.length),
                  );
                }
              },
              decoration: InputDecoration(
                labelText: 'Duration',
                filled: true,
                fillColor: colorScheme.surface,
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                ),
                suffixText: 'min',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
