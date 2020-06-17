import 'package:flutter/material.dart';
import 'categories_data.dart';

class UserInfo extends StatefulWidget {
  final Function _submitButton;
  final Function categoryChanged;
  UserInfo(
    this._submitButton,
    this.categoryChanged,
  );

  @override
  _UserInfoState createState() {
    return _UserInfoState(this.categoryChanged);
  }
}

class _UserInfoState extends State<UserInfo> {
  final Function categoryChanged;
  _UserInfoState(this.categoryChanged);

  String _dropDownValue;

  CategoriesData _dataObj = CategoriesData();

  @override
  Widget build(BuildContext context) {
    String value;
    return Center(
        child: Column(
      children: <Widget>[
        SizedBox(height: 50),
        Text(
          'Enter your Name',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
        SizedBox(height: 30),
        Row(
          children: <Widget>[
            Text(
              "Category:     ",
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton(
              hint: _dropDownValue == null
                  ? Text('Random Category')
                  : Text(
                      _dropDownValue,
                      style: TextStyle(color: Colors.purple),
                    ),
              // isExpanded: true,
              iconSize: 50.0,
              itemHeight: 50,
              dropdownColor: Colors.grey[350],
              style: TextStyle(color: Colors.purple, fontSize: 16),
              items: _dataObj.myList.keys.map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(() {
                  _dropDownValue = val;
                  categoryChanged(_dataObj.myList[val]);
                });
              },
              // },
            )
          ],
        ),
        SizedBox(height: 30),
        RaisedButton(
            onPressed: () => widget._submitButton(value),
            child: Text("Submit")),
      ],
    ));
  }
}
