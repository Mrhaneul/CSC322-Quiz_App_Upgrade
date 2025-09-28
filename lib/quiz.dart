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
  List<String> reviewAnswers = [];
  List<int> wrongIndexes = [];
  bool isReviewing = false;

  // see all the the wrong questions after the user finishes the quiz and save it to a list
  void reviewQuiz() {
    final preWrong = List<int>.from(wrongIndexes);
    wrongIndexes = [];

    if (!isReviewing) {
      for (var i = 0; i < selectedAnswers.length && i < questions.length; i++) {
        final correct = questions[i].answers[0];
        if (selectedAnswers[i] != correct) {
          wrongIndexes.add(i);
        }
      }
    } else {
      for (var i = 0; i < selectedAnswers.length && i < preWrong.length; i++) {
        final qIdx = preWrong[i];
        final correct = questions[qIdx].answers[0];
        if (selectedAnswers[i] != correct) {
          wrongIndexes.add(qIdx);
        }
      }
    }
    setState(() {
      isReviewing = true;
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

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
    final total = isReviewing ? wrongIndexes.length : questions.length;
    if (selectedAnswers.length == total) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      wrongIndexes = [];
      isReviewing = false;
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);
    final questionSet = isReviewing
        ? [for (final i in wrongIndexes) questions[i]]
        : questions;

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
        questions: questionSet,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onReview: reviewQuiz,
        onRestart: restartQuiz,
        summaryOverride: isReviewing
            ? [
                for (var i = 0; i < questionSet.length; i++)
                  {
                    'question_index': wrongIndexes[i],
                    'question': questionSet[i].text,
                    'correct_answer': questionSet[i].answers[0],
                    'user_answer': selectedAnswers[i],
                  },
              ]
            : null,
        totalQuestionsOverride: isReviewing ? questionSet.length : null,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 7, 131, 255),
                Color.fromARGB(255, 164, 112, 255),
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
