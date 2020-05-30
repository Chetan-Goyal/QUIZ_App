import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './questions.dart';
import './main.dart';

class Answer extends StatelessWidget {

  questionsTrack QuestionsSet;
  String Option;

  final Function SelectHandler;

  Answer(this.SelectHandler, this.Option);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: RaisedButton(
        child: Text(this.Option),
        onPressed: SelectHandler,
      ),
      width: 200,
      alignment: null,
    );
  }
}