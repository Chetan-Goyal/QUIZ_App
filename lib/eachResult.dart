import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'question.dart';
import 'package:universal_html/html.dart' as html;

class EachResult extends StatelessWidget {
  final int questionIndex;
  final List options;
  final String answerChosen;
  final questionsObj;
  final Function _answerShown;

  EachResult(
      this.questionIndex, this.options, this.answerChosen, this.questionsObj, this._answerShown);

  String _parseHtmlString(String htmlString) {
    var text = html.Element.span()..appendHtml(htmlString);
    return text.innerText;
  }

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
      option = _parseHtmlString(option);
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

    a.add(
          Container(
            child: RaisedButton(
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 23,
                ),
                
              ),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () => _answerShown(questionsObj.score(answerChosen)),
            ),
          ),
        );

    return Column(children: a);
  }
}
