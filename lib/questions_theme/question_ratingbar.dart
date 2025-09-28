import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ExperienceRating extends StatefulWidget {
  const ExperienceRating({super.key});

  @override
  State<ExperienceRating> createState() {
    return _RatingBarState();
  }
}

class _RatingBarState extends State<ExperienceRating> {
  double _rating = 3; // store the current rating

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Rate your experience"),
        RatingBar.builder(
          initialRating: _rating,
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
          onRatingUpdate: (value) {
            setState(() => _rating = value);
            // TODO: send `_rating` to your backend or state management
          },
        ),
        const SizedBox(height: 8),
        Text('Your rating: ${_rating.toStringAsFixed(1)}'),
      ],
    );
  }
}
