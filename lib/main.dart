import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizoy/each_result.dart';
import 'package:quizoy/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './questions.dart';
import './quiz.dart';
import './result.dart';
import './Form.dart';
import './Loader.dart';
import './about.dart';

// * Main Function executing the program
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // To make app always in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // Quiz Data Library
  final String apiURL =
      "https://opentdb.com/api.php?amount=5&category=any&type=multiple";
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
  String _name = "";
  List answersSelected = [];
  bool _isDataLoaded = false;
  var _brightness;
  int _retryCount = 0;
  bool _noInternet = false;
  var _body;
  String _category = "any";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getData() async {
    // To get the data from the API with recursive approach for failed attempts

    // Retry Max Limit = 200
    String apiURL = "https://opentdb.com/api.php?amount=5";

    if (_category != "any") {
      apiURL = apiURL + "&category=" + _category;
    }

    apiURL = apiURL + "&type=multiple";

    if (_retryCount > 10) {
      setState(() {
        _noInternet = true;
      });
    } else {
      try {
        var res = await Dio().get(apiURL);

        setState(() {
          // setting the quiz data in correct format from received data
          var resBody = res.data;
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
          _retryCount = 0;
        });
      } catch (e) {
        if (_started) {
          // When data is not loaded in 'Quiz Question Loading Screen'
          _retryCount += 1;
        }
        getData();
      }
    }
  }

  void _quizStarted(String name) {
    prefs.setString('name', name);
    prefs.setString('category', _category);
    setState(() {
      this._started = !_started;
      this.getData();
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
      _started = false;
      _isDataLoaded = false;
      _noInternet = false;
      _retryCount = 0;
      _score = 0;
      _questionsSet.currentIndex = 0;
      _answered = false;
      this.answer = null;
    });
  }

  void _themeChanged({bool question: false}) async {
    await prefs.setBool('isDarkTheme', _brightness == Brightness.dark);

    setState(() {
      if (_brightness == Brightness.dark)
        _brightness = Brightness.light;
      else
        _brightness = Brightness.dark;
      if (question) {
        this._answered = !_answered;
      }
    });
  }

  void _updateTheme() {
    if (prefs.getBool('isDarkTheme'))
      _brightness = Brightness.dark;
    else
      _brightness = Brightness.light;
    setState(() {});
  }

  void _categoryChanged(String newCategory) {
    prefs.setString('category', newCategory);
    setState(() {
      this._category = newCategory;
    });
  }

  bool isInitialised = false;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    super.initState();
    SharedPreferences.getInstance().then((_prefs) async {
      prefs = _prefs;
      _brightness =
          prefs.getBool('isDarkTheme') ? Brightness.dark : Brightness.light;

      _name = prefs.getString('name');
      _category = prefs.getString('category');

      isInitialised = true;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // When Quiz App is just opened
    if (_brightness == null) {
      _brightness = WidgetsBinding.instance.window.platformBrightness;
    }

    // first page when app is started
    if (!_started) {
      _body = UserInfo(_quizStarted, _categoryChanged, _name, _category);
    } else if (!this._isDataLoaded && !_noInternet) {
      // When Question is being loaded
      _body = Center(
        child: ColorLoader(
            colors: Colors.primaries, duration: Duration(seconds: 5)),
      );
    } else if (_noInternet) {
      // When retry limit is reached
      _body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No Internet Connection Found",
              style: TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton(
              onPressed: _resetQuiz,
              color: Colors.blue,
              child: Text("Try Again"),
            ),
          ],
        ),
      );
    } else if (_answered && answer != null) {
      // when question is answered by the user
      _answered = false;
      _body = EachResult(
          _questionsSet.currentIndex,
          _questionsSet.availableOptions(),
          answer,
          _questionsSet,
          _nextQuestion);
    } else {
      // displaying next question to the user and final Result when there
      // are no more questions
      _answered = true;
      _body = _questionsSet.currentIndex < _questionsSet.questions.length
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
              _resetQuiz);
    }

    return MaterialApp(
      theme: ThemeData(
        brightness: _brightness,
        fontFamily: 'Ubuntu',
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'QUIZ APP',
                  style: TextStyle(fontFamily: 'MetalMania'),
                ),
              ),
              // For changing brightness (Light and Dark Mode)
              IconButton(
                icon: Icon(Icons.invert_colors),
                onPressed: _themeChanged,
              ),
            ],
          ),
        ),
        body: !isInitialised
            ? Center(
                child: ColorLoader(
                  colors: Colors.primaries,
                  duration: Duration(seconds: 5),
                ),
              )
            : _body,
        drawer: Builder(builder: (context) {
          return Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Center(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                ),
                ListTile(
                    title: Text("Home"),
                    onTap: () {
                      _resetQuiz();
                      toggleDrawer();
                    }),
                ListTile(
                  title: Text("Settings"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/Setting");
                    _updateTheme();
                  },
                ),
                ListTile(
                  title: Text("About"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/About");
                  },
                ),
              ],
            ),
          );
        }),
      ),
      routes: {
        "/About": (BuildContext context) {
          return AboutPage();
        },
        "/Setting": (BuildContext context) {
          return SettingScreen();
        },
      },
    );
  }

  toggleDrawer() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openEndDrawer();
    } else {
      _scaffoldKey.currentState.openDrawer();
    }
  }
}
