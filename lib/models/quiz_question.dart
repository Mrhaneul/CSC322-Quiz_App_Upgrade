// Works as a blueprint data structure for all the questions
class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    //List as type and a class
    final shuffledList = List.of(answers);
    shuffledList
        .shuffle(); // Copied the list and shuffled - Original list not altered //Chaining
    return shuffledList;
  }
}
