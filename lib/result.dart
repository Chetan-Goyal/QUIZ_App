import 'package:flutter/material.dart';
import 'package:quizoy/Result_Uploader/upload.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Result extends StatelessWidget {
  final List answersSelected;
  final List questions;
  final String name;
  final int result;
  final Function resetQuiz;

  Result(this.answersSelected, this.questions, this.name, this.result,
      this.resetQuiz);

  String get resultText {
    String finalResult;
    if (result < 20) {
      finalResult = "You are very BAD in Quiz.   :P";
    } else if (result < 40) {
      finalResult = "You are BAD in Quiz.   :(";
    } else if (result < 60) {
      finalResult = "Nice Attempt!!!";
    } else if (result < 80) {
      finalResult = "You are GOOD!!!";
    } else if (result < 100) {
      finalResult = "You are AMAZING!!!";
    } else {
      finalResult = "WOW. You did it. Congratulations..   :D";
    }

    return finalResult;
  }

  Future<void> uploadResult() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isUploadDisabled') == true) return;
    // Uploading the final result to Google spreadsheet
    Uploader uploader = Uploader(answersSelected, questions, name, result);
    uploader.upload();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // displaying the comments as per the user's attempt
        Center(
          child: Text(
            resultText,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Displaying Score
        Center(
          child: Text(
            "\n\nScore: $result\n\n",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.red[400],
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // for resetting the quiz ( main.dart -> _resetQuiz() )
        FlatButton(
          onPressed: resetQuiz,
          child: Text("Restart Quiz!!"),
          color: Colors.blueGrey,
          textColor: Colors.white,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
