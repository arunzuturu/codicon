import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mlr_app/Constants.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mlr_app/Screens/dummy_screen.dart';
import 'package:mlr_app/Screens/network_screen.dart';
import 'package:mlr_app/Screens/reminder_screen.dart';

import '../Networking/api.dart';
import '../Networking/profile_api.dart';
import 'Home.dart';
class ErrorCardWidget extends StatelessWidget {
  final String text;
  ErrorCardWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: Container(
        child: Center(
          child: Card(
            color: kCardBgColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                this.text,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressBarWidget extends StatelessWidget {
  final String text;
  ProgressBarWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          color: kCardBgColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: new Text(
                    this.text,
                    style: new TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  margin: EdgeInsets.all(16.0),
                ),
                new CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override

  State<Tabs> createState() => _TabsState();

}

class _TabsState extends State<Tabs> {

  late Future _getTaskAsync1;
  late Future _getTaskAsync2;
  late Future _getTaskAsync3;
  @override
  void initState() {
    _getTaskAsync1 = APIRepository().getProfileCodechef();
    _getTaskAsync2 = APIRepository().getProfileCodeforces();
    _getTaskAsync3 = APIRepository().getProfileLeetCode();
    super.initState();
  }
  
  int _currentIndex = 0;
  final key = new GlobalKey<ScaffoldState>();
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> _children = [];
  @override
  
  Widget build(BuildContext context) {
    _children = [
      FutureBuilder<Contests>(
        future: upcomingContests,
        builder: (contests, snapshot) {
          if (snapshot.hasData) {
            List<Contest> contests = snapshot.data!.contests;
            return HomeScreen(contests: contests, which: "live",);
          } else if (snapshot.hasError) {
            return ErrorCardWidget("No internet!!! Try restarting App.");
          }
          return ProgressBarWidget("Fetching Contests....");
        },
      ),
      FutureBuilder<List<dynamic>>(
        future: Future.wait([liveContests,upcomingContests]),
        builder: (contests, snapshot) {
          if (snapshot.hasData) {
            List<Contest> contests1 = snapshot.data![0]!.contests;
            List<Contest> contests2 = snapshot.data![1]!.contests;
            return NetworkScreen(contests1: contests1, contests2: contests2,);
          } else if (snapshot.hasError) {
            return ErrorCardWidget("No internet!!! Try restarting App.");
          }
          return ProgressBarWidget("Finding Live Contests....");
        },
      ),
      ReminderScreen(),
      FutureBuilder<List<dynamic>>(
        future: Future.wait([_getTaskAsync1,_getTaskAsync2,_getTaskAsync3]),
        // future: Future.wait([APIRepository().getProfileCodechef(),APIRepository().getProfileCodeforces(), APIRepository().getProfileLeetCode()]),
        builder: (contests, snapshot) {
          if (snapshot.hasData) {
            return Dummy(leetcode: snapshot.data![2], codeforces:snapshot.data![1] , codechef: snapshot.data![0],);
          } else if (snapshot.hasError) {
            return ErrorCardWidget("No internet!!! Try restarting App.");
          }
          return ProgressBarWidget("Fetching Data....");
        },
      ),
    ];
    return Scaffold(
      backgroundColor: bgColor,
      body: PageStorage(
        bucket: bucket,
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
            child: GNav(
              onTabChange: (int index) {
             setState(() {
             _currentIndex = index;
             });},
              // rippleColor: Colors.grey[300]!,
              // hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              duration: Duration(milliseconds: 500),
              tabBackgroundColor: buttonColor,
              color: buttonColor,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  textStyle: resourceStyle,
                ),
                GButton(
                  icon: LineIcons.pollH,
                  text: 'Network',
                  textStyle: resourceStyle,
                ),
                GButton(
                  icon: LineIcons.bell,
                  text: 'Reminders',
                  textStyle: resourceStyle,
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                  textStyle: resourceStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // getdata() async {
  //   await Future.delayed(const Duration(milliseconds: 600));
  //   return await ContestsApiRepository().getDataFromInternet();
  // }
  // bottomNavigationBar: BottomNavigationBar(
  // backgroundColor: kMainBgColor,
  // onTap: (int index) {
  // setState(() {
  // _currentIndex = index;
  // });
  // },
  // selectedItemColor: Colors.white,
  // currentIndex: _currentIndex,
  // items: [
  // BottomNavigationBarItem(
  // backgroundColor: kCardBgColor,
  // activeIcon: Image.asset('assets/images/home.png',width: 24,height: 24,color: kNavVioletColor,),
  // icon: Image.asset('assets/images/home.png',width: 24,height: 24,),
  // label: 'Home',
  // ),
  // BottomNavigationBarItem(
  // icon: Icon(Icons.update),
  // label: "New"
  // ),
  // BottomNavigationBarItem(
  // icon: Icon(Icons.done),
  // label: "New"
  // )
  // ],
  // ),
}
