import 'package:flutter/material.dart';
import 'categories_data.dart';

class UserInfo extends StatefulWidget {
  final Function _submitButton;
  final Function categoryChanged;
  final String name;
  final String category;
  UserInfo(
    this._submitButton,
    this.categoryChanged,
    this.name,
    this.category,
  );

  @override
  _UserInfoState createState() {
    return _UserInfoState(this.categoryChanged, this.name);
  }
}

class _UserInfoState extends State<UserInfo> {
  final Function categoryChanged;
  final String name;
  _UserInfoState(this.categoryChanged, this.name);

  String _dropDownValue;

  CategoriesData _dataObj = CategoriesData();

  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
  }

  @override
  Widget build(BuildContext context) {
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
          controller: _nameController,
          decoration: InputDecoration(hintText: 'Name'),
        ),
        SizedBox(height: 30),
        Row(
          children: <Widget>[
            Text(
              "Category:     ",
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton(
              value: getCategory(),
              hint: _dropDownValue == null && widget.category == null
                  ? Text('Random Category')
                  : Text(
                      getCategory() ?? '',
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
                  _dropDownValue = _dataObj.myList[val];
                  categoryChanged(_dataObj.myList[val]);
                });
              },
              // },
            )
          ],
        ),
        SizedBox(height: 30),
        RaisedButton(
            onPressed: () => widget._submitButton(_nameController.text),
            child: Text("Submit")),
      ],
    ));
  }

  String getCategory() {
    String key = _dropDownValue ?? widget.category;

    final result = _dataObj.myList.entries.map((data) {
      if (key == data.value) {
        return data.key;
      }
    }).toList();
    return result.firstWhere((element) => element != null);
  }
}
