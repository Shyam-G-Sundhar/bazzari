import 'dart:async';

import 'package:bazzari/screens/bottom/bottombar.dart';
import 'package:bazzari/screens/homescreens/home.dart';
import 'package:bazzari/screens/slidescreens/getscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity/connectivity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPreferences();
  runApp(const MyApp());
}

Future<void> initializeSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  // Perform any initialization using prefs
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bazzari',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomNav() //const SplashScreen(),
        );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
    checkConnectivity();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => GetScreen()));
    });
  }

  Future<void> checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        print("No network connection");
      } else {
        print("Network connection available");
      }
    } catch (e) {
      print("Error checking connectivity: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Center(child: Image.asset('assets/logo.png')),
              SizedBox(
                height: 15.h,
              ),
              RichText(
                text: TextSpan(
                  text: 'Bazzari ',
                  style: GoogleFonts.reemKufi(
                    fontSize: 38.0.sp,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          Color(0xff9833B4),
                          Color(0xff38B8BB),
                        ],
                      ).createShader(Rect.fromLTWH(150.0, 150.0, 200.0, 120.0)),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
