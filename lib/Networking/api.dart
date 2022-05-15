import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Contests> liveContests =
fetchContests("mid", DateTime.now().toUtc().toString(), "-start");
Future<Contests> completedContests =
fetchContests("end__lt", DateTime.now().toUtc().toString(), "-start");
Future<Contests> upcomingContests =
fetchContests("start__gt", DateTime.now().toUtc().toString(), "start");
Future<Contests> fetchContests(
    String param, String today, String orderBy) async {
  print(today);
  var uri;
  if (param == "mid") {
    final queryParameters = {
      'format_time': 'true',
    };
    uri = Uri.https("clist.by", "/api/v1/contest/", {
      "username": "arun_adithya",
      "api_key": "e41f41cc3e6b39884d05b25018b021c2b2c46f25",
      "start__lt": today,
      "end__gt": today,
      "order_by": orderBy,
      "limit": "100",
      "format_time":"true",
    },);
  } else {
    uri = Uri.https(
      "clist.by", "/api/v1/contest/", {
      "username": "arun_adithya",
      "api_key": "e41f41cc3e6b39884d05b25018b021c2b2c46f25",
      param: today,
      "order_by": orderBy,
      "limit": "100",

    },
    );
  }

  var response;
  response = await http.get(uri);
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Contests.fromJSON(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class Contests {
  List<Contest> contests = [];

  Contests.fromJSON(Map<String, dynamic> json) {
    for (var contestjson in json['objects']) {
      var contest = Contest.fromJSON(contestjson);
      if (![
        "sort-me.org",
        'lightoj.com',
        'e-olymp.com',
        "neerc.ifmo.ru",
        "neerc.ifmo.ru/school",
        "yandex.ru",
        "contest.yandex.ru",
        "contest.yandex.ru/CYF",
        "acmp.ru",
        "acmu.ru",
        "dl.gsu.by"
      ].contains(contest.resource)) this.contests.add(contest);
    }
  }
}

class Contest {
  int ?id;
  String? resource;
  String? event;
  DateTime?start;
  DateTime? end;
  int ?duration;
  String ?href;

  Contest({
    this.id,
    this.resource,
    this.event,
    this.start,
    this.end,
    this.duration,
    this.href,
  });

  factory Contest.fromJSON(Map<String, dynamic> json) {
    var start = DateTime.parse(json['start'] + "Z");
    var end = DateTime.parse(json['end'] + "Z");
    return Contest(
      id: json['id'],
      event: json['event'],
      resource: json['resource']['name'],
      start: start.toLocal(),
      end: end.toLocal(),
      duration: json['duration'],
      href: json['href'],
    );
  }
}