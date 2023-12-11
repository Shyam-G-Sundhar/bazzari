import 'dart:async';
import 'dart:convert';

import 'package:bazzari/screens/selecteditem/searchcategory.dart';
import 'package:bazzari/screens/selecteditem/searcheditem.dart';
import 'package:bazzari/services/httpservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

import '../../services/category.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Category>? categories = [];

  @override
  void initState() {
    fetchCategories();
    HttpService.fetchCategoriesWithImages();
    super.initState();
  }

  Future<void> fetchCategories() async {
    try {
      List<Map<String, dynamic>> categoryList =
          await HttpService.fetchCategoriesWithImages();
      setState(() {
        categories = categoryList
            .map((categoryData) => Category(
                name: categoryData['category'],
                imageUrl: categoryData['image']))
            .toList();
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    TextEditingController _searchController = TextEditingController();
    final List<String> items =
        List.generate(26, (index) => 'Item ${index + 1}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Column(
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
                          'Search...',
                          style: GoogleFonts.reemKufi(
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: categories == null
                  ? Center(child: CircularProgressIndicator())
                  : categories!.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 1000,
                                child: ListView.builder(
                                  itemCount: (categories!.length / 2).ceil(),
                                  itemBuilder: (context, rowIndex) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 8.0,
                                              mainAxisSpacing: 8.0,
                                            ),
                                            itemCount: 2,
                                            itemBuilder:
                                                (context, columnIndex) {
                                              final itemIndex =
                                                  rowIndex * 2 + columnIndex;
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.black,
                                                    backgroundColor:
                                                        Colors.white,
                                                    side: BorderSide(
                                                      color: Color(0xff9833B4),
                                                      width: 2,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        PageTransition(
                                                            child:
                                                                SelectedCategory(
                                                              categoryname:
                                                                  categories![
                                                                          itemIndex]
                                                                      .name,
                                                            ),
                                                            type: PageTransitionType
                                                                .rightToLeft));
                                                  },
                                                  child: Container(
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.network(
                                                            categories![
                                                                    itemIndex]
                                                                .imageUrl,
                                                            height: 80,
                                                            width: 80,
                                                            fit: BoxFit.contain,
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                            categories![
                                                                    itemIndex]
                                                                .name,
                                                            style: GoogleFonts
                                                                .reemKufi(
                                                              fontSize: 17.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
