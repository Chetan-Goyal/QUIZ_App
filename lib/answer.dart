import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class Answer extends StatelessWidget {
  final String answer;
  final Function selectHandler;

  Answer(this.selectHandler, this.answer);

  String _parseHtmlString(String htmlString) {
    var text = html.Element.span()..appendHtml(htmlString);
    return text.innerText;
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      child: RaisedButton(
        child: Text(_parseHtmlString(answer)),
        onPressed: () => selectHandler(answer),
      ),
      width: 200,
    );
    return container;
  }
}
