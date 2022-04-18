import 'package:flutter/material.dart';
import 'package:mlr_app/Constants.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kMainBgColor,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:EdgeInsets.only(left: size.width * 0.07),
                    child: const Text("Latest Coding \nContests", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only( top: 30),
                      child: SizedBox(
                        width: 200,
                        child: Transform.rotate(
                            angle: math.pi / 5,
                            child: Opacity(
                                opacity: 0.03,
                                child: Image.asset('assets/images/code.png'))),
                      ),
                    ),
                  ),
                ],
              ),

              contentCard(size)
            ],
          ),
        ),
      ),
    );
  }

  Widget contentCard(size) {
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.21,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kCardBgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.image),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text(
                "Code Rush 2.1",
                style: Title1
                ),
              SizedBox(height: 10,),
              Text("Duration : 6hrs", style: Title2,),
              SizedBox(height: 10,),
              Text("Ends at : Sat 21:00", style: Title2,),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomLeft,
                child: Icon(Icons.arrow_forward, color:kButtonVioletColor ,)),
          )
        ],
      ),
    );
  }
}
