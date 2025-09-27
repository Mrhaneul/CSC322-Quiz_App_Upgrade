import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  // startQuiz --> void Function, it takes no arguments and does not return a value
  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          // Opacity(
          //   opacity: 0.3,
          //   child: Image.asset(
          //     'assets/images/quiz-logo.png',
          //     width: 300,
          //   ),
          // ),
          SizedBox(
            height: 80,
          ),
          Text(
            'Learn Flutter the fun way!',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 194, 108, 255),
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            // Render Content Conditionally
            // Lifting State Up
            // Executed only when the button is pressed
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
    // The Center method takes as much as space as possible
  }
}


// Udemy note
// Flutter's Stateful Widget Lifecycle
// Every Flutter Widget has a built-in lifecycle: A collection of methods that are automatically executed by Flutter (at certain points of time).

// There are three extremely important (stateful) widget lifecycle methods you should be aware of:

// initState(): Executed by Flutter when the StatefulWidget's State object is initialized

// build(): Executed by Flutter when the Widget is built for the first time AND after setState() was called

// dispose(): Executed by Flutter right before the Widget will be deleted (e.g., because it was displayed conditionally)