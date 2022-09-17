import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mlr_app/Constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mlr_app/Screens/dummy_screen.dart';
import 'package:mlr_app/Screens/network_screen.dart';
import 'package:mlr_app/Screens/reminder_screen.dart';
import 'package:mlr_app/shared_pref.dart';
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
    return Center(
      child: Card(
        color: kCardBgColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  final codechef;
  final codeforces;
  final leetcode;
  const Tabs({Key? key, this.codechef, this.codeforces, this.leetcode}) : super(key: key);

  @override

  State<Tabs> createState() => _TabsState();

}

class _TabsState extends State<Tabs> {

  late Future _getTaskAsync1;
  late Future _getTaskAsync2;
  late Future _getTaskAsync3;
  late bool first;

  @override
  void initState() {
    _getTaskAsync1 = APIRepository().getProfileCodechef(widget.codechef);
    _getTaskAsync2 = APIRepository().getProfileCodeforces(widget.codeforces);
    _getTaskAsync3 = APIRepository().getProfileLeetCode(widget.leetcode);
    super.initState();
  }

  void getFirst() async
  {
     var k = await SharedPref().isFirstTimeUser();
     setState(() {
       first = k;
     });
  }


  
  int _currentIndex = 0;
  final key = new GlobalKey<ScaffoldState>();
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> _children = [];
  @override
  
  Widget build(BuildContext context) {
    _children = [
      FutureBuilder<List<Contests>>(
        future: Future.wait([liveContests,upcomingContests]),
        builder: (contests, snapshot) {
          if (snapshot.hasData) {
            List<Contest> contests1 = snapshot.data![0].contests;
            List<Contest> contests2 = snapshot.data![1].contests;
            return NetworkScreen(contests1: contests1, contests2: contests2,);
          } else if (snapshot.hasError) {
            return ErrorCardWidget("No internet!!! Try restarting App.");
          }
          return ProgressBarWidget("Finding Live Contests....");
        },
      ),
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
      const ReminderScreen(),
      FutureBuilder<List<dynamic>>(
        future: Future.wait([_getTaskAsync1,_getTaskAsync2,_getTaskAsync3]),
        // future: Future.wait([APIRepository().getProfileCodechef(),APIRepository().getProfileCodeforces(), APIRepository().getProfileLeetCode()]),
        builder: (contests, snapshot) {
          if (snapshot.hasData) {
            return Dummy(leetcode: snapshot.data![2], codeforces:snapshot.data![1] , codechef: snapshot.data![0],);
          } else if (snapshot.hasError) {
            return ErrorCardWidget("Something went wrong with usernames!");
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
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              duration: const Duration(milliseconds: 500),
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
}
