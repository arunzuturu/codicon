class LeetCodeModel {
  String? status;
  String? ranking;
  String? totalProblemsSubmitted;
  String? totalProblemsSolved;
  String? acceptanceRate;
  String? easyProblemsSubmitted;
  String? easyQuestionsSolved;
  String? easyAcceptanceRate;
  String? totalEasyQuestions;
  String? mediumProblemsSubmitted;
  String? mediumQuestionsSolved;
  String? mediumAcceptanceRate;
  String? totalMediumQuestions;
  String? hardProblemsSubmitted;
  String? hardQuestionsSolved;
  String? hardAcceptanceRate;
  String? totalHardQuestions;
  String? contributionPoints;
  String? contributionProblems;
  String? contributionTestcases;
  String? reputation;

  LeetCodeModel(
      {this.status,
        this.ranking,
        this.totalProblemsSubmitted,
        this.totalProblemsSolved,
        this.acceptanceRate,
        this.easyProblemsSubmitted,
        this.easyQuestionsSolved,
        this.easyAcceptanceRate,
        this.totalEasyQuestions,
        this.mediumProblemsSubmitted,
        this.mediumQuestionsSolved,
        this.mediumAcceptanceRate,
        this.totalMediumQuestions,
        this.hardProblemsSubmitted,
        this.hardQuestionsSolved,
        this.hardAcceptanceRate,
        this.totalHardQuestions,
        this.contributionPoints,
        this.contributionProblems,
        this.contributionTestcases,
        this.reputation});

  LeetCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    ranking = json['ranking'];
    totalProblemsSubmitted = json['total_problems_submitted'];
    totalProblemsSolved = json['total_problems_solved'];
    acceptanceRate = json['acceptance_rate'];
    easyProblemsSubmitted = json['easy_problems_submitted'];
    easyQuestionsSolved = json['easy_questions_solved'];
    easyAcceptanceRate = json['easy_acceptance_rate'];
    totalEasyQuestions = json['total_easy_questions'];
    mediumProblemsSubmitted = json['medium_problems_submitted'];
    mediumQuestionsSolved = json['medium_questions_solved'];
    mediumAcceptanceRate = json['medium_acceptance_rate'];
    totalMediumQuestions = json['total_medium_questions'];
    hardProblemsSubmitted = json['hard_problems_submitted'];
    hardQuestionsSolved = json['hard_questions_solved'];
    hardAcceptanceRate = json['hard_acceptance_rate'];
    totalHardQuestions = json['total_hard_questions'];
    contributionPoints = json['contribution_points'];
    contributionProblems = json['contribution_problems'];
    contributionTestcases = json['contribution_testcases'];
    reputation = json['reputation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['ranking'] = this.ranking;
    data['total_problems_submitted'] = this.totalProblemsSubmitted;
    data['total_problems_solved'] = this.totalProblemsSolved;
    data['acceptance_rate'] = this.acceptanceRate;
    data['easy_problems_submitted'] = this.easyProblemsSubmitted;
    data['easy_questions_solved'] = this.easyQuestionsSolved;
    data['easy_acceptance_rate'] = this.easyAcceptanceRate;
    data['total_easy_questions'] = this.totalEasyQuestions;
    data['medium_problems_submitted'] = this.mediumProblemsSubmitted;
    data['medium_questions_solved'] = this.mediumQuestionsSolved;
    data['medium_acceptance_rate'] = this.mediumAcceptanceRate;
    data['total_medium_questions'] = this.totalMediumQuestions;
    data['hard_problems_submitted'] = this.hardProblemsSubmitted;
    data['hard_questions_solved'] = this.hardQuestionsSolved;
    data['hard_acceptance_rate'] = this.hardAcceptanceRate;
    data['total_hard_questions'] = this.totalHardQuestions;
    data['contribution_points'] = this.contributionPoints;
    data['contribution_problems'] = this.contributionProblems;
    data['contribution_testcases'] = this.contributionTestcases;
    data['reputation'] = this.reputation;
    return data;
  }
}
