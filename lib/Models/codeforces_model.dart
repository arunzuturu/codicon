class CodeforcesModal {
  String? status;
  List<Result>? result;

  CodeforcesModal({this.status, this.result});

  CodeforcesModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? contribution;
  int? lastOnlineTimeSeconds;
  int? rating;
  int? friendOfCount;
  String? titlePhoto;
  String? rank;
  String? handle;
  int? maxRating;
  String? avatar;
  int? registrationTimeSeconds;
  String? maxRank;

  Result(
      {this.contribution,
        this.lastOnlineTimeSeconds,
        this.rating,
        this.friendOfCount,
        this.titlePhoto,
        this.rank,
        this.handle,
        this.maxRating,
        this.avatar,
        this.registrationTimeSeconds,
        this.maxRank});

  Result.fromJson(Map<String, dynamic> json) {
    contribution = json['contribution'];
    lastOnlineTimeSeconds = json['lastOnlineTimeSeconds'];
    rating = json['rating'];
    friendOfCount = json['friendOfCount'];
    titlePhoto = json['titlePhoto'];
    rank = json['rank'];
    handle = json['handle'];
    maxRating = json['maxRating'];
    avatar = json['avatar'];
    registrationTimeSeconds = json['registrationTimeSeconds'];
    maxRank = json['maxRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contribution'] = this.contribution;
    data['lastOnlineTimeSeconds'] = this.lastOnlineTimeSeconds;
    data['rating'] = this.rating;
    data['friendOfCount'] = this.friendOfCount;
    data['titlePhoto'] = this.titlePhoto;
    data['rank'] = this.rank;
    data['handle'] = this.handle;
    data['maxRating'] = this.maxRating;
    data['avatar'] = this.avatar;
    data['registrationTimeSeconds'] = this.registrationTimeSeconds;
    data['maxRank'] = this.maxRank;
    return data;
  }
}
