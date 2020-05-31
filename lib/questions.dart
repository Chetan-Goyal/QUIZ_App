class QuestionsTrack {

  var currentIndex;

  final questions = [
      {
        'QuestionText':'What\'s your favourite Colour?', 
        'Options':['Blue','Red','Green','Black']
      }, 
      {
        'QuestionText':'What\'s your favourite language?',
        'Options':['C++','JAVA','Python','Dart']
      },
      {
        'QuestionText':'What\'s your favourite Working Environment?',
        'Options':['Mac OS','Linux','Windows','Chrome OS']
      },
  ];
  QuestionsTrack() {
    this.currentIndex = 0;
  } 

  void nextQuestion() {
    this.currentIndex += 1;
  }

  String currentQuestion() {
    return questions[this.currentIndex]['QuestionText'];
  }

  String option(int optionNumber) {
    return (questions[this.currentIndex]['Options'] as List)[optionNumber-1];
  }

}