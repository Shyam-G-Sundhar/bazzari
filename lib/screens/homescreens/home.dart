import 'package:bazzari/screens/productscreen/product.dart';
import 'package:bazzari/screens/selecteditem/searchcategory.dart';
import 'package:bazzari/screens/selecteditem/searcheditem.dart';
import 'package:bazzari/services/category.dart';
import 'package:bazzari/services/httpservice.dart';
import 'package:bazzari/services/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/recentlyviewed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category>? categories;
  List<ProductList>? randomProducts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeSharedPreferences();
    fetchCategories();
    fetchRandomProducts();
  }

  Future<void> initializeSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
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
      // Handle error
      print('Error fetching categories: $e');
    }
  }

  Future<void> fetchRandomProducts() async {
    try {
      List<Map<String, dynamic>> productsList =
          await HttpService.fetchTrendingProducts();

      productsList.shuffle();

      List<Map<String, dynamic>> randomProductsData =
          productsList.take(6).toList();

      setState(() {
        randomProducts = randomProductsData
            .map((productData) => ProductList(
                id: productData['id'],
                title: productData['title'],
                price: productData['price'],
                rating: productData['rating'],
                image: productData['image'],
                description: productData['description'],
                reviews: []))
            .toList();
      });
    } catch (e) {
      // Handle error
      print('Error fetching random products: $e');
    }
  }

  Widget build(BuildContext context) {
    final List<String> pages = ['Page 1', 'Page 2', 'Page 3', 'Page 4'];

    TextEditingController _searchController = TextEditingController();
    String greetings = getGreeting();

    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          toolbarHeight: 100.h,
          title: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Text(
                      '${greetings} !',
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.reemKufi(
                        fontSize: 25.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
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
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                items: pages.map((page) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the respective page when clicked
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => DetailPage(page),
                          //   ),
                          // );
                        },
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          // margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff9833B4), width: 3.0),
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              page,
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      'Top Picks',
                      style: GoogleFonts.reemKufi(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              categories == null
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageTransition(
                                    child: SelectedCategory(
                                      categoryname: categories![index].name,
                                    ),
                                    type: PageTransitionType.rightToLeft));
                              },
                              child: Container(
                                height: 200,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Color(0xff9833B4), width: 2.0),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        categories![index].imageUrl,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        categories![index].name,
                                        style: GoogleFonts.reemKufi(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      'Recently Viewed',
                      style: GoogleFonts.reemKufi(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
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
                                            id: productId,
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
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      'More to Explore',
                      style: GoogleFonts.reemKufi(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              randomProducts == null
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: (randomProducts!.length / 2).ceil(),
                        itemBuilder: (context, rowIndex) {
                          return Row(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                  ),
                                  itemCount: 2,
                                  itemBuilder: (context, columnIndex) {
                                    final itemIndex =
                                        rowIndex * 2 + columnIndex;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageTransition(
                                                  child: Product(
                                                    id: randomProducts![
                                                        itemIndex]['id'],
                                                    price: randomProducts![
                                                            itemIndex]['price']
                                                        .toString(),
                                                    imgurl: randomProducts![
                                                        itemIndex]['image'],
                                                    description:
                                                        randomProducts![
                                                                itemIndex]
                                                            ['description'],
                                                    ratings: randomProducts![
                                                        itemIndex]['rating'],
                                                    product: randomProducts![
                                                            itemIndex]['title']
                                                        .toString()
                                                        .trim(),
                                                  ),
                                                  type: PageTransitionType
                                                      .leftToRight));
                                        },
                                        child: Container(
                                          height: 250.0,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff9833B4),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  randomProducts!.length >
                                                          itemIndex
                                                      ? randomProducts![
                                                          itemIndex]['image']
                                                      : '',
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.contain,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  randomProducts!.length >
                                                          itemIndex
                                                      ? randomProducts![
                                                          itemIndex]['title']
                                                      : '',
                                                  style: GoogleFonts.reemKufi(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  randomProducts!.length >
                                                          itemIndex
                                                      ? '₹ ${randomProducts![itemIndex]['price'].toString()}'
                                                      : '',
                                                  style: GoogleFonts.reemKufi(
                                                      fontSize: 18.sp,
                                                      color: Color(0xff9833B4),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
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
                height: 1.h,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Center(
              //     child: Text(
              //       'From Bazzari',
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.w700,
              //           fontSize: 18),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  String getGreeting() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
