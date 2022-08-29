import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mlr_app/Constants.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:mlr_app/Helpers/list.dart';
import 'package:mlr_app/Networking/api.dart';

import 'collection_screen.dart';
import 'detail_screen.dart';


class NetworkScreen extends StatefulWidget {
  final  List<Contest> contests1;
  final List<Contest> contests2;
  const NetworkScreen({Key? key, required this.contests1, required this.contests2}) : super(key: key);
  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 20),
                  child: Text("LIVE", style: BasicTitle,),
                ),
              ),
              Container(
                height: size.height*0.28,
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 4000,
                  itemBuilder: (BuildContext context,int index){
                    var str = widget.contests1[index].end.toString();
                    if (str != null && str.length >= 5) {
                      str = str.substring(0, str.length - 7);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15,top: 10),
                      child: contentCard(size,
                          widget.contests1[index].event.toString(),widget.contests1[index].resource.toString(),str,
                          widget.contests1[index]
                      ),
                    );
                  },
                  viewportFraction: 0.85,
                  scale: 0.9,
                  itemCount: widget.contests1.length,
                  // pagination: SwiperPagination(),
                  // control: SwiperControl(
                  //   disableColor: Colors.white
                  // ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 20),
                  child: Text("Collections", style: BasicTitle,),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    height: size.height*0.38,
                    child: GridView.builder(
                      itemCount: entries.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemBuilder: (ctx, index){
                        return buildGridChild(index, entries[index], names[index], context);
                      },
                    ),
                  ),
                ),
              )
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
                color: Color(0xfff94327).withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 16.0,
                offset: Offset(0,5)
            )
          ],
          borderRadius: BorderRadius.circular(11),
          gradient: LinearGradient(
             colors: [
               Color(0xffff7d14),
               Color(0xfff94327)
             ]
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  SizedBox(
                    height: size.height*0.06,
                    width: size.width*0.5,
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

  buildGridChild(int id, String icon, String name, BuildContext context) => Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: InkWell(
      onTap: () {
        switch(id) {
          case 0:
            final list1 = widget.contests1.where((o) => o.resource.toString() == "codechef.com").toList();
            final list2 = widget.contests2.where((o) => o.resource.toString() == "codechef.com").toList();
            Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) => CollectionScreen(id: id, name: name, list2: list2 , list1: list1,)));
            break;
          case 1:
            final list1 = widget.contests1.where((o) => o.resource == 'codeforces.com').toList();
            final list2 = widget.contests2.where((o) => o.resource == 'codeforces.com').toList();
            Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) => CollectionScreen(id: id, name: name, list2: list2 , list1: list1,)));
            break;
          case 2:
            final list1 = widget.contests1.where((o) => o.resource == 'hackerearth.com').toList();
            final list2 = widget.contests2.where((o) => o.resource == 'hackerearth.com').toList();
            Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) => CollectionScreen(id: id, name: name, list2: list2 , list1: list1,)));
            break;
          case 3:
            final list1 = widget.contests1.where((o) => o.resource == 'hackerrank.com').toList();
            final list2 = widget.contests2.where((o) => o.resource == 'hackerrank.com').toList();
            Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) => CollectionScreen(id: id, name: name, list2: list2 , list1: list1,)));
            break;
          case 4:
            final list1 = widget.contests1.where((o) => o.resource == 'kaggle.com').toList();
            final list2 = widget.contests2.where((o) => o.resource == 'kaggle.com').toList();
            Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) => CollectionScreen(id: id, name: name, list2: list2 , list1: list1,)));
            break;
          case 5:
            final list1 = widget.contests1.where((o) => o.resource == 'leetcode.com').toList();
            final list2 = widget.contests2.where((o) => o.resource == 'leetcode.com').toList();
            Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) => CollectionScreen(id: id, name: name, list2: list2 , list1: list1,)));
            break;
          case 6:
            final list1 = widget.contests1.where((o) => o.resource == 'projecteuler.net').toList();
            final list2 = widget.contests2.where((o) => o.resource == 'projecteuler.net').toList();
            Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) => CollectionScreen(id: id, name: name, list2: list2 , list1: list1,)));
            break;
          case 7:
            final list1 = widget.contests1.where((o) => o.resource == 'topcoder.com').toList();
            final list2 = widget.contests2.where((o) => o.resource == 'topcoder.com').toList();
            Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) => CollectionScreen(id: id, name: name, list2: list2 , list1: list1,)));
            break;
        }
        },

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            SizedBox.expand(
              child: Hero(
                  tag: id,
                  child: Image(
                    image: AssetImage(icon),
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(.5), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      stops: [.01, .3],
                      end: Alignment.topCenter)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Hero(
                      tag: name,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(name,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                      ))),
            ),
          ],
        ),
      ),
    ),
  );
}
