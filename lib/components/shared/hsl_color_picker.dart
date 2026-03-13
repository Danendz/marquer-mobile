import 'package:flutter/material.dart';

class HslColorPicker extends StatefulWidget {
  final Color initial;
  final ValueChanged<Color> onChanged;

  const HslColorPicker({super.key, required this.initial, required this.onChanged});

  @override
  State<HslColorPicker> createState() => _HslColorPickerState();
}

class _HslColorPickerState extends State<HslColorPicker> {
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

  @override
  void didUpdateWidget(HslColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initial != oldWidget.initial) {
      final hsl = HSLColor.fromColor(widget.initial);
      setState(() {
        _hue = hsl.hue;
        _sat = hsl.saturation;
        _light = hsl.lightness;
      });
    }
  }

  Color get _current => HSLColor.fromAHSL(1, _hue, _sat, _light).toColor();

  void _notify() => widget.onChanged(_current);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HslSliderRow(label: 'H', value: _hue, min: 0, max: 360, onChanged: (v) { setState(() => _hue = v); _notify(); }),
        HslSliderRow(label: 'S', value: _sat, min: 0, max: 1, onChanged: (v) { setState(() => _sat = v); _notify(); }),
        HslSliderRow(label: 'L', value: _light, min: 0, max: 1, onChanged: (v) { setState(() => _light = v); _notify(); }),
      ],
    );
  }
}

class HslSliderRow extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const HslSliderRow({
    super.key,
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
