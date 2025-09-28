import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/questions_summary.dart';
import 'package:quiz_app/questions_theme/question_theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;

  // Map ==> key pair values
  // Returns list of maps
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      ); // A value is expected to create a Map value
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] ==
          data['correct_answer']; // true if data should be kept, and false if data should be dropped
    }).length; // num of questions

    return SizedBox(
      width: double.infinity, // be wide as possible
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionText(
              text:
                  'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              color: Colors.white,
              fontsize: 24,
              fontfamily: 'B612',
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(summaryData),
            const SizedBox(height: 30),

            const SizedBox(height: 24),

            QuestionText(
              text: "Please rate this app!",
              color: Colors.white,
              fontsize: 24,
              fontfamily: 'B612',
            ),

            RatingBar.builder(
              initialRating: 5,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  default:
                    return Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                }
              },
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Want to Review the Wrong Questions?'),
            ),
          ],
        ),
      ),
    );
  }
}
