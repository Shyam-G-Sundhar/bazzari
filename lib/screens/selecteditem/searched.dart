import 'package:bazzari/screens/productscreen/product.dart';
import 'package:bazzari/screens/profscreens/addtocart.dart';
import 'package:bazzari/screens/selecteditem/searcheditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Searched extends StatefulWidget {
  Searched({super.key, required this.searcheditem});
  final String searcheditem;

  @override
  State<Searched> createState() => _SearchedState();
}

class _SearchedState extends State<Searched> {
  List<String> items = [
    'Item 3',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 1',
    'Item 2'
  ];
  String selectedSortOption = 'Default';

  void sortItems(String option) {
    setState(() {
      selectedSortOption = option;
      switch (option) {
        case 'Default':
          break;
        case 'Name':
          items.sort((a, b) => a.compareTo(b));
          break;
        case 'Price':
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 2.0),
            child: IconButton(
              icon: Text(
                '<',
                style: GoogleFonts.reemKufi(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0, top: 12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(PageTransition(
                      child: AddToCart(),
                      type: PageTransitionType.bottomToTop));
                },
                icon: Image.asset(
                  'assets/cart.png',
                  height: 35,
                  width: 35,
                ),
              ),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                'Search',
                style: GoogleFonts.reemKufi(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(PageTransition(
                  child: SearchedItem(),
                  type: PageTransitionType.bottomToTop,
                ));
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff9833B4), width: 3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.search_outlined,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Item : ${widget.searcheditem}',
                        style: GoogleFonts.reemKufi(
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedSortOption == 'Default'
                          ? Colors.white
                          : Color(0xff9833B4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedSortOption == 'Default'
                                ? 'Sort By:'
                                : '$selectedSortOption',
                            style: GoogleFonts.reemKufi(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: selectedSortOption == 'Default'
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          PopupMenuButton<String>(
                            iconColor: selectedSortOption == 'Default'
                                ? Colors.black
                                : Colors.white,
                            onSelected: sortItems,
                            itemBuilder: (BuildContext context) {
                              return ['Default', 'Name', 'Price']
                                  .map((String option) {
                                return PopupMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageTransition(
                            child: Product(
                              id: 0,
                              price: '',
                              product: index.toString(),
                            ),
                            type: PageTransitionType.leftToRightWithFade));
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff9833B4), width: 2.0),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                'data',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'XXXXXXXXX',
                                  style: GoogleFonts.reemKufi(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'XYXYXY',
                                  style: GoogleFonts.reemKufi(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '₹123',
                                      style: GoogleFonts.reemKufi(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text(
                                      '₹99',
                                      style: GoogleFonts.reemKufi(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff9833B4),
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
