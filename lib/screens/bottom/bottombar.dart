import 'package:bazzari/screens/homescreens/home.dart';
import 'package:bazzari/screens/homescreens/profile.dart';
import 'package:bazzari/screens/homescreens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late PageController _pageController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Image.asset(
              'assets/appbarlogo.png',
              height: 70,
              width: 70,
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 2.0,
          backgroundColor: Color(0xff9833B4),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _currentIndex == 0
                    ? Icon(Icons.home, key: ValueKey<int>(0))
                    : Icon(Icons.home_outlined, key: ValueKey<int>(1)),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _currentIndex == 1
                    ? Icon(Icons.search, key: ValueKey<int>(2))
                    : Icon(Icons.search_outlined, key: ValueKey<int>(3)),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _currentIndex == 2
                    ? Icon(Icons.person_2, key: ValueKey<int>(4))
                    : Icon(Icons.person_2_outlined, key: ValueKey<int>(5)),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];
}
