class LeetCodeModel {
  String? status;
  String? message;
  int? totalSolved;
  int? totalQuestions;
  int? easySolved;
  int? totalEasy;
  int? mediumSolved;
  int? totalMedium;
  int? hardSolved;
  int? totalHard;
  double? acceptanceRate;
  int? ranking;
  int? contributionPoints;
  int? reputation;

  LeetCodeModel(
      {this.status,
        this.message,
        this.totalSolved,
        this.totalQuestions,
        this.easySolved,
        this.totalEasy,
        this.mediumSolved,
        this.totalMedium,
        this.hardSolved,
        this.totalHard,
        this.acceptanceRate,
        this.ranking,
        this.contributionPoints,
        this.reputation});

  LeetCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalSolved = json['totalSolved'];
    totalQuestions = json['totalQuestions'];
    easySolved = json['easySolved'];
    totalEasy = json['totalEasy'];
    mediumSolved = json['mediumSolved'];
    totalMedium = json['totalMedium'];
    hardSolved = json['hardSolved'];
    totalHard = json['totalHard'];
    acceptanceRate = json['acceptanceRate'];
    ranking = json['ranking'];
    contributionPoints = json['contributionPoints'];
    reputation = json['reputation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalSolved'] = this.totalSolved;
    data['totalQuestions'] = this.totalQuestions;
    data['easySolved'] = this.easySolved;
    data['totalEasy'] = this.totalEasy;
    data['mediumSolved'] = this.mediumSolved;
    data['totalMedium'] = this.totalMedium;
    data['hardSolved'] = this.hardSolved;
    data['totalHard'] = this.totalHard;
    data['acceptanceRate'] = this.acceptanceRate;
    data['ranking'] = this.ranking;
    data['contributionPoints'] = this.contributionPoints;
    data['reputation'] = this.reputation;
    return data;
  }
}
