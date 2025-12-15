import 'package:flutter_quill/flutter_quill.dart';

void clearFormatting(QuillController controller) {
  final attrsToUnset = <Attribute>[
    Attribute.bold,
    Attribute.italic,
    Attribute.underline,
    Attribute.strikeThrough,
    Attribute.inlineCode,
    Attribute.link,

    Attribute.ul,
    Attribute.ol,
    Attribute.unchecked,
    Attribute.checked,

    Attribute.leftAlignment,
    Attribute.centerAlignment,
    Attribute.rightAlignment,
    Attribute.justifyAlignment,
  ];

  for (final a in attrsToUnset) {
    controller.formatSelection(Attribute.clone(a, null));
  }
}
