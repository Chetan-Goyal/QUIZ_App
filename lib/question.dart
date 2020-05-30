import "package:flutter/material.dart";

class Question extends StatelessWidget {
  
  String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
      questionText,
      style: TextStyle(fontSize: 23, ),
      textAlign: TextAlign.center,
      ),
      margin: EdgeInsets.all(10),
      width: double.infinity,
    );
  }
}