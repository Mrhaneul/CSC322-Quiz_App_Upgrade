import 'package:flutter/material.dart';

import 'package:quiz_app/question_screen.dart';

import 'package:quiz_app/start_screen.dart';

import 'package:quiz_app/data/questions.dart';

import 'package:quiz_app/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

// This State classs and type is closely connected to another class and type
class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';
  bool isDarkMode = false; // automatically set to light mode

  // When switchScreen executed, activeScreen set to QuestionsScreen
  // build method run again
  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode; // Toggle the boolean value
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  // Colors used for dark mode
                  ? [
                      const Color.fromARGB(255, 20, 20, 30),
                      const Color.fromARGB(255, 40, 40, 60),
                    ]
                  // Colors used for light mode
                  : [
                      const Color.fromARGB(255, 255, 251, 30),
                      const Color.fromARGB(255, 92, 74, 255),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Main screen content
              screenWidget,
              // Dark mode button - always in same position
              Positioned(
                top: 50,
                right: 20,
                child: IconButton(
                  onPressed: toggleDarkMode,
                  icon: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: Colors.white,
                    size: 30,
                  ),
                  tooltip: isDarkMode
                      ? 'Switch to Light Mode'
                      : 'Switch to Dark Mode',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
