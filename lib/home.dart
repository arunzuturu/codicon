import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'model.dart';
import 'Student/student.dart';
import 'Teacher/teacher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  @override
  Widget build(BuildContext context) {
    return contro();
  }
}

class contro extends StatefulWidget {
  contro();

  @override
  _controState createState() => _controState();
}

class _controState extends State<contro> {
  _controState();
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _subscribed = false;
  UserModel loggedInUser = UserModel();
  var rooll;
  var emaill;
  var id;
  @override
  void initState() {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
    _subscribeToNamelessCoder() async {
      _firebaseMessaging.subscribeToTopic('namelesscoder').then((_) {
        if (mounted) {
          setState(() {
            _subscribed = true;
          });
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            _subscribed = false;
          });
        }
      });
    }

    _unsubscribeToNamelessCoder() async {
      _firebaseMessaging.unsubscribeFromTopic('namelesscoder').then((_) {
        if (mounted) {
          setState(() {
            _subscribed = false;
          });
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            _subscribed = false;
          });
        }
      });
    }
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if(!isAllowed){
    //     showDialog(context: context, builder: (context)=>AlertDialog(
    //       title: Text("Allow Notifications"),
    //       content: Text("our app would like to send notifications"),
    //       actions: [
    //         TextButton(onPressed: (){Navigator.pop(context);}, child: Text(" Dont Allow")),
    //         TextButton(onPressed: ()=>AwesomeNotifications().requestPermissionToSendNotifications().then((_) => Navigator.pop(context)), child: Text("Allow"))
    //       ],
    //     ));
    //   }
    // });
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        rooll = loggedInUser.wrool.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  routing() {
    if (rooll == 'Student') {
      return Student(
        id: id,
      );
    } else {
      return Teacher(
        id: id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CircularProgressIndicator();
    return routing();
  }
}
