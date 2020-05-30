class questionsTrack {

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
  ];
  questionsTrack() {
    this.currentIndex = 0;
  } 

  Function nextQuestion() {
    this.currentIndex += 1;
    print('${this.currentIndex}');
  }

  String currentQuestion() {
    return questions[this.currentIndex][0];
  }

  String option(int optionNumber) {
    return questions[this.currentIndex][optionNumber];
  }

}