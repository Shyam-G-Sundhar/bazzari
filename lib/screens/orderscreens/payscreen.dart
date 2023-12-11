import 'package:bazzari/screens/authscreens/login.dart';
import 'package:bazzari/screens/orderscreens/successorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

String i = '';

class _PaymentScreenState extends State<PaymentScreen> {
  bool isCod = false;
  @override
  Widget build(BuildContext context) {
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
            child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              children: [
                Text(
                  'Payment Method',
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
          PaymentMode(
            paymentName: 'Google Pay',
            img: 'assets/gpay.png',
            oncall: () {},
          ),
          SizedBox(
            height: 15.h,
          ),
          PaymentMode(
            paymentName: 'Amazon Pay',
            img: 'assets/amazonpay.png',
            oncall: () {},
          ),
          SizedBox(
            height: 15.h,
          ),
          PaymentMode(
            paymentName: 'BHIM UPI',
            img: 'assets/bhim.png',
            oncall: () {},
          ),
          SizedBox(
            height: 15.h,
          ),
          PaymentMode(
            paymentName: 'Phone Pe',
            img: 'assets/phnpe.png',
            oncall: () {},
          ),
          SizedBox(
            height: 15.h,
          ),
          PaymentMode(
            paymentName: 'Cash on Delivery',
            img: 'assets/cod.png',
            oncall: () {
              Navigator.of(context).pushReplacement(PageTransition(
                  child: SuccessOrder(), type: PageTransitionType.fade));
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          //   Center(
          //     child: InkWell(
          //       onTap: () {

          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Container(
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(15),
          //               color: Color(0xff9833B4)),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Expanded(
          //               child: Text(
          //                 'Place Order',
          //                 textAlign: TextAlign.center,
          //                 style: GoogleFonts.reemKufi(
          //                     fontSize: 25.sp,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
        ])),
      ),
    );
  }
}

class PaymentMode extends StatefulWidget {
  PaymentMode(
      {Key? key,
      required this.paymentName,
      required this.img,
      required this.oncall})
      : super(key: key);

  final String paymentName;
  final String img;
  final VoidCallback oncall;

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: InkWell(
        onTap: widget.oncall,
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            leading: Image.asset('${widget.img}'),
            title: Align(
              child: Text(
                '${widget.paymentName}',
                style: GoogleFonts.reemKufi(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: widget.oncall,
              icon: Text(
                '>',
                style: GoogleFonts.reemKufi(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
