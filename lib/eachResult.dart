import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'question.dart';

class EachResult extends StatelessWidget {
  final int questionIndex;
  final List options;
  final String answerChosen;
  final questionsObj;

  EachResult(
      this.questionIndex, this.options, this.answerChosen, this.questionsObj);
  var resultWidget;

  @override
  Widget build(BuildContext context) {
      // Question Here
      String correctAnswer = questionsObj.correctOption(prevQues: true);
      List<Widget> a = [Question(
        questionsObj.questions[questionIndex]["QuestionText"],
      ),];

      // Options Here
      for ( Map option in options ) {
        print('... wali statements');
        print('Correct OPtion: $correctAnswer // $questionIndex');
        if (option["OptionText"] == correctAnswer) {
          print('IFF');
          a.add( Container(
            child: RaisedButton(
              child: Text(option["OptionText"]),
              color: Colors.green[700],
              textColor: Colors.white,
              onPressed: () => null,
            ),
            width: 200,
          ));
        } else if (option["OptionText"] == answerChosen &&
            answerChosen != correctAnswer) {
            print('ELSE IF');
          a.add( Container(
            child: RaisedButton(
              child: Text(option["OptionText"]),
              color: Colors.red[700],
              textColor: Colors.white,
              onPressed: () => null,
            ),
            width: 200,
          ));
        } else {
          print('ELSE');
          a.add( Container(
            child: RaisedButton(
              child: Text(option["OptionText"]),
              onPressed: () => null,
            ),
            width: 200,
          ),);
        }
      }

    return Column(children: a);
 }
}