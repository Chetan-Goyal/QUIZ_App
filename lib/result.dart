import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int result;
  Result(this.result);

  String get resultText {
    String finalResult;
    if (result < 65) {
      finalResult = "You are completely Different.";
    } else if (result < 75) {
      finalResult = "You are not so bad";
    } else if (result < 85) {
      finalResult = "You seems to be good";
    } else if (result < 95) {
      finalResult = "You are very good";
    } else {
      finalResult = "You are amazing";
    }
    return finalResult;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        resultText,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
