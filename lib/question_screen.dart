import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
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

  // Receive the answer the user picked and forward it to the parent via the callback
  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(
      selectedAnswer,
    ); // pass the real selected answer instead of placeholder
    setState(() {
      currentQuestionIndex++; // increment by 1
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
            StepProgressIndicator(
              totalSteps: 15,
              currentStep: 12,
              size: 20,
              selectedColor: Colors.purpleAccent,
              unselectedColor: Colors.black,
              roundedEdges: Radius.circular(10),
              gradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.pink, Colors.white],
              ),
            ),
            const SizedBox(height: 20),
            QuestionText(text: currentQuestion.text),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffledAnswers().map((answer) {
              // Chained
              // Spreading the children list to individual values==> pull them and place them as comma-separated values
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
