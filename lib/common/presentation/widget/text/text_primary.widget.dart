import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UITextPrimaryWidget extends StatelessWidget {
  const UITextPrimaryWidget({
    super.key,
    required this.title,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    this.align,
    this.textOverflow,
    this.maxLines,
    this.textDecoration,
  });

  final String title;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? align;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: GoogleFonts.plusJakartaSans(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ).copyWith(decoration: textDecoration),
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}
