import 'dart:async';

import 'package:bazzari/screens/bottom/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SuccessOrder extends StatefulWidget {
  const SuccessOrder({super.key});

  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushAndRemoveUntil(
          PageTransition(child: BottomNav(), type: PageTransitionType.fade),
          (route) => false);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Container(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/success.png'),
              SizedBox(
                height: 15,
              ),
              Align(
                child: Text(
                  'Ordered Placed Successfully',
                  style: GoogleFonts.reemKufi(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff9833B4)),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Expanded(
                child: Text(
                  'You will receive the message shortly',
                  style: GoogleFonts.reemKufi(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
