import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Answer extends StatelessWidget {
  final String answer;
  final Function selectHandler;
  final int score;

  Answer(this.selectHandler, this.answer, this.score);

  @override
  Widget build(BuildContext context) {
    var container = Container(
      child: RaisedButton(
        child: Text(this.answer),
        onPressed: () => selectHandler(this.score),
      ),
      width: 200,
    );
    return container;
  }
}
