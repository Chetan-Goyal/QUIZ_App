import 'package:QUIZ_App/eachResult.dart';
import "package:flutter/material.dart";
import './questions.dart';
import 'dart:async';
import "./quiz.dart";
import 'result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Form.dart';
import 'Loader.dart';

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
  final String API_URL =
      "https://opentdb.com/api.php?amount=5&category=18&type=multiple";
  List results;
  List data = [
    Map(),
    Map(),
    Map(),
    Map(),
    Map(),
  ];
  QuestionsTrack _questionsSet = QuestionsTrack();
  bool _started = false;
  int _score = 0;
  String answer;
  bool _answered = false;
  String _name;
  List answersSelected = new List();
  bool _isDataLoaded = false;

  Future<String> getData() async {
    try {
      var res = await http
        .get(Uri.encodeFull(API_URL), headers: {"Accept": "application/json"});
      setState(() {
        var resBody = json.decode(res.body);
        results = resBody["results"];
        for (int i = 0; i < 5; i++) {
          data[i]["QuestionText"] = results[i]["question"];
          data[i]["Options"] = [
            ...(results[i]["incorrect_answers"]),
            results[i]["correct_answer"]
          ];
          data[i]["Options"].shuffle();
          data[i]["CorrectOption"] = results[i]["correct_answer"];
        }
        _questionsSet.questions = data;
        this._isDataLoaded = true;
      });
    } catch(e) {
      getData();
    }
  }

  void _quizStarted(String name) {
    print('Name- $name');
    setState(() {
      this._started = !_started;
      this._name = name;
    });
  }

  void _questionAnswered(String answer) {
    setState(() {
      this.answer = answer;
      this.answersSelected.add(answer);
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
      getData();
      _score = 0;
      _questionsSet.currentIndex = 0;
      _answered = false;
      this.answer = null;
      _isDataLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_started == false) {
      return MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: Text('MY QUIZ APP'),
        ),
        body: UserInfo(_quizStarted),
      ));
    } else if (this._isDataLoaded == false) {
      return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('MY QUIZ APP'),
            ),
            body: Center(
              child: ColorLoader(colors: Colors.primaries, duration: Duration(seconds: 5)),
            ),
          ),
      );
    }
    if (_answered == true && answer != null) {
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
    } else {
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
                this.answersSelected,
                this._questionsSet.questions,
                this._name,
                (_score / _questionsSet.questions.length).round(),
                _resetQuiz),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
}
