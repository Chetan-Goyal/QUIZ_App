import 'package:flutter/material.dart';
import 'Result_Uploader/upload.dart';

class Result extends StatelessWidget {
  final List answersSelected;
  final List questions;
  final String name;
  final int result;
  final Function resetQuiz;

  Result(this.answersSelected, this.questions, this.name, this.result, this.resetQuiz);

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
    }else {
      finalResult = "WOW. You did it. Congratulations..   :D";
    }
    Uploader uploader = Uploader(answersSelected, questions, name, result);
    uploader.upload();
    return finalResult;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
        FlatButton(
          onPressed: resetQuiz,
          child: Text("Restart Quiz!!"),
          color: Colors.blue,
          textColor: Colors.white,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
