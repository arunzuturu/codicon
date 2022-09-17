import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:mlr_app/Constants.dart';
import 'package:mlr_app/Screens/Settings/profile_edit.dart';
import 'package:url_launcher/url_launcher.dart';
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffEDF2F4),
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 20),
                  child: Text(
                    "SETTINGS",
                    style: BasicTitle,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              Container(
                width: size.width*0.85,
                height: 69,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LineIcon.userCog(size: 30,),
                    Text("Edit Coding Profiles", style: GoogleFonts.montserrat(fontSize: 14),),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xffe8ecf4), width: 1, ),
                        ),
                        child: IconButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileEdit()),
                            );
                        }, icon: Icon(Icons.arrow_forward)))
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              Container(
                width: size.width*0.85,
                height: 69,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LineIcon.headset(size: 30,),
                    Text("Contact Us", style: GoogleFonts.montserrat(fontSize: 14),),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xffe8ecf4), width: 1, ),
                        ),
                        child: IconButton(onPressed: (){
                          _launchURL2();
                        }, icon: Icon(Icons.arrow_forward)))
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.07,),
              InkWell(
                onTap: (){
                  _launchURL();
                  //LaunchUrl("https://www.buymeacoffee.com/arunzuturu", context);
                },
                child: SizedBox(
                  width: size.width*0.7,
                  height: size.height*0.1,
                  child: Image.asset("assets/images/bmc.png",),
                ),
              ),
              SizedBox(height: size.height * 0.15,),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:  EdgeInsets.only(left: size.width*0.09),
                  child: Container(
                    width: size.width*0.65,
                    height: size.height*0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Made With", style: GoogleFonts.montserrat(
                              color: Color(0xff9E9E9E),
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),),
                            SizedBox(
                              width: size.width*0.12,
                                child: Image.asset("assets/images/love.png",))
                          ],
                        ),
                        Text("by Arun", style: GoogleFonts.montserrat(
                          color: Color(0xff9E9E9E),
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),),
                      ],
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


  _launchURL() async {
    const url = 'https://www.buymeacoffee.com/arunzuturu';
    if (await launch(url)) {
      await canLaunch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL2() async {
    const url = 'https://mail.google.com/mail/u/0/?fs=1&to=arunzuturu@gmail.com&su=Describe issue&body=BODY&tf=cm';
    if (await launch(url)) {
      await canLaunch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


