import 'package:flutter/material.dart';

class BrandText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const BrandText.header(this.text, {super.key, double? fontSize, this.color, this.textAlign})
      : fontSize = fontSize ?? 32,
        fontWeight = FontWeight.bold;

  const BrandText.body(this.text, {super.key, double? fontSize, this.color, this.textAlign})
      : fontSize = fontSize ?? 16,
        fontWeight = FontWeight.normal;

  const BrandText.caption(this.text, {super.key, double? fontSize, this.color, this.textAlign})
      : fontSize = fontSize ?? 14,
        fontWeight = FontWeight.w400;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? (fontSize >= 28 
            ? colorScheme.onSurface 
            : colorScheme.onSurfaceVariant.withValues(alpha: 0.9)),
        letterSpacing: fontSize >= 28 ? -0.5 : 0,
      ),
    );
  }
}