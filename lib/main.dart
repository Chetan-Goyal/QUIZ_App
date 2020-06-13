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
  final String apiURL =
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
  var _brightness;
  int _retryCount = 0;
  bool _noInternet = false;

  void getData() async {
    if (_started) {
      _retryCount += 1;
    }
    if (_retryCount > 40) {
      setState(() {
        _noInternet = true;
      });
    }
    try {
      var res = await http
          .get(Uri.encodeFull(apiURL), headers: {"Accept": "application/json"});
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
    } catch (e) {
      getData();
    }
  }

  void _quizStarted(String name) {
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

  void _themeChanged({bool question: false}) {
    setState(() {
      if (_brightness == Brightness.dark) {
        _brightness = Brightness.light;
      } else {
        _brightness = Brightness.dark;
      }
      if (question) {
        this._answered = !_answered;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_brightness == null) {
      _brightness = WidgetsBinding.instance.window.platformBrightness;
    }

    if (_noInternet && _started) {
      return MaterialApp(
        theme: ThemeData(
          brightness: _brightness,
          fontFamily: 'Ubuntu',
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'QUIZ APP',
                    style: TextStyle(fontFamily: 'MetalMania'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.invert_colors),
                  onPressed: _themeChanged,
                ),
              ],
            ),
          ),
          body: Center(child: Text("No Internet Connection Found")),
        ),
      );
    }

    if (!_started) {
      return MaterialApp(
        theme: ThemeData(
          brightness: _brightness,
          fontFamily: 'Ubuntu',
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'QUIZ APP',
                    style: TextStyle(fontFamily: 'MetalMania'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.invert_colors),
                  onPressed: _themeChanged,
                ),
              ],
            ),
          ),
          body: UserInfo(_quizStarted),
        ),
      );
    } else if (!this._isDataLoaded) {
      return MaterialApp(
        theme: ThemeData(
          brightness: _brightness,
          primarySwatch: Colors.purple,
          fontFamily: 'Ubuntu',
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'QUIZ APP',
                    style: TextStyle(fontFamily: 'MetalMania'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.invert_colors),
                  onPressed: _themeChanged,
                ),
              ],
            ),
          ),
          body: Center(
            child: ColorLoader(
                colors: Colors.primaries, duration: Duration(seconds: 5)),
          ),
        ),
      );
    }
    if (_answered && answer != null) {
      _answered = false;
      return MaterialApp(
          theme: ThemeData(
            brightness: _brightness,
            primarySwatch: Colors.purple,
            fontFamily: 'Ubuntu',
          ),
          home: Scaffold(
            appBar: AppBar(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'QUIZ APP',
                      style: TextStyle(fontFamily: 'MetalMania'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.invert_colors),
                    onPressed: () {
                      _themeChanged(question: true);
                    },
                  ),
                ],
              ),
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
          theme: ThemeData(
            brightness: _brightness,
            primarySwatch: Colors.purple,
            fontFamily: 'Ubuntu',
          ),
          home: Scaffold(
            appBar: AppBar(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'QUIZ APP',
                      style: TextStyle(fontFamily: 'MetalMania'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.invert_colors),
                    tooltip: 'Change Theme',
                    onPressed: () {
                      _themeChanged(question: true);
                    },
                  ),
                ],
              ),
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
