import 'package:bazzari/screens/authscreens/login.dart';
import 'package:bazzari/screens/authscreens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class GetScreen extends StatefulWidget {
  const GetScreen({super.key});

  @override
  State<GetScreen> createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  final List<String> images = [
    "assets/c1.png",
    "assets/c2.png",
    "assets/c3.png",
  ];
  final List<String> titles = [
    "Bazzari:Unbox Exclusivity",
    "Discounts that make smiles bloom.",
    'Bazzari',
  ];
  final List<String> bodies = [
    "Start Your Bazzari",
    "Continue Your Bazzari",
    "Let's Start the Bazzari"
  ];
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              }),
        ),
        Expanded(
            flex: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titles[_currentPage] == 'Bazzari'
                    ? Container(
                        child: Column(
                          children: [
                            Text(
                              'Start Your Journey',
                              style: GoogleFonts.reemKufi(
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff9833B4)),
                              textAlign: TextAlign.center,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Bazzari ',
                                style: GoogleFonts.reemKufi(
                                  fontSize: 45.0.sp,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: [
                                        Color(0xff9833B4),
                                        Color(0xff38B8BB),
                                      ],
                                    ).createShader(Rect.fromLTWH(
                                        150.0, 150.0, 200.0, 120.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        titles[_currentPage],
                        style: GoogleFonts.reemKufi(
                            fontSize: 22.sp, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                SizedBox(height: 10.0),
                titles[_currentPage] == 'Bazzari'
                    ? Container()
                    : Text(
                        bodies[_currentPage],
                        style: GoogleFonts.reemKufi(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9833B4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                SizedBox(height: 15.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            if (_currentPage == images.length - 1) {
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) => LogSig())
                              // );
                            } else {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: _currentPage == images.length - 1
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    PageTransition(
                                                        child: LoginPage(),
                                                        type: PageTransitionType
                                                            .leftToRight));
                                              },
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Container(
                                                  width: 250.w,
                                                  height: 50.h,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF9833B4),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              56),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Login",
                                                      style:
                                                          GoogleFonts.reemKufi(
                                                              fontSize: 30.sp,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.sp,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    PageTransition(
                                                        child: RegisterPage(),
                                                        type: PageTransitionType
                                                            .leftToRight));
                                              },
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Container(
                                                  width: 250.w,
                                                  height: 50.h,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF9833B4),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              56),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Register",
                                                      style:
                                                          GoogleFonts.reemKufi(
                                                              fontSize: 30.sp,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff9833B4),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 35,
                                    )),
                          )),
                    ]),
              ],
            ))
      ],
    ));
  }
}
