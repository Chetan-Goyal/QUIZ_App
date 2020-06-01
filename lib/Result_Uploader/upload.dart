import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

String baseURL =
    'https://script.google.com/macros/s/AKfycbxnQDz6VQue7XfeeMmsXshBxxm0ZmsFqsHiTvX2ilUuCWScrY0/exec';

class Uploader {
  final String _name;
  final int _score;
  dynamic responseCode;

  Uploader(this._name, this._score);

  String toParams() => "?name=$_name&score=$_score";

  void upload() async{
    try {
      await http.get(baseURL + toParams()).then((response) {
        responseCode = convert.jsonDecode(response.body)['status'];
      });
    } catch (e) {
      print(e);
      responseCode = 500;
    }
    
    print('response: $responseCode');
    if ( responseCode == 200 ) {
      print('Uploaded');
    } else {
      print('CODE: $responseCode \nNot Uploaded');
    }
  }
}
