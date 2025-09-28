import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:quiz_app/questions_theme/question_theme.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
  });

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  List<String> shuffledAnswers = [];

  @override
  void initState() {
    super.initState();
    // Shuffle answers only once when the screen is created
    shuffledAnswers = questions[currentQuestionIndex].getShuffledAnswers();
  }

  // Receive the answer the user picked and forward it to the parent via the callback
  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(
      selectedAnswer,
    ); // pass the real selected answer instead of placeholder
    setState(() {
      currentQuestionIndex++; // increment by 1
      // Shuffle answers for the next question (if there is one)
      if (currentQuestionIndex < questions.length) {
        shuffledAnswers = questions[currentQuestionIndex].getShuffledAnswers();
      }
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity, // be wide as possible
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuestionText(
              text: currentQuestion.text,
              fontsize: 24,
              fontfamily: 'B612',
              color: const Color.fromARGB(255, 255, 231, 92),
            ),
            const SizedBox(height: 30),
            ...shuffledAnswers.map((answer) {
              // Use pre-shuffled answers instead of shuffling every rebuild
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  answerQuestion(answer);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
