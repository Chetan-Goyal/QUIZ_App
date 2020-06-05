import 'package:QUIZ_App/eachResult.dart';
import "package:flutter/material.dart";
import './questions.dart';
import "./quiz.dart";
import 'result.dart';
import 'api-data.dart';

// * Main Function executing the program
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  QuestionsTrack _questionsSet = QuestionsTrack();
  int _score = 0;
  String answer;
  bool _answered = false;
  
  void _questionAnswered(String answer) {
    setState(() {
      this.answer = answer;
    });
  }

  void _nextQuestion(int score) {
    setState(() {
      _score += score;
      _questionsSet.nextQuestion();
    });
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _questionsSet.currentIndex = 0;
      _answered = false;
      this.answer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_answered == false) {
      _answered = true;
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
            : Result(
                (_score / _questionsSet.questions.length).round(), _resetQuiz),
      ));
    } else {
      _answered = false;
      return MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: Text('MY QUIZ APP'),
        ),
        body: EachResult(
            _questionsSet.currentIndex,
            _questionsSet.availableOptions(),
            answer,
            _questionsSet,
            _nextQuestion),
      ));
    }
  }
}
