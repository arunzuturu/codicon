import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mlr_app/Screens/profile_form.dart';
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
  String codeforces="";
  String codechef="";
  String leetcode="";
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
    String codec = await SharedPref().codechefGetUser();
    String codef = await SharedPref().codeforcesGetUser();
    String leet = await SharedPref().leetCodeGetUser();
    setState(() {
      codeforces = codef;
      leetcode = leet;
      codechef = codec;
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
      home: first? ProfileForm(first: first,):Tabs(codeforces: codeforces,codechef: codechef,leetcode: leetcode,),
    );
  }
}
