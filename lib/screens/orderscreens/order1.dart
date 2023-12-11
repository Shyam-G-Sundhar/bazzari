import 'package:bazzari/screens/orderscreens/payscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Order1 extends StatefulWidget {
  Order1(
      {super.key,
      required this.id,
      required this.price,
      required this.product,
      this.imgurl,
      this.description,
      this.ratings});
  String product, price;
  int id;
  final imgurl, description, ratings;

  @override
  State<Order1> createState() => _Order1State();
}

class _Order1State extends State<Order1> {
  int currentPage = 1;
  int totalPages = 3;

  final List<String> items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  GlobalKey<FormState> ordform = GlobalKey<FormState>();
  final TextEditingController ordname = TextEditingController();
  final TextEditingController ordmail = TextEditingController();
  final TextEditingController ordphn = TextEditingController();
  final TextEditingController ordadd1 = TextEditingController();
  final TextEditingController ordadd2 = TextEditingController();
  final TextEditingController ordlandmark = TextEditingController();
  final TextEditingController ordcity = TextEditingController();
  final TextEditingController ordpincode = TextEditingController();
  String? selecttype = "1";

  @override
  Widget build(BuildContext context) {
    double intPrice = double.parse(widget.price);
    double intselect = double.parse(selecttype!);
    double productPrice = (intPrice * intselect).roundToDouble();
    String productText = widget.product;
    List<String> words = productText.split(' ');
    int shippingcost = intselect <= 5 ? 100 : 0;
    int deliverycost = intselect <= 7 ? 120 : 0;
    double totalcost =
        (productPrice + shippingcost + deliverycost).roundToDouble();
    String firstThreeWords = words.take(3).join(' ');
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                'Order Summary',
                style: GoogleFonts.reemKufi(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
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
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        totalPages,
                        (index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Dot(
                                filled: index < currentPage,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (currentPage == 1)
                  Container(
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.h),
                        child: Form(
                            key: ordform,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextFormField(
                                  controller: ordname,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Name';
                                    } else if (value.length < 2) {
                                      return 'Please Enter the Valid Name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Name',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          GoogleFonts.reemKufi(fontSize: 15.sp),
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        size: 25,
                                      ),
                                      fillColor: Colors.grey[100],
                                      hintText: 'Enter your Name',
                                      hintTextDirection: TextDirection.ltr,
                                      hintStyle: GoogleFonts.reemKufi(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Colors.black,
                                              width: 2)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Color(0xff9833B4),
                                              width: 2))),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                TextFormField(
                                  controller: ordmail,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter your Email Id';
                                    } else if (value.length < 2) {
                                      return 'Please Enter the Valid Email Id';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Email-Id',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          GoogleFonts.reemKufi(fontSize: 15.sp),
                                      prefixIcon: const Icon(
                                        Icons.mail_outline,
                                        size: 25,
                                      ),
                                      fillColor: Colors.grey[100],
                                      hintText: 'Enter your Email Id',
                                      hintTextDirection: TextDirection.ltr,
                                      hintStyle: GoogleFonts.reemKufi(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Colors.black,
                                              width: 2)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Color(0xff9833B4),
                                              width: 2))),
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                TextFormField(
                                  controller: ordphn,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Phone number';
                                    } else if (value.length != 10) {
                                      return 'Please enter a valid 10-digit phone number';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Phone Number',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          GoogleFonts.reemKufi(fontSize: 15.sp),
                                      prefixIcon: const Icon(
                                        Icons.phone,
                                        size: 25,
                                      ),
                                      fillColor: Colors.grey[100],
                                      hintText: 'Enter your Phone Number',
                                      hintTextDirection: TextDirection.ltr,
                                      hintStyle: GoogleFonts.reemKufi(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Colors.black,
                                              width: 2)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Color(0xff9833B4),
                                              width: 2))),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                TextFormField(
                                  controller: ordadd1,
                                  keyboardType: TextInputType.streetAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Address';
                                    } else if (value.length < 2) {
                                      return 'Please Enter the Valid Address';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Address Line 1',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          GoogleFonts.reemKufi(fontSize: 15.sp),
                                      prefixIcon: const Icon(
                                        Icons.home,
                                        size: 25,
                                      ),
                                      fillColor: Colors.grey[100],
                                      hintText: 'Enter your Address',
                                      hintTextDirection: TextDirection.ltr,
                                      hintStyle: GoogleFonts.reemKufi(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Colors.black,
                                              width: 2)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Color(0xff9833B4),
                                              width: 2))),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                TextFormField(
                                  controller: ordadd2,
                                  keyboardType: TextInputType.streetAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Address';
                                    } else if (value.length < 2) {
                                      return 'Please Enter the Valid Address';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Address Line 2',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          GoogleFonts.reemKufi(fontSize: 15.sp),
                                      prefixIcon: const Icon(
                                        Icons.home,
                                        size: 25,
                                      ),
                                      fillColor: Colors.grey[100],
                                      hintText: 'Enter your Address',
                                      hintTextDirection: TextDirection.ltr,
                                      hintStyle: GoogleFonts.reemKufi(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Colors.black,
                                              width: 2)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Color(0xff9833B4),
                                              width: 2))),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                TextFormField(
                                  controller: ordlandmark,
                                  keyboardType: TextInputType.streetAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Landmark';
                                    } else if (value.length < 2) {
                                      return 'Please Enter the Valid Landmark';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Landmark',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          GoogleFonts.reemKufi(fontSize: 15.sp),
                                      prefixIcon: const Icon(
                                        Icons.map,
                                        size: 25,
                                      ),
                                      fillColor: Colors.grey[100],
                                      hintText: 'Enter your Landmark',
                                      hintTextDirection: TextDirection.ltr,
                                      hintStyle: GoogleFonts.reemKufi(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Colors.black,
                                              width: 2)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              strokeAlign: 2.0,
                                              color: Color(0xff9833B4),
                                              width: 2))),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Column(
                                  children: [
                                    TextFormField(
                                      controller: ordcity,
                                      keyboardType: TextInputType.streetAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter City';
                                        } else if (value.length < 2) {
                                          return 'Please Enter the Valid City';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          filled: true,
                                          labelText: 'City',
                                          alignLabelWithHint: true,
                                          labelStyle: GoogleFonts.reemKufi(
                                              fontSize: 10.sp),
                                          prefixIcon: const Icon(
                                            Icons.location_city,
                                            size: 25,
                                          ),
                                          fillColor: Colors.grey[100],
                                          hintText: 'Enter your City',
                                          hintTextDirection: TextDirection.ltr,
                                          hintStyle: GoogleFonts.reemKufi(),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  strokeAlign: 2.0,
                                                  color: Colors.black,
                                                  width: 2)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  strokeAlign: 2.0,
                                                  color: Color(0xff9833B4),
                                                  width: 2))),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFormField(
                                      controller: ordpincode,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Pincode';
                                        } else if (value.length < 2) {
                                          return 'Please Enter the Valid Pincode';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          filled: true,
                                          labelText: 'Pincode',
                                          alignLabelWithHint: true,
                                          labelStyle: GoogleFonts.reemKufi(
                                              fontSize: 15.sp),
                                          prefixIcon: const Icon(
                                            Icons.numbers,
                                            size: 25,
                                          ),
                                          fillColor: Colors.grey[100],
                                          hintText: 'Enter your Pincode',
                                          hintTextDirection: TextDirection.ltr,
                                          hintStyle: GoogleFonts.reemKufi(),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  strokeAlign: 2.0,
                                                  color: Colors.black,
                                                  width: 2)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  strokeAlign: 2.0,
                                                  color: Color(0xff9833B4),
                                                  width: 2))),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (ordform.currentState!.validate()) {
                                        if (currentPage < totalPages) {
                                          currentPage++;
                                        } else {
                                          print('Performing payment action');
                                        }
                                      }
                                    });
                                  },
                                  icon: Container(
                                    width: 200.w,
                                    height: 45.h,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF9833B4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(56),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        currentPage < totalPages
                                            ? 'Next'
                                            : 'Pay',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 28.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      )
                    ]),
                  ),
                if (currentPage == 2)
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, top: 2.0),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                          padding: EdgeInsets.only(left: 15.0, top: 2.0),
                          child: Row(
                            children: [
                              Text(
                                'Order Details',
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
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ]),
                            child: Column(
                              children: [
                                ListTile(
                                  title: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 120,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xff9833B4),
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Center(
                                                  child: Image.network(
                                                widget.imgurl,
                                                width: 75,
                                                height: 70,
                                              )),
                                            ),
                                          ],
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
                                                firstThreeWords,
                                                style: GoogleFonts.reemKufi(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.sp),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                '₹ ${(widget.price)}',
                                                style: GoogleFonts.reemKufi(
                                                    color: Color(0xff9833B4),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.sp),
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Row(
                                    children: [
                                      DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                        style: GoogleFonts.reemKufi(),
                                        value: selecttype,
                                        onChanged: (String? newtype) {
                                          setState(() {
                                            selecttype = newtype;
                                          });
                                        },
                                        items:
                                            items.map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: selecttype == 'Select'
                                                      ? Colors.grey[800]
                                                      : Color(0xff9833B4),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product Cost',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        'Shipping Cost',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        'Delivery Cost',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        'Total Cost',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        intselect != 'Select'
                                            ? '₹ ${productPrice}'
                                            : '₹ ${intPrice}',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        '₹ ${shippingcost}',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        '₹ ${deliverycost}',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        '₹ ${totalcost}',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: currentPage == 2
              ? BottomAppBar(
                  height: 100,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                          child: PaymentScreen(),
                          type: PageTransitionType.rightToLeft));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff9833B4)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Text(
                              '₹ ${totalcost.round()}  |   Place Order   >',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.reemKufi(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null),
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
                title: Text('''Option1'''),
                onTap: () {
                  Navigator.pop(context);
                  _updateSelectedOption('''Option1''');
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
}

class Dot extends StatelessWidget {
  final bool filled;

  Dot({required this.filled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? Color(0xff9833B4) : Colors.grey,
      ),
    );
  }
}
