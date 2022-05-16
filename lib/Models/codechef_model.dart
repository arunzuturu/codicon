class CodechefModal {
  String? status;
  List<Res>? res;

  CodechefModal({this.status, this.res});

  CodechefModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['res'] != null) {
      res = <Res>[];
      json['res'].forEach((v) {
        res!.add(new Res.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.res != null) {
      data['res'] = this.res!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Res {
  String? name;
  String? rating;
  String? username;
  String? country;
  String? state;
  String? city;
  String? studentProfessional;
  String? institution;

  Res(
      {this.name,
        this.rating,
        this.username,
        this.country,
        this.state,
        this.city,
        this.studentProfessional,
        this.institution});

  Res.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    rating = json['Rating'];
    username = json['Username'];
    country = json['Country'];
    state = json['State'];
    city = json['City'];
    studentProfessional = json['Student/Professional'];
    institution = json['Institution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Rating'] = this.rating;
    data['Username'] = this.username;
    data['Country'] = this.country;
    data['State'] = this.state;
    data['City'] = this.city;
    data['Student/Professional'] = this.studentProfessional;
    data['Institution'] = this.institution;
    return data;
  }
}
