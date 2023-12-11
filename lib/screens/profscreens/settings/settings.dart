import 'package:bazzari/screens/bottom/bottombar.dart';
import 'package:bazzari/screens/profscreens/settings/updprof.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          leadingWidth: 200,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(PageTransition(
                        child: BottomNav(), type: PageTransitionType.fade));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Color(0xff9833B4),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(PageTransition(
                          child: UpdateProfileScreen(),
                          type: PageTransitionType.leftToRight));
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 28,
                      color: Color(0xff9833B4),
                    ))),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xff9833B4),
                        radius: 55.r,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'XXXXXX',
                        style: GoogleFonts.reemKufi(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SettingsParameters(
                      name: 'Name',
                      param: 'XXXXXX',
                    ),
                    SettingsParameters(
                      name: 'E-mail',
                      param: 'xyz@abc.com',
                    ),
                    SettingsParameters(
                      name: 'Phone',
                      param: 'XXXXXXXXX',
                    ),
                    SettingsParameters(
                      name: 'Created on',
                      param: 'XX/MM/YYYY',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsParameters extends StatefulWidget {
  const SettingsParameters({
    super.key,
    required this.name,
    required this.param,
  });
  final String name, param;

  @override
  State<SettingsParameters> createState() => _SettingsParametersState();
}

class _SettingsParametersState extends State<SettingsParameters> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ListTile(
        leading: Text(
          '${widget.name}: ',
          style: GoogleFonts.reemKufi(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(
          '${widget.param}',
          style: GoogleFonts.reemKufi(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
