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
    a.add(SizedBox(height: 30));
    // Options Here
    for (String option in options) {
      String decodedOption = _parseHtmlString(option);
      if (option == correctAnswer) {
        a.add(Container(
          child: RaisedButton(
            child: Text(decodedOption),
            color: Colors.green[700],
            textColor: Colors.white,
            onPressed: () {},
          ),
          width: 200,
        ));
      } else if (option == answerChosen &&
          answerChosen != correctAnswer) {
        a.add(Container(
          child: RaisedButton(
            child: Text(decodedOption),
            color: Colors.red[700],
            textColor: Colors.white,
            onPressed: () {},
          ),
          width: 200,
        ));
      } else {
        a.add(
          Container(
            child: RaisedButton(
              child: Text(decodedOption),
              onPressed: () {},
            ),
            width: 200,
          ),
        );
      }
    }

    a.add(
          Container(
            child: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
              onPressed: () => _answerShown(questionsObj.score(answerChosen)),
              tooltip: 'Submit',
              child: Icon(Icons.send),
            ),
          ),
        );

    return Column(children: a);
  }
}
