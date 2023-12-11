import 'package:bazzari/screens/bottom/bottombar.dart';
import 'package:bazzari/screens/homescreens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> regform = GlobalKey<FormState>();
  final TextEditingController regmail = TextEditingController();
  final TextEditingController regpass = TextEditingController();
  final TextEditingController regname = TextEditingController();
  final TextEditingController regphn = TextEditingController();
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
          child: Column(
            children: [
              Center(
                child: Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.reemKufi(
                      fontSize: 30.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.h),
                child: Form(
                    key: regform,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            width: 130,
                            height: 130,
                            decoration: ShapeDecoration(
                              shape: OvalBorder(
                                side: BorderSide(
                                  width: 6,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  color: Color(0xA59833B4),
                                ),
                              ),
                              color: Color(0xff9833B4),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 49.20,
                                  offset: Offset(0, 4),
                                  spreadRadius: -2,
                                )
                              ],
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                                onPressed: () async {
                                  //await selectFile();
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          controller: regname,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Name';
                            } else if (value.length < 2) {
                              return 'Please Enter the Valid Name';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              filled: true,
                              labelText: 'Name',
                              alignLabelWithHint: true,
                              labelStyle: GoogleFonts.reemKufi(fontSize: 15.sp),
                              prefixIcon: const Icon(
                                Icons.person,
                                size: 25,
                              ),
                              fillColor: Colors.grey[100],
                              hintText: 'Enter your Name',
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
                        SizedBox(
                          height: 12.h,
                        ),
                        TextFormField(
                          controller: regmail,
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
                              labelStyle: GoogleFonts.reemKufi(fontSize: 15.sp),
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
                        SizedBox(
                          height: 13.h,
                        ),
                        TextFormField(
                          controller: regphn,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Phone number';
                            } else if (value.length != 10) {
                              return 'Please enter a valid 10-digit phone number';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              filled: true,
                              labelText: 'Phone Number',
                              alignLabelWithHint: true,
                              labelStyle: GoogleFonts.reemKufi(fontSize: 15.sp),
                              prefixIcon: const Icon(
                                Icons.phone,
                                size: 25,
                              ),
                              fillColor: Colors.grey[100],
                              hintText: 'Enter your Phone Number',
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
                        SizedBox(
                          height: 12.h,
                        ),
                        TextFormField(
                          controller: regpass,
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
                            labelStyle: GoogleFonts.reemKufi(fontSize: 15.sp),
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
                                    child: Icon(Icons.info_outline, size: 25),
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
                                        : Icon(Icons.visibility_off_outlined,
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
                      "Register",
                      style: GoogleFonts.reemKufi(
                          fontSize: 28.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
