import 'dart:convert';
import 'dart:math';
import 'package:bazzari/screens/productscreen/product.dart';
import 'package:bazzari/services/httpservice.dart';
import 'package:bazzari/services/product.dart';
import 'package:http/http.dart' as http;
import 'package:bazzari/screens/profscreens/addtocart.dart';
import 'package:bazzari/screens/selecteditem/searcheditem.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SelectedCategory extends StatefulWidget {
  SelectedCategory({super.key, required this.categoryname});
  String categoryname;

  @override
  State<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  List<Map<String, dynamic>> categoryProducts = [];
  TextEditingController _searchController = TextEditingController();
  List<ProductList>? randomProducts;
  final List<String> pages = ['Page 1', 'Page 2', 'Page 3', 'Page 4'];
  final List<String> items = List.generate(10, (index) => 'Item ${index + 1}');
  Future<void> _fetchCategoryProducts() async {
    final response = await http.get(Uri.parse(
        'https://fakestoreapi.com/products/category/${widget.categoryname}'));

    if (response.statusCode == 200) {
      setState(() {
        categoryProducts =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load category products');
    }
  }

  List<Map<String, dynamic>> getRandomProducts() {
    final random = Random();
    return List<Map<String, dynamic>>.generate(
      min(10, categoryProducts.length),
      (index) => categoryProducts[random.nextInt(categoryProducts.length)],
    );
  }

  Future<void> fetchRandomProducts(String selectedCategory) async {
    try {
      List<Map<String, dynamic>> trendingProducts =
          await HttpService.fetchTrendingProducts();

      List<Map<String, dynamic>> selectedCategoryProducts = trendingProducts
          .where((product) =>
              product['category'].toString().toLowerCase() ==
              selectedCategory.toLowerCase())
          .toList();

      selectedCategoryProducts.shuffle();

      List<Map<String, dynamic>> randomProductsData =
          selectedCategoryProducts.take(6).toList();

      setState(() {
        randomProducts = randomProductsData
            .map((productData) => ProductList(
                id: productData['id'],
                title: productData['title'],
                description: productData['description'],
                price: productData['price'],
                rating: productData['rating'],
                image: productData['image'],
                reviews: []))
            .toList();
      });
    } catch (e) {
      print('Error fetching random products: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategoryProducts();
    fetchRandomProducts(widget.categoryname);
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
                '${widget.categoryname}',
                style: GoogleFonts.reemKufi(
                  fontSize: 25.sp,
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
                height: 10,
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
              SizedBox(
                height: 20.h,
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
                height: 10.h,
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
              Container(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: min(10, categoryProducts.length),
                  itemBuilder: (context, index) {
                    final product = getRandomProducts()[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageTransition(
                            child: Product(
                              id: product['id'],
                              price: product['price'].toString(),
                              imgurl: product['image'],
                              description: product['description'],
                              ratings: product['rating'],
                              product: product['title'].toString().trim(),
                            ),
                            type: PageTransitionType.leftToRight));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 500,
                          width: 180,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Color(0xff9833B4), width: 2.0)),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    product['image'],
                                    height: 80,
                                    width: 80,
                                  ),
                                  Text(
                                    product['title'].toString().trim(),
                                    style: GoogleFonts.reemKufi(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      'Trending Now',
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 300,
                  child: randomProducts == null
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
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
                                                              itemIndex]
                                                          .id,
                                                      price: randomProducts![
                                                              itemIndex]
                                                          .price
                                                          .toString(),
                                                      imgurl: randomProducts![
                                                              itemIndex]
                                                          .image,
                                                      description:
                                                          randomProducts![
                                                                  itemIndex]
                                                              .description,
                                                      ratings: randomProducts![
                                                              itemIndex]
                                                          .rating,
                                                      product: randomProducts![
                                                              itemIndex]
                                                          .title
                                                          .toString()
                                                          .trim(),
                                                    ),
                                                    type: PageTransitionType
                                                        .leftToRight));
                                          },
                                          child: Container(
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff9833B4),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SingleChildScrollView(
                                              physics: ScrollPhysics(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                                  itemIndex]
                                                              .image
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
                                                                  itemIndex]
                                                              .title
                                                          : '',
                                                      style:
                                                          GoogleFonts.reemKufi(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    // Text(
                                                    //   randomProducts!.length >
                                                    //           itemIndex
                                                    //       ? randomProducts![
                                                    //               itemIndex]
                                                    //           .price
                                                    //           .toString()
                                                    //       : '',
                                                    //   style: GoogleFonts.reemKufi(
                                                    //       color: Color(0xff9833B4),
                                                    //       fontSize: 18.sp,
                                                    //       fontWeight:
                                                    //           FontWeight.bold),
                                                    //   textAlign: TextAlign.center,
                                                    // ),
                                                  ],
                                                ),
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
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
