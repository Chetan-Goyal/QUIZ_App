import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Answer extends StatelessWidget {

  final String option;
  final Function selectHandler;

  Answer(this.selectHandler, this.option);

  @override
  Widget build(BuildContext context) {
    var container = Container(
    
          child: RaisedButton(
            child: Text(this.option),
            onPressed: selectHandler,
          ),
          width: 200,
        );
        return container;
  }
}