class QuestionsTrack {

  var currentIndex;

  var questions = [
      [
        'What\'s your favourite Colour?', 
        'Blue', 
        'Red', 
        'Green', 
        'Black',
      ], 
      [
        'What\'s your favourite language?',
        'C++',
        'JAVA',
        'Python',
        'Dart',
      ],
      [
        'What\'s your favourite Working Environment?',
        'Mac OS',
        'Linux',
        'Windows',
        'Chrome OS'
      ],
  ];
  QuestionsTrack() {
    this.currentIndex = 0;
  } 

  void nextQuestion() {
    this.currentIndex += 1;
  }

  String currentQuestion() {
    return questions[this.currentIndex][0];
  }

  String option(int optionNumber) {
    return questions[this.currentIndex][optionNumber];
  }

}