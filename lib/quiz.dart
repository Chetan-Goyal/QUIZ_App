import 'package:flutter/material.dart';
import 'each_question.dart';
import 'each_answer.dart';

class Quiz extends StatelessWidget {
  final List questions;
  final Function answerQuestion;
  final int questionIndex;
  Quiz(
      {@required this.questions,
      @required this.answerQuestion,
      @required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    // returns a widget for unanswered question
    return Column(
      children: [
        // Question Here
        Question(
          this.questions[this.questionIndex]["QuestionText"],
        ),
        SizedBox(height: 30),
        // Options Here
        ...(this.questions[this.questionIndex]['Options'])
            .map((option) {
          return Answer(answerQuestion, option);
        }).toList()
      ],
    );
  }
}
