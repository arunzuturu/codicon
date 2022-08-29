import 'package:flutter/material.dart';

import '../Constants.dart';
import '../shared_pref.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late bool isFirstTime;
  @override
  void initState() {
    getFirst();
    // TODO: implement initState
    super.initState();
  }
  void getFirst() async
  {
    await SharedPref().isFirstTimeUser();
  }

  final TextEditingController _codechef = TextEditingController();
  final TextEditingController _leetCode = TextEditingController();
  final TextEditingController _codeForces = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 20),
                child: Text(
                  "Fill the details to Proceed",
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
                  if (v!.length < 2) {
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
          ],
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
      SizedBox(height: size.height * 0.01,),
      Container(
        width: size.width * 0.82,
        height: size.height * 0.064,
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