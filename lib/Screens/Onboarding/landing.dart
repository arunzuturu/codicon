import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mlr_app/Constants.dart';
import 'package:mlr_app/Screens/profile_form.dart';

import 'Slider.dart';
class Landing extends StatefulWidget {
  final bool first;
  const Landing({required this.first});
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
        title: "Welcome",
        description:
        "Find coding contests that you love, organised and at one place",
        image: "assets/images/1.gif"),
    SliderPage(
        title: "Find",
        description:
        "Find Contests from more than 25+ websites, live and on the fly! Set reminders and receive live notifications",
        image: "assets/images/2.gif"),
    SliderPage(
        title: "Profiles",
        description:
        "View your coding profiles from multiple websites within the app!",
        image: "assets/images/3.gif"),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 20 : 10,
                        margin:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? kButtonVioletColor
                                : kButtonVioletColor.withOpacity(0.5)));
                  })),
              InkWell(
                onTap: () {
                  _controller.nextPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOutQuint);
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 300),
                  height: 70,
                  width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                  decoration: BoxDecoration(
                      color: kButtonVioletColor,
                      borderRadius: BorderRadius.circular(35)),
                  child: (_currentPage == (_pages.length - 1))
                      ? InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileForm(first: widget.first)),
                      );
                    },
                        child: Text(
                    "Get Started",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                      )
                      : Icon(
                    Icons.navigate_next,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}