import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './questions.dart';

class Answer extends StatelessWidget {

  questionsTrack QuestionsSet;
  int optionNumber;

  Answer(this.QuestionsSet, this.optionNumber);

  // void AnswerSelected(String Option) {

  //   print('Answer Selected- $Option');
    
  // }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: RaisedButton(
        child: Text(QuestionsSet.option(optionNumber)),
        onPressed: () => QuestionsSet.nextQuestion,
      ),
      
    );
  }
}