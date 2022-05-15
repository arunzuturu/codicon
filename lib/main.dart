import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


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
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: Tabs(),
    );
  }
}
