import 'package:bazzari/screens/productscreen/product.dart';
import 'package:bazzari/screens/profscreens/addtocart.dart';
import 'package:bazzari/screens/profscreens/ordersummary1.dart';
import 'package:bazzari/screens/profscreens/settings/settings.dart';
import 'package:bazzari/screens/profscreens/wishlist.dart';
import 'package:bazzari/services/recentlyviewed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> initializeSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPreferences();
  }

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text(
                      "Hello User",
                      style: GoogleFonts.reemKufi(
                          fontSize: 22.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(PageTransition(
                        child: SettingsPage(), type: PageTransitionType.fade));
                  },
                  icon: Container(
                    width: MediaQuery.of(context).size.width.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                            width: 1.0,
                            color: Color(0xff9833B4),
                            strokeAlign: BorderSide.strokeAlignCenter),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Color(0xff9833B4),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'XXXXXX',
                                style: GoogleFonts.reemKufi(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'XXXXXX',
                                style: GoogleFonts.reemKufi(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                              weight: 20,
                              color: Color(0xff9833B4),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PrfIcon(
                    icon: Icons.favorite,
                    clr: Colors.red,
                    oncall: () {
                      Navigator.of(context).push(PageTransition(
                          child: WishlistPage(),
                          type: PageTransitionType.rightToLeft));
                    },
                  ),
                  PrfIcon(
                    icon: Icons.shopping_cart,
                    clr: Color(0xff9833B4),
                    oncall: () {
                      Navigator.of(context).push(PageTransition(
                          child: AddToCart(),
                          type: PageTransitionType.rightToLeft));
                    },
                  ),
                  PrfIcon(
                    icon: Icons.shopping_bag,
                    clr: Colors.orange,
                    oncall: () {
                      Navigator.of(context).push(PageTransition(
                          child: OrderSummary1(),
                          type: PageTransitionType.rightToLeft));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Recently Viewed',
                      style: GoogleFonts.reemKufi(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              FutureBuilder<List<int>>(
                future: RecentlyViewedProducts.getRecentlyViewedProductIds(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<int> recentlyViewedIds = snapshot.data ?? [];

                    if (recentlyViewedIds.isEmpty) {
                      return Center(
                        child: Text('No recently viewed products.'),
                      );
                    }

                    return Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recentlyViewedIds.length,
                        itemBuilder: (context, index) {
                          int productId = recentlyViewedIds[index];

                          return FutureBuilder<ProductDetails>(
                            future: RecentlyViewedProducts.fetchProductDetails(
                                productId),
                            builder: (context, productSnapshot) {
                              if (productSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (productSnapshot.hasError) {
                                return Container(
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Color(0xff9833B4),
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                        'Error fetching product details for ID: $productId'),
                                  ),
                                );
                              } else {
                                ProductDetails productDetails =
                                    productSnapshot.data!;

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(PageTransition(
                                          child: Product(
                                            id: (productId),
                                            price:
                                                productDetails.price.toString(),
                                            imgurl: productDetails.image,
                                            description:
                                                productDetails.description,
                                            ratings: productDetails.ratings,
                                            product: productDetails.title
                                                .toString()
                                                .trim(),
                                          ),
                                          type:
                                              PageTransitionType.leftToRight));
                                    },
                                    child: Container(
                                      height: 250,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Color(0xff9833B4),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            productDetails.image,
                                            width: 75,
                                            height: 75,
                                          ),
                                          Text(
                                            '${productDetails.title}',
                                            style: GoogleFonts.reemKufi(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrfIcon extends StatefulWidget {
  PrfIcon({
    super.key,
    required this.icon,
    required this.oncall,
    required this.clr,
  });
  final IconData icon;
  final Color clr;
  final VoidCallback oncall;
  @override
  State<PrfIcon> createState() => _PrfIconState();
}

class _PrfIconState extends State<PrfIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.oncall,
      icon: CircleAvatar(
        radius: 25,
        child: Icon(
          widget.icon,
          color: widget.clr,
        ),
      ),
    );
  }
}
