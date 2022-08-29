
import 'package:flutter/material.dart';
import 'package:mlr_app/Constants.dart';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import '../Networking/api.dart';
import 'package:mlr_app/Screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final List <Contest> contests;
  final String which;
  const HomeScreen({Key? key, required this.contests,required this.which}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  List<Contest> p = [];
  @override
  void initState() {
    super.initState();
  }
  @override
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 38.0, top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text("Upcoming   🔥", style: BasicTitle,)),
              ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
              height: size.height*0.73,
              child: ListView.builder(
                key: PageStorageKey(this.widget.which),
                  itemCount: widget.contests.length,
                  itemBuilder: (context, index) {
                    var str = widget.contests[index].start.toString();
                    if (str != null && str.length >= 5) {
                      str = str.substring(0, str.length - 7);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: contentCard(size,
                        widget.contests[index].event.toString(),widget.contests[index].resource.toString(),str,
                        widget.contests[index]
                      ),
                    );
                  })),
        )
            ],
          ),
        ),
      ),
    );
  }

  Widget contentCard(size,event,resource,starts,contest) {
    return Padding(
      padding: const EdgeInsets.only(left: 4,right: 4, bottom: 10,top: 15),
      child: Container(
        width: size.width * 0.85,
        height: size.height * 0.21,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 16.0,
              offset: Offset(0,5)
            )
          ],
          borderRadius: BorderRadius.circular(11),
          color: primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                SizedBox(
                  height: size.height*0.06,
                  width: size.width*0.6,
                  child: AutoSizeText(
                    event,
                    style: EventStyle,
                    overflow: TextOverflow.fade,
                    ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: size.height*0.02,
                    width: size.width *0.5,
                    child: AutoSizeText("Resource : ${resource}", style: resourceStyle,)),
                SizedBox(height: 10,),
                Text("Starts at : ${starts}", style: resourceStyle,),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Align(
                alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: buttonColor
                    ),
                    child: InkWell(
                      hoverColor: Colors.white,
                      onTap: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>DetailScreen(contest: contest,)),
                        );},
                      child: Padding(
                        padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        child: Text("View", style: viewStyle,),
                      ),
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

}
