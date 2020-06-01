class QuestionsTrack {
  var currentIndex;

  final questions = [
    {
      'QuestionText': 'What\'s your favourite Colour?',
      'Options': [
        {'OptionText': 'Blue', 'Score': 100},
        {'OptionText': 'Red', 'Score': 70},
        {'OptionText': 'Green', 'Score': 65},
        {'OptionText': 'Black', 'Score': 95},
      ]
    },
    {
      'QuestionText': 'What\'s your favourite language?',
      'Options': [
        {'OptionText': 'C++', 'Score': 90},
        {'OptionText': 'Java', 'Score': 70},
        {'OptionText': 'Python', 'Score': 100},
        {'OptionText': 'Dart', 'Score': 90},
      ]
    },
    {
      'QuestionText': 'What\'s your favourite Working Environment?',
      'Options': [
        {'OptionText': 'Mac OS', 'Score': 85},
        {'OptionText': 'Linux', 'Score': 100},
        {'OptionText': 'Windows', 'Score': 60},
        {'OptionText': 'Chrome OS', 'Score': 55},
      ]
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
    return (questions[this.currentIndex]['Options'] as List)[optionNumber - 1]['OptionText'];
  }
}
