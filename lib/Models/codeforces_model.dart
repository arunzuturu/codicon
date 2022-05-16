class CodeforcesModal {
  String? status;
  String? username;
  String? platform;
  int? rating;
  int? maxRating;
  String? rank;
  String? maxRank;
  List<Contests>? contests;

  CodeforcesModal(
      {this.status,
        this.username,
        this.platform,
        this.rating,
        this.maxRating,
        this.rank,
        this.maxRank,
        this.contests});

  CodeforcesModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    username = json['username'];
    platform = json['platform'];
    rating = json['rating'];
    maxRating = json['max rating'];
    rank = json['rank'];
    maxRank = json['max rank'];
    if (json['contests'] != null) {
      contests = <Contests>[];
      json['contests'].forEach((v) {
        contests!.add(new Contests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['username'] = this.username;
    data['platform'] = this.platform;
    data['rating'] = this.rating;
    data['max rating'] = this.maxRating;
    data['rank'] = this.rank;
    data['max rank'] = this.maxRank;
    if (this.contests != null) {
      data['contests'] = this.contests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contests {
  String? contest;
  String? rank;
  String? solved;
  String? ratingChange;
  String? newRating;

  Contests(
      {this.contest,
        this.rank,
        this.solved,
        this.ratingChange,
        this.newRating});

  Contests.fromJson(Map<String, dynamic> json) {
    contest = json['Contest'];
    rank = json['Rank'];
    solved = json['Solved'];
    ratingChange = json['Rating Change'];
    newRating = json['New Rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Contest'] = this.contest;
    data['Rank'] = this.rank;
    data['Solved'] = this.solved;
    data['Rating Change'] = this.ratingChange;
    data['New Rating'] = this.newRating;
    return data;
  }
}
