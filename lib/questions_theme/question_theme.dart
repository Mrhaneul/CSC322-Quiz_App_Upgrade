import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionText extends StatelessWidget {
  final String text;

  const QuestionText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.b612(
        color: const Color.fromARGB(255, 234, 255, 151),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
