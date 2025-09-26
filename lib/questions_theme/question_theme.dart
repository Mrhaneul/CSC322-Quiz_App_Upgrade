import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontsize;
  final String fontfamily;

  const QuestionText({
    super.key,
    required this.text,
    required this.color,
    required this.fontsize,
    required this.fontfamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        fontfamily,
        //replace it with fontfamily
        color: color, // replace it with color
        fontSize: fontsize,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
