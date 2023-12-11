import 'dart:convert';

import 'package:bazzari/screens/orderscreens/order1.dart';
import 'package:bazzari/screens/profscreens/addtocart.dart';
import 'package:bazzari/services/httpservice.dart';
import 'package:bazzari/services/product.dart';
import 'package:bazzari/services/recentlyviewed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product extends StatefulWidget {
  Product(
      {super.key,
      required this.product,
      required this.price,
      this.ratings,
      this.imgurl,
      this.description,
      required this.id});
  String product, price;
  int id;
  final imgurl, description, ratings;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool isExpanded = false;
  double userRating = 0.0;
  double userRating2 = 0.0;
  bool isCartSelected = false;
  bool isWishlist = false;
  late ProductList productDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRating = (widget.ratings is double)
        ? widget.ratings['rate'].toDouble()
        : double.parse(widget.ratings['rate'].toString());
    _fetchProductDetails();
    checkWishlistStatus();
    RecentlyViewedProducts.addRecentlyViewedProductId(widget.id);
  }

  void _fetchProductDetails() async {
    try {
      productDetails = await HttpService.fetchProductDetails(widget.id);
      setState(() {});
    } catch (e) {
      // Handle error
      print('Error fetching product details: $e');
    }
  }

  void checkWishlistStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> wishlist =
        prefs.getStringList('wishlist')?.map((id) => int.parse(id))?.toList() ??
            [];
    setState(() {
      isWishlist = wishlist.contains(widget.id);
    });
  }

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
                    child: AddToCart(), type: PageTransitionType.bottomToTop));
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
              '${widget.product}',
              style: GoogleFonts.reemKufi(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 250.h,
                    width: 250.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff9833B4),
                          width: 4.0,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Image.network(widget.imgurl)),
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isWishlist = !isWishlist;
                            updateWishlist();
                          });
                        },
                        child: CircleAvatar(
                            backgroundColor:
                                isWishlist ? Color(0xff9833B4) : Colors.white,
                            child: isWishlist
                                ? Icon(
                                    Icons.favorite,
                                    key: ValueKey<int>(4),
                                    color: Colors.white,
                                  )
                                : Icon(Icons.favorite_border_outlined,
                                    key: ValueKey<int>(5))),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isCartSelected = !isCartSelected;
                          });
                        },
                        child: CircleAvatar(
                            backgroundColor: isCartSelected
                                ? Color(0xff9833B4)
                                : Colors.white,
                            child: isCartSelected
                                ? Icon(
                                    Icons.shopping_cart,
                                    key: ValueKey<int>(4),
                                    color: Colors.white,
                                  )
                                : Icon(Icons.shopping_cart_outlined,
                                    key: ValueKey<int>(5))),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.share)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(
                    '₹ ${widget.price}',
                    style: GoogleFonts.reemKufi(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9833B4)),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.product}',
                      style: GoogleFonts.reemKufi(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 15.0),
            //   child: Row(
            //     children: [
            //       Text(
            //         'XYXYXYYX',
            //         style: GoogleFonts.reemKufi(
            //             fontSize: 17.sp, fontWeight: FontWeight.w800),
            //         textAlign: TextAlign.left,
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8.0),
              child: Row(
                children: [
                  Text(
                    'Free Delivery',
                    style: GoogleFonts.reemKufi(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff9833B4)),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8.0),
              child: Row(
                children: [
                  Text(
                    'Delivery Address',
                    style: GoogleFonts.reemKufi(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('assets/loc.png'),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Text(
                              '$selectedOption',
                              style: GoogleFonts.reemKufi(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconButton(
                            onPressed: () {
                              _showBottomSheet();
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 35,
                              color: Color(0xff9833B4),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Expected delivery on DD/MM//YYYY',
                        style: GoogleFonts.reemKufi(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff9833B4),
                            fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8.0),
              child: Row(
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.reemKufi(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        child: Text(
                          '${widget.description}',
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.reemKufi(),
                          maxLines: isExpanded ? null : 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? '' : 'Read More...',
                  style: TextStyle(
                      color: Color(0xff9833B4), fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8.0),
              child: Row(
                children: [
                  Text(
                    'Ratings',
                    style: GoogleFonts.reemKufi(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      IconData icon = Icons.star;
                      Color color =
                          index < userRating2 ? Colors.amber : Colors.grey;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            userRating2 = index + 1.0;
                          });
                        },
                        child: Icon(
                          icon,
                          color: color,
                          size: 40,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    for (int i = 1; i <= 5; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$i Star'),
                          SizedBox(width: 10),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: (i <= userRating) ? 1.0 : 0.0,
                              backgroundColor: Colors.grey,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.amber),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8.0),
              child: Row(
                children: [
                  Text(
                    'Reviews',
                    style: GoogleFonts.reemKufi(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            for (int i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: InkWell(
                      onTap: () {
                        _showAlertDialog(context);
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
                            child: Center(child: Image.network(widget.imgurl)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  child: Text(
                                    'XXXX',
                                    style: GoogleFonts.reemKufi(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Good',
                                  style: GoogleFonts.reemKufi(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.grey.shade300,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff9833B4)),
              ),
              focusColor: Color(0xff9833B4),
              //highlightColor: Color(0xff9833B4),
              hoverColor: Color(0xff9833B4),

              splashColor: Color(0xff9833B4),
              color: Color(0xff9833B4),
              icon: Row(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'Buy Now',
                    style: GoogleFonts.reemKufi(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(PageTransition(
                    child: Order1(
                      product: widget.product,
                      price: widget.price,
                      imgurl: widget.imgurl,
                      id: widget.id,
                    ),
                    type: PageTransitionType.rightToLeft));
              },
            ),
            IconButton(
              style: ButtonStyle(
                backgroundColor: isCartSelected
                    ? MaterialStateProperty.all<Color>(Color(0xff9833B4))
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
              focusColor: Color(0xff9833B4),
              hoverColor: Color(0xff9833B4),
              splashColor: Color(0xff9833B4),
              icon: Row(
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    size: 25,
                    color: isCartSelected ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    isCartSelected ? 'Remove from Cart' : 'Add to Cart',
                    style: GoogleFonts.reemKufi(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: isCartSelected ? Colors.white : Colors.black),
                  ),
                ],
              ),
              onPressed: () {
                setState(() {
                  isCartSelected = !isCartSelected;
                });
              },
            ),
          ],
        ),
      ),
    ));
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Review'),
          content: Text('The Product is Good'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String selectedOption = "No Option Selected";

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('''
SSHHSHSHSHHSsssssssssssssssssssssssssssssssssssssss
'''),
                onTap: () {
                  Navigator.pop(context);
                  _updateSelectedOption('''
SSHHSHSHSHHSsssssssssssssssssssssssssssssssssssssss

''');
                },
              ),
              ListTile(
                title: Text('Option 2'),
                onTap: () {
                  Navigator.pop(context);
                  _updateSelectedOption('Option 2');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateSelectedOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  void updateWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> wishlist =
        prefs.getStringList('wishlist')?.map((id) => int.parse(id))?.toList() ??
            [];

    if (isWishlist) {
      wishlist.add(widget.id);
    } else {
      wishlist.remove(widget.id);
    }

    prefs.setStringList(
        'wishlist', wishlist.map((id) => id.toString()).toList());
  }
}
