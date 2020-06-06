import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'question.dart';

class EachResult extends StatelessWidget {
  final int questionIndex;
  final List options;
  final String answerChosen;
  final questionsObj;
  final Function _answerShown;

  EachResult(
      this.questionIndex, this.options, this.answerChosen, this.questionsObj, this._answerShown);

  @override
  Widget build(BuildContext context) {

    // Question Here
    String correctAnswer = questionsObj.correctOption();
    List<Widget> a = [
      Question(
        questionsObj.questions[questionIndex]["QuestionText"],
      ),
    ];

    // Options Here
    for (String option in options) {
      if (option == correctAnswer) {
        a.add(Container(
          child: RaisedButton(
            child: Text(option),
            color: Colors.green[700],
            textColor: Colors.white,
            onPressed: () => _answerShown(questionsObj.score(answerChosen)),
          ),
          width: 200,
        ));
      } else if (option == answerChosen &&
          answerChosen != correctAnswer) {
        a.add(Container(
          child: RaisedButton(
            child: Text(option),
            color: Colors.red[700],
            textColor: Colors.white,
            onPressed: () => _answerShown(questionsObj.score(answerChosen)),
          ),
          width: 200,
        ));
      } else {
        a.add(
          Container(
            child: RaisedButton(
              child: Text(option),
              onPressed: () => _answerShown(questionsObj.score(answerChosen)),
            ),
            width: 200,
          ),
        );
      }
    }

    return Column(children: a);
  }
}
