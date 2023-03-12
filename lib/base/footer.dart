import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skybuybd/utils/app_colors.dart';
import 'package:skybuybd/utils/dimentions.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1040,
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.all(Dimensions.height15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Col-1
          Image.asset(
            'assets/logo/foterlogo.png',
            height: 100,
            width: 200,
            scale: 1.0,
            fit: BoxFit.contain,
          ),
          //Location
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                CupertinoIcons.location_solid,
                color: AppColors.btnColorBlueDark,
              ),
              SizedBox(width: 10),
              Text(
                'Head Office:',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            'House#42, Road-3/A, Dhanmondi, Dhaka-1209, Bangladesh',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          //Email
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                CupertinoIcons.mail_solid,
                color: AppColors.btnColorBlueDark,
              ),
              SizedBox(width: 10),
              Text(
                'Email:',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 5),
          const Text(
            'skybuybd@gmail.com',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          //Phone
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                CupertinoIcons.phone_fill,
                color: AppColors.btnColorBlueDark,
              ),
              SizedBox(width: 10),
              Text(
                'Phone:',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 5),
          const Text(
            '09613828606',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          //Col-2
          SizedBox(height: 20),
          const Text(
            'WHO WE ARE',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'About Us',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Contact Us',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Privacy Policy',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Return and Refund Policy',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Secured Payment',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Transparency',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          //Col-3
          SizedBox(height: 20),
          const Text(
            'CUSTOMER SERVICE',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'How To Buy',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Shipping & Delivery',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Custom & Shipping Charge',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Delivery Charges',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Minimum Order Quantity',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'Prohibited Items',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          const Text(
            'FAQ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
            textAlign: TextAlign.start,
          ),
          //Col-4
          SizedBox(height: 20),
          const Text(
            'SOCIAL LINK',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/social/facebook.png',
                height: 30,
                width: 30,
              ),
              SizedBox(width: 8),
              Image.asset(
                'assets/social/instagram.png',
                height: 30,
                width: 30,
              ),
              SizedBox(width: 8),
              Image.asset(
                'assets/social/youtube.png',
                height: 30,
                width: 30,
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/logo/300.png",
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'Sky Buy',
                      style: TextStyle(
                        color: Color(0xFF0061B2),
                        fontSize: 44,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.primaryColor,
                                  offset: Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                ), //BoxShadow
                              ],
                            ),
                            padding: EdgeInsets.all(20),
                            child: Image.asset(
                              'assets/logo/footer_left.png',
                              height: 50,
                              width: 80,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.primaryColor,
                                  offset: Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                ), //BoxShadow
                              ],
                            ),
                            padding: EdgeInsets.all(20),
                            child: Image.asset(
                              'assets/logo/footer_right.png',
                              height: 50,
                              width: 80,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
