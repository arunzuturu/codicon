import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mlr_app/Constants.dart';
import 'package:mlr_app/Networking/api.dart';

import 'detail_screen.dart';

class CollectionScreen extends StatefulWidget {
  final int id;
  final String name;
  final List<Contest> list1;
  final List<Contest> list2;
  const CollectionScreen({Key? key, required this.id, required this.name, required this.list1, required this.list2}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.list2.length);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 20),
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, size: 30,),
                    )
                ),
              ),
              // SizedBox(height: size.height*0.02,),
              Text(widget.name, style: BasicTitle,),
              SizedBox(height: size.height*0.04,),
              Text("UPCOMING"),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: size.height*0.6, minHeight: 56.0),
                    child: (widget.list2.isNotEmpty)  ? ListView.builder(
                      shrinkWrap: true,
                        itemCount: widget.list2.length,
                        itemBuilder: (context, index) {
                          var str = widget.list2[index].end.toString();
                          if (str != null && str.length >= 5) {
                            str = str.substring(0, str.length - 7);
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: contentCard(size,
                                widget.list2[index].event.toString(),widget.list2[index].resource.toString(),str,
                                widget.list2[index]
                            ),
                          );
                        }): Center(child: Text("No Contests at the Moment!"))
                )
                ,

              ),
              SizedBox(height: size.height*0.04,),
              Text("LIVE"),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                    height: size.height*0.30,
                    child:(widget.list1.isNotEmpty)  ? ListView.builder(
                        itemCount: widget.list1.length,
                        itemBuilder: (context, index) {
                          var str = widget.list1[index].end.toString();
                          if (str != null && str.length >= 5) {
                            str = str.substring(0, str.length - 7);
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: contentCard(size,
                                widget.list1[index].event.toString(),widget.list1[index].resource.toString(),str,
                                widget.list1[index]
                            ),
                          );
                        }): Text("No information from website!")),

              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget contentCard(size,event,resource,ends,contest) {
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
                Text("Ends at : ${ends}", style: resourceStyle,),
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
