import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class Answer extends StatelessWidget {
  final String answer;
  final Function selectHandler;

  Answer(this.selectHandler, this.answer);

  String _parseHtmlString(String htmlString) {
    // returning the urldecoded string of htmlString
    // Here, it is used for options
    var text = html.Element.span()..appendHtml(htmlString);
    return text.innerText;
  }

  @override
  Widget build(BuildContext context) {
    // returning the answer widget
    var container = Container(
      child: RaisedButton(
        child: Text(_parseHtmlString(answer), textAlign: TextAlign.center,),
        onPressed: () => selectHandler(answer),
        padding: EdgeInsets.all(5),
      ),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      width: 200,
    );
    return container;
  }
}
