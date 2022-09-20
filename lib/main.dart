
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mlr_app/Screens/Onboarding/landing.dart';
import 'package:mlr_app/shared_pref.dart';
import 'Screens/navigation.dart';


Future<void> main() async {
  // AwesomeNotifications().initialize(
  //   null,
  //     [
  //       NotificationChannel(
  //           channelGroupKey: 'basic_channel_group',
  //           channelKey: 'basic_channel',
  //           channelName: 'Basic notifications',
  //           channelDescription: 'Notification channel for basic tests',
  //           defaultColor: Color(0xFF9D50DD),
  //           ledColor: Colors.white)
  //     ],
  //     // Channel groups are only visual and are not required
  //     channelGroups: [
  //       NotificationChannelGroup(
  //           channelGroupkey: 'basic_channel_group',
  //           channelGroupName: 'Basic group')
  //     ],
  //     debug: true
  //
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? codeforces="";
  String? codechef="";
  String? leetcode="";
  bool first = true;
  @override
  void initState() {
    getFirst();
    getValues();
    // TODO: implement initState
    super.initState();
  }
  void getValues() async
  {
    var codec = await SharedPref().codechefGetUser();
    var codef = await SharedPref().codeforcesGetUser();
    var leet = await SharedPref().leetCodeGetUser();
    setState(() {
      codeforces = codef.toString();
      leetcode = leet.toString();
      codechef = codec.toString();
    });
  }
  void getFirst() async
  {
    bool k = await SharedPref().isFirstTimeUser();
    setState(() {
      first = k;
      print(first);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: first? Landing(first: first,):Tabs(codeforces: codeforces,codechef: codechef,leetcode: leetcode,),
    );
  }
}
