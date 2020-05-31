import "package:flutter/material.dart";
import "./question.dart";
import "./answer.dart";
import './questions.dart';


void main() => runApp(MyApp());


class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}


class _MyAppState extends State<MyApp> {

  QuestionsTrack questionsSet = QuestionsTrack();
  
  void _questionAnswered() {
    setState(() { questionsSet.nextQuestion();}
    );
  }

  @override
  Widget build(BuildContext context){

    return MaterialApp(home: Scaffold(
      appBar: AppBar(
        title: Text('MY QUIZ APP'),
      ),
      body: Column(
        children: [

          // Question Here
          Question(
            questionsSet.currentQuestion(),
          ),
          
          ...(questionsSet.questions[questionsSet.currentIndex]['Options'] as List<String>).map( (answertext) {
           return Answer(_questionAnswered, answertext);
          }).toList()

        ],
      ),
      )
    );
  }
}