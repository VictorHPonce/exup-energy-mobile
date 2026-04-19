import 'package:flutter/material.dart';

class BrandText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const BrandText.header(this.text, {super.key, this.color, this.textAlign})
      : fontSize = 32, fontWeight = FontWeight.bold;

  const BrandText.body(this.text, {super.key, this.color, this.textAlign})
      : fontSize = 16, fontWeight = FontWeight.normal;

  const BrandText.caption(this.text, {super.key, this.color, this.textAlign})
      : fontSize = 14, fontWeight = FontWeight.w400;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? (fontSize == 32 ? Colors.black87 : Colors.grey[600]),
        letterSpacing: fontSize == 32 ? -0.5 : 0,
      ),
    );
  }
}