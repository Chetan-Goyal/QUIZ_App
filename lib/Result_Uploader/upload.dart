import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

String baseURL =
    'https://script.google.com/macros/s/AKfycbxnQDz6VQue7XfeeMmsXshBxxm0ZmsFqsHiTvX2ilUuCWScrY0/exec';

class Uploader {
  final List answersSelected;
  final List questions;
  final String _name;
  final int _score;
  dynamic responseCode;

  Uploader(this.answersSelected, this.questions, this._name, this._score);

  String toParams() {
    String params = "";

    params = params + "?name=$_name";

    params = params + "&q1=${questions[0]["QuestionText"]}&a1=${questions[0]["CorrectOption"]}&as1=${answersSelected[0]}";
    params = params + "&q2=${questions[1]["QuestionText"]}&a2=${questions[1]["CorrectOption"]}&as2=${answersSelected[1]}";
    params = params + "&q3=${questions[2]["QuestionText"]}&a3=${questions[2]["CorrectOption"]}&as3=${answersSelected[2]}";
    params = params + "&q4=${questions[3]["QuestionText"]}&a4=${questions[3]["CorrectOption"]}&as4=${answersSelected[3]}";
    params = params + "&q5=${questions[4]["QuestionText"]}&a5=${questions[4]["CorrectOption"]}&as5=${answersSelected[4]}";
    
    params = params + "&score=$_score";

    return params;
  }

  void upload() async {
    try {
      await http.get(baseURL + toParams()).then((response) {
        responseCode = convert.jsonDecode(response.body)['status'];
      });
    } catch (e) {
      print(e);
      responseCode = 500;
    }

    print('response: $responseCode');
    if (responseCode == 200) {
      print('Uploaded');
    } else {
      print('CODE: $responseCode \nNot Uploaded');
    }
  }
}
