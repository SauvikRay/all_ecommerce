import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:skybuybd/pages/home/home_page.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';
import '../account/account_page.dart';
import '../home/widgets/dimond_bottom_bar.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class VerifyOtp extends StatefulWidget {
  final String phone;
  const VerifyOtp({Key? key, required this.phone}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  int selectedIndex = -1;

  late bool isUserLoggedIn;
  OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    double width = MediaQuery.of(context).size.width;

    verifyOtp(AuthController authController, String otp) {
      String phone = widget.phone;

      if (otp.isEmpty) {
        showCustomSnakebar('Type your otp', title: "OTP");
      } else if (otp.length != 4) {
        showCustomSnakebar('Type valid otp', title: "Invalid OTP");
      } else {
        authController.verifyOtp(phone, otp).then((status) {
          if (status.isSuccess) {
            print(status.toString());
            showCustomSnakebar(status.message,
                title: "Login", color: AppColors.primaryColor);

            // Get.toNamed(RouteHelper.getAccountPage());
            // Navigator.of(context).pushReplacement(
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) =>
            //         HomePage(),
            //     transitionsBuilder:
            //         (context, animation, secondaryAnimation, child) {
            //       return child;
            //     },
            //   ),
            // );
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomePage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ),
              ModalRoute.withName(RouteHelper.getInitial()),
            );
          } else {
            showCustomSnakebar(status.message);
          }
        });
      }
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Verify Your phone number',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.black87,
                        letterSpacing: 1),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: const Text(
                      'We just sent you an SMS with an OTP code.\n To complete your phone number login, please enter the 4-digit OTP code below.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 25),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OTPTextField(
                              controller: otpController,
                              length: 4,
                              width: MediaQuery.of(context).size.width,
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldWidth: 45,
                              fieldStyle: FieldStyle.underline,
                              outlineBorderRadius: 15,
                              style: TextStyle(fontSize: 17),
                              otpFieldStyle: OtpFieldStyle(
                                  borderColor: AppColors.primaryColor,
                                  backgroundColor: Colors.transparent,
                                  focusBorderColor: AppColors.primaryColor,
                                  disabledBorderColor: Colors.yellow,
                                  enabledBorderColor: AppColors.primaryColor,
                                  errorBorderColor: Colors.black),
                              onChanged: (pin) {
                                print("Changed: " + pin);
                              },
                              onCompleted: (pin) {
                                print("Completed: " + pin);
                                if (pin.length == 4) {
                                  verifyOtp(authController, pin);
                                }
                              }),
                        ],
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: 180,
                        child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.primaryColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    //side: BorderSide(color: Colors.red)
                                  ),
                                )),
                            child: Text(
                              "Resend Code",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                ],
              )
            : CustomLoader();
      }),
      bottomNavigationBar: _buildBottomNavigation(selectedIndex),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      toolbarHeight: Dimensions.height10 * 10,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getInitial());
        },
        child: Image.asset(
          Constants.appBarLogo,
          height: Dimensions.appBarLogoHeight,
          width: Dimensions.appBarLogoWidth,
        ),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10, vertical: Dimensions.height10),
            child: SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(Dimensions.radius20 / 2),
                  prefixIcon: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.btnColorBlueDark,
                  ),
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius8),
                        bottomRight: Radius.circular(Dimensions.radius8),
                      ),
                      color: AppColors.btnColorBlueDark,
                    ),
                    child: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search by keyword',
                  hintMaxLines: 1,
                ),
              ),
            ),
          )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Stack(
                children: [
                  AppIcon(
                    icon: CupertinoIcons.heart,
                    backgroundColor: Colors.transparent,
                    size: 50,
                    iconSize: 28,
                    iconColor: Colors.white,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: AppIcon(
                      icon: Icons.circle,
                      size: 24,
                      iconColor: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 5,
                    child: BigText(
                      text: '0',
                      size: 12,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              onTap: () {
                //Goto Wishlist
                Get.toNamed(RouteHelper.getWishListPage());
              },
            ),
            GestureDetector(
              child: Stack(
                children: [
                  AppIcon(
                    icon: CupertinoIcons.shopping_cart,
                    backgroundColor: Colors.transparent,
                    size: 50,
                    iconSize: 28,
                    iconColor: Colors.white,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: AppIcon(
                      icon: Icons.circle,
                      size: 24,
                      iconColor: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 5,
                    child: BigText(
                      text: '0',
                      size: 12,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              onTap: () {
                //Goto Cart
              },
            ),
            IconButton(
              /*icon: const FaIcon(
                FontAwesomeIcons.userCircle,
                color: Colors.black54,
              ),*/
              icon: const Icon(
                CupertinoIcons.person_crop_circle,
                color: Colors.white,
              ),
              tooltip: 'Profile',
              onPressed: () {
                isUserLoggedIn
                    ? Get.toNamed(RouteHelper.getAccountPage())
                    : Get.toNamed(RouteHelper.getLoginPage());
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(int selectedIndex) {
    return DiamondBottomNavigation(
      itemIcons: const [
        CupertinoIcons.home,
        CupertinoIcons.line_horizontal_3,
        CupertinoIcons.cart,
        CupertinoIcons.chat_bubble,
      ],
      itemName: const ['Home', 'Category', '', 'Cart', 'Chat'],
      centerIcon: Icons.place,
      selectedIndex: selectedIndex,
      onItemPressed: onPressed,
      selectedColor: AppColors.btnColorBlueDark,
      unselectedColor: Colors.black,
    );
  }

  void onPressed(index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        setState(() {
          selectedIndex = 0;
        });
        Get.offNamed(RouteHelper.getInitial());
      } else if (index == 1) {
        setState(() {
          selectedIndex = 1;
        });
        Get.offNamed(RouteHelper.getInitial());
      } else if (index == 2) {
        //Refresh home page
        setState(() {
          selectedIndex = 2;
        });
        Get.offNamed(RouteHelper.getInitial());
      } else if (index == 3) {
        //Cart Page
        setState(() {
          selectedIndex = 3;
        });
        Get.offNamed(RouteHelper.getInitial());
      } else if (index == 4) {
        //Chat Page
        setState(() {
          selectedIndex = 4;
        });
        Get.offNamed(RouteHelper.getInitial());
      } else {
        setState(() {
          selectedIndex = index;
        });
        Get.offNamed(RouteHelper.getInitial());
      }
    });
  }
}
