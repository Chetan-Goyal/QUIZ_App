import "package:flutter/material.dart";
import './questions.dart';
import "./quiz.dart";
import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  QuestionsTrack _questionsSet = QuestionsTrack();
  int _score = 0;

  void _questionAnswered(int score) {
    setState(() {
      _score += score;
      _questionsSet.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('MY QUIZ APP'),
      ),
      body: _questionsSet.currentIndex < _questionsSet.questions.length
          ? Quiz(
              questions: _questionsSet.questions,
              answerQuestion: _questionAnswered,
              questionIndex: _questionsSet.currentIndex,
            )
          : Result( (_score/_questionsSet.questions.length).round() ),
    ));
  }
}
