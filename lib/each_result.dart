import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'each_question.dart';
import 'package:universal_html/html.dart' as html;

class EachResult extends StatelessWidget {
  final int questionIndex;
  final List options;
  final String answerChosen;
  final questionsObj;
  final Function _answerShown;

  EachResult(this.questionIndex, this.options, this.answerChosen,
      this.questionsObj, this._answerShown);

  String _parseHtmlString(String htmlString) {
    // returns urldecoded string
    var text = html.Element.span()..appendHtml(htmlString);
    return text.innerText;
  }

  @override
  Widget build(BuildContext context) {

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
        // if current option is correct option
        a.add(Container(
          child: RaisedButton(
            child: Text(decodedOption),
            color: Colors.green[700],
            textColor: Colors.white,
            onPressed: () {},
            padding: EdgeInsets.all(5),
          ),
          margin: EdgeInsets.only(top: 5, bottom: 5),
          width: 200,
        ));
      } else if (option == answerChosen && answerChosen != correctAnswer) {
        // if current option is chosen option and is incorrect
        a.add(Container(
          child: RaisedButton(
            child: Text(decodedOption),
            color: Colors.red[700],
            textColor: Colors.white,
            onPressed: () {},
            padding: EdgeInsets.all(5),
          ),
          margin: EdgeInsets.only(top: 5, bottom: 5),
          width: 200,
        ));
      } else {
        // if current option is neither correct option nor chosen option
        a.add(
          Container(
            child: RaisedButton(
              child: Text(decodedOption),
              onPressed: () {},
              padding: EdgeInsets.all(5),
            ),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            width: 200,
          ),
        );
      }
    }

    // Submit button
    a.add(
      Container(
        child: FloatingActionButton(
          onPressed: () => _answerShown(questionsObj.score(answerChosen)),
          tooltip: 'Submit',
          child: Icon(Icons.send),
        ),
      ),
    );

    // returning the final widget tree
    return Column(children: a);
  }
}
