import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants.dart';
import '../../shared_pref.dart';
import '../navigation.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);


  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  static final _formKey = GlobalKey<FormState>();
  late bool isFirstTime;
  final TextEditingController _codechef = TextEditingController();
  final TextEditingController _leetCode = TextEditingController();
  final TextEditingController _codeForces = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffEDF2F4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key:_formKey,
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
                      "Edit Coding Profiles",
                      style: BasicTitle,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03,),
                fieldWidget("CodeChef Username", size, _codechef,
                        (v) {
                      if (v!.length < 2) {
                        return 'Please recheck!';
                      } else {
                        return null;
                      }
                    }
                    , context),
                SizedBox(height: size.height * 0.03,),
                fieldWidget("LeetCode Username", size, _leetCode,
                        (v) {
                      if (v.length<2) {
                        return 'Please recheck!';
                      } else {
                        return null;
                      }
                    }
                    , context),
                SizedBox(height: size.height * 0.03,),
                fieldWidget("CodeForces Username", size, _codeForces,
                        (v) {
                      if (v!.length < 2) {
                        return 'Please recheck!';
                      } else {
                        return null;
                      }
                    }
                    , context),
                SizedBox(height: size.height*0.05,),
                SizedBox(
                  child: Container(
                    width: 312,
                    height: size.height*0.22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffffdede),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            "1. All the usernames are required to be filled\n\n2. Make sure you enter correct usernames to fetch\n\n3. Updates after next restart\n",
                            style: GoogleFonts.montserrat(
                              color: Color(0xffe0232e),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.02,),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: size.width*0.5,
                    height: size.height*0.07,
                    child: ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!
                            .validate()) {
                          await SharedPref().codechefSetUser(_codechef.text.toString()) as String;
                          await SharedPref().codeforcesSetUser(_codeForces.text.toString()) as String;
                          await SharedPref().leetCodeSetUser(_leetCode.text.toString()) as String;
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: buttonColor),
                      child: Text("Save Changes", style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
}



Widget fieldWidget (title,size,controller,validator, context)
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Opacity(
        opacity: 0.40,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
      SizedBox(height: size.height * 0.02,),
      Container(
        width: size.width * 0.82,
        height: size.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0x1a000000),
              blurRadius: 7,
              offset: Offset(0, 1),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20, bottom: 3,top: 10),
          child: TextFormField(
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter $title",
              labelText: "Enter $title",
              labelStyle: TextStyle(
                color: Colors.black87,
                fontSize: 15.2,
              ),
              floatingLabelBehavior: FloatingLabelBehavior
                  .never,
            ),

          ),
        ),
      ),
    ],
  );
}