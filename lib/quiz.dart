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
  // Store different widgets as variable for to conveniently output them
  // activeScreen set to nothing, could be null
  // Widget? activeScreen;
  // passing switchScreen's pointer to this function as a value to start screen

  // Is used for further initialization task
  // activeScreen set to StartScreen but not initialized
  // (Initialized after the object is created)
  // @override
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState(); // Parent class --> State
  // }

  List<String> selectedAnswers = [];

  var activeScreen = 'start-screen';

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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 67, 11, 163),
                const Color.fromARGB(255, 106, 19, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // activeScreen(StartScreen) displayed
          // activeScreen(QuestionsScreen) displayed if switchScreen is executed
          // if returns true, startScreen, else questionScreen
          child: screenWidget,
        ),
      ),
    );
  }
}
