import 'package:bazzari/screens/bottom/bottombar.dart';
import 'package:bazzari/screens/homescreens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> logform = GlobalKey<FormState>();
  final TextEditingController logmail = TextEditingController();
  final TextEditingController logpass = TextEditingController();
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 2.0),
            child: IconButton(
              icon: Text(
                '<',
                style: GoogleFonts.reemKufi(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Center(
                  child: Text(
                    "Welcome Back,",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.reemKufi(
                        fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Form(
                  key: logform,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: logmail,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Email Id';
                                } else if (value.length < 2) {
                                  return 'Please Enter the Valid Email Id';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: 'Email-Id',
                                  alignLabelWithHint: true,
                                  labelStyle:
                                      GoogleFonts.reemKufi(fontSize: 15.sp),
                                  prefixIcon: const Icon(
                                    Icons.mail_outline,
                                    size: 25,
                                  ),
                                  fillColor: Colors.grey[100],
                                  hintText: 'Enter your Email Id',
                                  hintTextDirection: TextDirection.ltr,
                                  hintStyle: GoogleFonts.reemKufi(),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          strokeAlign: 2.0,
                                          color: Colors.black,
                                          width: 2)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          strokeAlign: 2.0,
                                          color: Color(0xff9833B4),
                                          width: 2))),
                            ),
                            TextFormField(
                              controller: logpass,
                              obscureText: isShow ? true : false,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Password';
                                } else if (value.length <= 8) {
                                  return 'Password must be at least 8 characters long';
                                } else if (!RegExp(r'(?=.*[A-Z])')
                                    .hasMatch(value)) {
                                  return 'Password must contain at least one capital letter';
                                } else if (!RegExp(r'(?=.*[!@#$%^&*()_+])')
                                    .hasMatch(value)) {
                                  return 'Password must contain at least one symbol';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                filled: true,
                                labelText: 'Password',
                                alignLabelWithHint: true,
                                labelStyle:
                                    GoogleFonts.reemKufi(fontSize: 15.sp),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  size: 25,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Password Rules'),
                                              content: Text(
                                                'Password must:\n- Be at least 8 characters long\n- Contain at least one capital letter\n- Contain at least one symbol',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child:
                                            Icon(Icons.info_outline, size: 25),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isShow = !isShow;
                                          });
                                        },
                                        child: isShow
                                            ? Icon(Icons.visibility_outlined,
                                                size: 25)
                                            : Icon(
                                                Icons.visibility_off_outlined,
                                                size: 25),
                                      ),
                                    ],
                                  ),
                                ),
                                fillColor: Colors.grey[100],
                                hintText: 'Enter your Password',
                                hintStyle: GoogleFonts.reemKufi(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    strokeAlign: 2.0,
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    strokeAlign: 2.0,
                                    style: BorderStyle.solid,
                                    color: Color(0xff9833B4),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        PageTransition(
                            child: BottomNav(),
                            type: PageTransitionType.leftToRightWithFade),
                        (route) => false);
                  },
                  icon: Container(
                    width: 200.w,
                    height: 45.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFF9833B4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(56),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.reemKufi(
                            fontSize: 30.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100..h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/motor.png'),
                    Image.asset('assets/delman.png')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
