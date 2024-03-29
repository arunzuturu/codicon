import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mlr_app/Networking/api.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DetailScreen extends StatefulWidget {
  final Contest contest;
  const DetailScreen({Key? key, required this.contest}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();


}

String formattedTime(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  String result = "$h:$m:$s";

  return result;
}

class _DetailScreenState extends State<DetailScreen> {

  late final _notfications = FlutterLocalNotificationsPlugin();
   void onSelectNotification(String? payload) => LaunchUrl(payload!, context);

  _scheduleNotification(String start, String event, Contest resource, String href, int duration) async {
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    print(start);
    var android = const AndroidNotificationDetails('channel id', 'channel name');
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    var formats =  DateTime.parse(start).subtract(const Duration(hours: 1)).toString();
    var time = tz.TZDateTime.parse(tz.local, formats);
    await _notfications.zonedSchedule(
        Random().nextInt(200),
        'The Competition $event is going to start in 1 Hour on ${resource.resource}',
        'Be Prepared - Best of Luck - $time',
        time,
        platform,
        payload: href, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidAllowWhileIdle: true);
  }
   Future showNotification({
      int id=0,
      String? title,
      String? body,
      String? payload,}) async => _notfications.show(id, title, body,const NotificationDetails(
     android: AndroidNotificationDetails('channel_id','channel_name',channelDescription: "Yoyo", importance: Importance.max),
     iOS: IOSNotificationDetails(),
   ));



  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    // _notfications = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android,iOS: iOS);
    _notfications.initialize(initSettings, onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    var duration = formattedTime(widget.contest.duration!.toInt());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              // SizedBox(height: size.height*0.08,),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 20),
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, size: 30,color: Colors.white,),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Contest Details",
                      style: EventStyle?.copyWith(fontSize: 24),
                    )),
              ),
              SizedBox(
                height: size.height * 0.030,
              ),

              Container(
                height: size.height * 0.65,
                width: size.width * 0.92,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: buttonColor.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 16.0,
                        offset: const Offset(0, 5))
                  ],
                  borderRadius: BorderRadius.circular(11),
                  color: buttonColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.010,
                        ),
                        Text(
                          widget.contest.event.toString(),
                          style: EventStyle2,
                        ),
                        SizedBox(
                          height: size.height * 0.050,
                        ),
                        Text(
                          "Start :           ${widget.contest.start.toString().substring(0,16)}",
                          style: resourceStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Text(
                          "Ends :           ${widget.contest.end.toString().substring(0,16)}",
                          style: resourceStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Text(
                          "Resource:  ${widget.contest.resource}",
                          style: resourceStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Text(
                          "Duration:   $duration  (Hours:Min:Sec)",
                          style: resourceStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: size.height * 0.030,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            DateTime start = DateTime.parse(widget.contest.start.toString());
                            DateTime end = DateTime.parse(widget.contest.end.toString());
                            if (start
                                .difference(DateTime.now()) <
                                Duration(hours: 1)) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Live Contest!, Cannot set reminder")));
                            }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Do you wish to set a reminder?"),
                                  action: SnackBarAction(
                                    label: "Yes", onPressed: () {
                                    _scheduleNotification(
                                      widget.contest.start.toString(),
                                      widget.contest.event.toString(),
                                      widget.contest,
                                      widget.contest.href.toString(),
                                      widget.contest.duration!.toInt(),
                                    );
                                    print(_notfications.pendingNotificationRequests());
                                    showNotification(title: "Notification is Set", body: "You will be reminded 1hr before contest!", payload: "yay");
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Notification set")));
                                  },
                                  ),

                                ));
                              }
                          },
                          child: SizedBox(
                            width: size.width * 0.36,
                            height: size.height*0.05,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    LineIcons.bell,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Set Reminder",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),),

                        ),
                        SizedBox(
                          height: size.height * 0.010,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Reported!")));
                          },
                          child: SizedBox(
                            width: size.width * 0.35,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    LineIcons.ban,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Report !",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              primary: const Color(0xffF72C25)),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              ElevatedButton(
                onPressed: () {
                  _launchUrl();
                },
                child: SizedBox(
                  width: size.width * 0.30,
                  height: size.height * 0.06,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          LineIcons.alternateExternalLink,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Visit Link ",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(primary: buttonColor),
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _launchUrl() async {
    final Uri _url = Uri.parse(widget.contest.href.toString());
    if (!await launchUrl(_url,mode: LaunchMode.externalApplication,)) throw 'Could not launch $_url';
  }

  LaunchUrl(String href, BuildContext context) async {
    if (await canLaunch(href)) {
      await launch(href);
    } else {

      var snackBar = SnackBar(
        action: SnackBarAction(
          onPressed: () {},
          label: 'Okay',
        ),
        content: Text('Cannot Redirect you to $href', style: TextStyle()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
