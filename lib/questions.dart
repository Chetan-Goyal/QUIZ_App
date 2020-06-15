class QuestionsTrack {

  // holds (position of current question - 1)
  var currentIndex;

  List questions;
  QuestionsTrack() {
    this.currentIndex = 0;
  }

  void nextQuestion() {
    this.currentIndex += 1;
  }

  String currentQuestion() {
    return questions[this.currentIndex]["QuestionText"];
  }

  List availableOptions({bool prevQues = false}) {
    // returning the list of current options and prev ques if prevQues=true
    if (prevQues == true) {
      return questions[currentIndex - 1]["Options"];
    }
    return questions[currentIndex]["Options"];
  }

  String option(int optionNumber) {
    return (questions[this.currentIndex]["Options"] as List)[optionNumber - 1];
  }

  int score(String answerChosen) {
    // returning the score of current question
    if (questions[currentIndex]["CorrectOption"] == answerChosen) {
        return 100;
      }
    
    return 0;
  }

  String correctOption({bool prevQues = false}) {
    // returning the correct option of current question and of prev ques if prevQues=true
    int quesIndex;
    if (prevQues == true) {
      quesIndex = currentIndex - 1;
    } else {
      quesIndex = currentIndex;
    }
    return questions[quesIndex]["CorrectOption"];
  }
}
