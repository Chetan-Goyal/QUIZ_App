import "package:flutter/material.dart";
import 'package:universal_html/html.dart' as html;

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  String _parseHtmlString(String htmlString) {
    var text = html.Element.span()..appendHtml(htmlString);
    return text.innerText;
  }

  @override
  Widget build(BuildContext context) {
    // Widget for displaying Question
    return Container(
      child: Text(
        _parseHtmlString(questionText),
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      margin: EdgeInsets.all(10),
      width: double.infinity,
    );
  }
}
