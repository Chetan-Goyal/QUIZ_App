import "package:flutter/material.dart";
import "./question.dart";
import "./answer.dart";
import "./questions.dart";

void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}




class _MyAppState extends State<MyApp> {

  questionsTrack QuestionsSet = questionsTrack();
  
  void _questionAnswered() {
    setState(() { QuestionsSet.nextQuestion();
              }
            );
  }

  @override
  Widget build(BuildContext context){

    return MaterialApp(home: Scaffold(
      appBar: AppBar(
        title: Text('MY QUIZ APP'),
      ),
      body: Column(
        children: <Widget>[

          // Question Here
          Question(
            QuestionsSet.currentQuestion(),
          ),
          
          // First Option
          Answer(_questionAnswered, QuestionsSet.option(1),),

          // Second Option
          Answer(_questionAnswered, QuestionsSet.option(2),),

          // Third Option
          Answer(_questionAnswered, QuestionsSet.option(3),),

          // Forth Option
          Answer(_questionAnswered, QuestionsSet.option(4),),
          
        ],

      ),
      
      )
    );
  }


}