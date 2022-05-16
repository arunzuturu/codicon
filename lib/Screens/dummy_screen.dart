import 'package:flutter/material.dart';
import 'package:mlr_app/Constants.dart';
import 'package:mlr_app/Models/codechef_model.dart';
import 'package:mlr_app/Models/codeforces_model.dart';
import 'package:mlr_app/Models/leetcode_model.dart';


import '../Networking/profile_api.dart';
import 'navigation.dart';


class Dummy extends StatefulWidget {
  final CodeforcesModal codeforces;
  final CodechefModal codechef;
  final LeetCodeModel leetcode;
  const Dummy({Key? key, required this.codeforces, required this.codechef, required this.leetcode}) : super(key: key);

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 20),
                    child: Text(
                      "PROFILE",
                      style: BasicTitle,
                    ),
                  ),
                ),

                CardLeetCode(widget.leetcode,size),
                CardC(widget.codechef,size),
                CardCodeForces(widget.codeforces,size),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget CardC(CodechefModal? data,size)
  {
    return Container(
      height: size.height * 0.2,
      width: size.width*0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xff000000).withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 16.0,
              offset: Offset(0,5)
          )
        ],
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            colors: [
              Color(0xff713D1C),
              Color(0xff85563A)
            ]
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0,),
                child: Text(
                  "CodeChef",
                  style: EventStyle!.copyWith(color: Colors.white),
                ),
              ),
            ),
            Text(" Name : ${data!.res![0].name}",style: resourceStyle,),
            Text(" Rating : ${data.res![1].rating}",style: resourceStyle),
            Text(" Username : ${data.res![2].username}",style: resourceStyle),
            Text(" Country : ${data.res![3].country}",style: resourceStyle),
            // Text(" State : ${data.res![4].state}",style: resourceStyle),
          ],
        ),
      ),
    );
  }
  Widget CardCodeForces(CodeforcesModal data,size)
  {
    return Container(
      height: size.height * 0.2,
      width: size.width*0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xff000000).withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 16.0,
              offset: Offset(0,5)
          )
        ],
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            colors: [
              Color(0xff445F9D),
              Color(0xff1D92D0)
            ]
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0,),
                child: Text(
                  "CodeForces",
                  style: EventStyle!.copyWith(color: Colors.white),
                ),
              ),
            ),
            Text(" Name : ${data.username}",style: resourceStyle),
            Text(" Rating : ${data.rating}",style: resourceStyle),
            Text(" max rank : ${data.maxRank}",style: resourceStyle),
            Text(" max rating : ${data.maxRating}",style: resourceStyle),
          ],
        ),
      ),
    );
  }
}Widget CardLeetCode(LeetCodeModel data,size)
{
  return Container(
    height: size.height * 0.2,
    width: size.width*0.9,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Color(0xff000000).withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 16.0,
            offset: Offset(0,5)
        )
      ],
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
          colors: [
            Color(0xff303036),
            Color(0xff000000)
          ]
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0,),
              child: Text(
                "LeetCode",
                style: EventStyle!.copyWith(color: Colors.white),
              ),
            ),
          ),
          Text(" Easy : ${data.easyQuestionsSolved}",style: resourceStyle),
          Text(" Acceptance : ${data.acceptanceRate}",style: resourceStyle),
          Text(" Reputation : ${data.reputation}",style: resourceStyle),
          Text(" Total Solved : ${data.totalProblemsSolved}",style: resourceStyle),
        ],
      ),
    ),
  );
}
