import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Answer extends StatelessWidget {

  final String answer;
  final Function selectHandler;

  Answer(this.selectHandler, this.answer);

  @override
  Widget build(BuildContext context) {
    var container = Container(
    
          child: RaisedButton(
            child: Text(this.answer),
            onPressed: selectHandler,
          ),
          width: 200,
        );
        return container;
  }
}