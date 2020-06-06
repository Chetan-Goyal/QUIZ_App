import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final Function _submitButton;
  UserInfo(
    this._submitButton,
  );

  @override
  Widget build(BuildContext context) {
    String value;
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          'Enter your Name',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Name'),
          onChanged: (String text) {
            value = text;
          },
          onSubmitted: (String text) {
            value = text;
          },
        ),
        RaisedButton(
            onPressed: () => _submitButton(value), child: Text("Submit")),
      ],
    ));
  }
}
