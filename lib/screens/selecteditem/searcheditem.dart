import 'package:bazzari/screens/productscreen/product.dart';
import 'package:bazzari/screens/profscreens/addtocart.dart';
import 'package:bazzari/screens/selecteditem/searched.dart';
import 'package:bazzari/services/httpservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SearchedItem extends StatefulWidget {
  const SearchedItem({Key? key}) : super(key: key);

  @override
  State<SearchedItem> createState() => _SearchedItemState();
}

class _SearchedItemState extends State<SearchedItem> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

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
            SizedBox(
              height: 15.0.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.reemKufi(
                    fontSize: 15.sp,
                  ),
                  prefix: Padding(padding: EdgeInsets.only(left: 5)),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    size: 20,
                  ),
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff9833B4), width: 3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff9833B4), width: 3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (_searchController.text.isEmpty)
              Center(
                child: Text(
                  'Search Something.....',
                  style: GoogleFonts.reemKufi(
                      fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
              ),
            if (_searchController.text.isNotEmpty)
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: HttpService.searchProducts(_searchController.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      searchResults = snapshot.data ?? [];

                      if (searchResults.isEmpty) {
                        return Center(
                          child: Text('No matching products found.'),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          String productText = searchResults[index]['title'];
                          List<String> words = productText.split(' ');
                          String firstThreeWords = words.take(2).join(' ');
                          return ListTile(
                            title: InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageTransition(
                                    child: Product(
                                      id: searchResults[index]['id'],
                                      price: searchResults[index]['price']
                                          .toString(),
                                      imgurl: searchResults[index]['image'],
                                      description: searchResults[index]
                                          ['description'],
                                      ratings: searchResults[index]['rating'],
                                      product: searchResults[index]['title']
                                          .toString()
                                          .trim(),
                                    ),
                                    type: PageTransitionType.rightToLeft));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff9833B4),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                          searchResults[index]['image']),
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${firstThreeWords}',
                                          style: GoogleFonts.reemKufi(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
