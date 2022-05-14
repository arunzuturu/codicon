import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mlr_app/Networking/api.dart';
import '../Constants.dart';

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
                          "Start :           ${widget.contest.start}",
                          style: resourceStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Text(
                          "Ends :           ${widget.contest.end}",
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                onPressed: () {},
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
              ElevatedButton(
                onPressed: () {},
                child: SizedBox(
                  width: size.width * 0.30,
                  height: size.height * 0.06,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          LineIcons.bookmark,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Save ",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(primary: buttonColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
