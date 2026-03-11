import 'package:flutter/material.dart';
import 'package:marquer/utils/colors.dart';

const _presetColors = [
  '#009688', // teal
  '#2196F3', // blue
  '#9C27B0', // purple
  '#E91E63', // pink
  '#F44336', // red
  '#FF5722', // orange
  '#FFC107', // amber
  '#4CAF50', // green
  '#00BCD4', // cyan
  '#795548', // brown
];

class ColorPickerRow extends StatelessWidget {
  final String? selectedColor;
  final ValueChanged<String?> onColorChanged;

  const ColorPickerRow({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // "Default" (null) option
          _ColorCircle(
            color: Colors.grey.shade300,
            isSelected: selectedColor == null,
            onTap: () => onColorChanged(null),
            semanticLabel: 'default color',
            child: selectedColor == null
                ? Icon(Icons.close, size: 14, color: Colors.grey.shade600)
                : null,
          ),
          const SizedBox(width: 8),
          for (final hex in _presetColors) ...[
            _ColorCircle(
              color: hexToColor(hex),
              isSelected: selectedColor == hex,
              onTap: () => onColorChanged(hex),
              semanticLabel: 'preset color: $hex',
            ),
            const SizedBox(width: 8),
          ],
          // Custom color picker
          _CustomColorCircle(
            selectedColor: selectedColor != null && !_presetColors.contains(selectedColor)
                ? selectedColor
                : null,
            onColorChanged: onColorChanged,
          ),
        ],
      ),
    );
  }
}

class _ColorCircle extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final String semanticLabel;
  final Widget? child;

  const _ColorCircle({
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.semanticLabel,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      selected: isSelected,
      button: true,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: isSelected
                  ? Border.all(color: Theme.of(context).colorScheme.onSurface, width: 2)
                  : null,
            ),
            child: isSelected && child == null
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : child,
          ),
        ),
      ),
    );
  }
}

class _CustomColorCircle extends StatelessWidget {
  final String? selectedColor;
  final ValueChanged<String?> onColorChanged;

  const _CustomColorCircle({
    required this.selectedColor,
    required this.onColorChanged,
  });

  String _colorToHex(Color color) {
    final r = (color.r * 255).round().toRadixString(16).padLeft(2, '0');
    final g = (color.g * 255).round().toRadixString(16).padLeft(2, '0');
    final b = (color.b * 255).round().toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedColor != null;
    final displayColor = isSelected ? hexToColor(selectedColor!) : Colors.grey.shade400;

    return Semantics(
      label: isSelected ? 'custom color: ${selectedColor!}' : 'custom color',
      selected: isSelected,
      button: true,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () async {
            final initial = isSelected ? hexToColor(selectedColor!) : Colors.blue;
            Color picked = initial;

            final confirmed = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Pick a color'),
                content: SizedBox(
                  width: 280,
                  child: StatefulBuilder(
                    builder: (ctx, setState) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(height: 48, color: picked),
                        const SizedBox(height: 12),
                        _HslColorPicker(
                          initial: initial,
                          onChanged: (c) => setState(() => picked = c),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                  TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('OK')),
                ],
              ),
            );

            if (confirmed == true) {
              onColorChanged(_colorToHex(picked));
            }
          },
          customBorder: const CircleBorder(),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: displayColor,
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : Icon(Icons.palette_outlined, size: 14, color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}

class _HslColorPicker extends StatefulWidget {
  final Color initial;
  final ValueChanged<Color> onChanged;

  const _HslColorPicker({required this.initial, required this.onChanged});

  @override
  State<_HslColorPicker> createState() => _HslColorPickerState();
}

class _HslColorPickerState extends State<_HslColorPicker> {
  late double _hue;
  late double _sat;
  late double _light;

  @override
  void initState() {
    super.initState();
    final hsl = HSLColor.fromColor(widget.initial);
    _hue = hsl.hue;
    _sat = hsl.saturation;
    _light = hsl.lightness;
  }

  Color get _current => HSLColor.fromAHSL(1, _hue, _sat, _light).toColor();

  void _notify() => widget.onChanged(_current);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SliderRow(label: 'H', value: _hue, min: 0, max: 360, onChanged: (v) { setState(() => _hue = v); _notify(); }),
        _SliderRow(label: 'S', value: _sat, min: 0, max: 1, onChanged: (v) { setState(() => _sat = v); _notify(); }),
        _SliderRow(label: 'L', value: _light, min: 0, max: 1, onChanged: (v) { setState(() => _light = v); _notify(); }),
      ],
    );
  }
}

class _SliderRow extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16, child: Text(label, style: const TextStyle(fontSize: 12))),
        Expanded(child: Slider(value: value, min: min, max: max, onChanged: onChanged)),
      ],
    );
  }
}
