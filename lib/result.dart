import 'package:flutter/material.dart';

class Result extends StatelessWidget {

  final int result;
  Result(this.result);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Submitted Successfully\nScore: $result"),
    );
  }
}