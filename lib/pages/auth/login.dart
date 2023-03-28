import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybuybd/base/custom_loader.dart';
import 'package:skybuybd/base/footer.dart';
import 'package:skybuybd/common_widgets/appbar.dart';
import 'package:skybuybd/controller/auth_controller.dart';

import '../../base/show_custom_snakebar.dart';
import '../home/home_page.dart';
import '../home/widgets/dimond_bottom_bar.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool isUserLoggedIn;

  int selectedIndex = -1;
  bool isOtpSelected = true;
  bool isEmailSelected = false;

  //Controllers
  TextEditingController ecPhone = TextEditingController();
  TextEditingController ecEmail = TextEditingController();
  TextEditingController ecPass = TextEditingController();

  //With email
  TextEditingController ecEmailCon = TextEditingController();
  TextEditingController ecPassCon = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    ecPhone.dispose();
    ecEmail.dispose();
    ecPass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: CustomAppbar(),
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? _buildBody(width, authController)
            : const CustomLoader();
      }),
      // bottomNavigationBar: _buildBottomNavigation(selectedIndex),
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

  Widget _buildBody(double width, AuthController authController) {
    return Container(
      width: width,
      height: isEmailSelected ? 520 + 740 : 500 + 740,
      color: Colors.grey,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: isEmailSelected ? 520 : 500,
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
              //margin: EdgeInsets.only(left: 20,right: 20,top: 20),
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                          color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "to continue to ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "Skybuybd",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 40,
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              color: AppColors.borderColor,
                              width: 0.0,
                              style: BorderStyle.solid),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 5,
                                spreadRadius: 2,
                                color: AppColors.borderColor),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/social/facebook.png',
                            height: 28,
                            width: 28,
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'Continue with Facebook',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.btnColorBlueDark),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'OR',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isOtpSelected = true;
                                isEmailSelected = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isOtpSelected
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                border: Border(
                                  top: BorderSide(
                                    color: isOtpSelected
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: isOtpSelected ? 0.5 : 0.5,
                                  ),
                                  bottom: BorderSide(
                                    color: isOtpSelected
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: isOtpSelected ? 0.5 : 0.5,
                                  ),
                                  left: BorderSide(
                                    color: isOtpSelected
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: isOtpSelected ? 0.5 : 0.5,
                                  ),
                                  right: BorderSide(
                                    color: isOtpSelected
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: isOtpSelected ? 0.5 : 0.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                textAlign: TextAlign.center,
                                'With OTP',
                                style: TextStyle(
                                  color: isOtpSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isOtpSelected = false;
                                isEmailSelected = true;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isEmailSelected
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                border: Border(
                                  top: BorderSide(
                                    color: isEmailSelected
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: isEmailSelected ? 0.5 : 0.5,
                                  ),
                                  bottom: BorderSide(
                                    color: isEmailSelected
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: isEmailSelected ? 0.5 : 0.5,
                                  ),
                                  right: BorderSide(
                                    color: isEmailSelected
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: isEmailSelected ? 0.5 : 0.5,
                                  ),
                                  left: BorderSide(
                                    color: isEmailSelected
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: isEmailSelected ? 0.5 : 0.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                'With Email',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isEmailSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: isOtpSelected
                          ? otpContainer(authController)
                          : emailContainer(authController),
                      transitionBuilder: (child, animation) => SlideTransition(
                        child: child,
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed(RouteHelper.getForgotPasswordPage());
                      },
                      child: const Text(
                        'Forgot password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "New to Skybuybd? ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "Create an account",
                            style: const TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed(RouteHelper.getRegisterPage());
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Footer()
          ],
        ),
      ),
    );
  }

  Widget otpContainer(AuthController authController) {
    return Container(
      key: ValueKey(1),
      height: 130,
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE3E8F0), width: 1.5)),
            child: TextField(
              textAlign: TextAlign.center,
              controller: ecPhone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  //borderRadius: BorderRadius.circular(Dimensions.radius8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.only(
                  left: 30,
                  right: Dimensions.radius20 / 2,
                  top: Dimensions.radius20 / 2,
                  bottom: Dimensions.radius20 / 2,
                ),
                prefixIcon: Container(
                  width: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    color: Color(0xFFE3E8F0),
                  ),
                  child: const Center(
                    child: Text(
                      '+88',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF2a2a2a)),
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Phone Number',
                hintMaxLines: 1,
              ),
            ),
          ),
          SizedBox(height: 5),
          const Text(
            'e.g: 01938235071',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.black87),
          ),
          SizedBox(height: 20),
          Container(
            height: 40,
            width: double.maxFinite,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(3)),
            child: GestureDetector(
              onTap: () {
                otpLogin(authController);
              },
              child: const Center(
                child: Text(
                  'SIGN UP / LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailContainer(AuthController authController) {
    return Container(
      key: ValueKey(2),
      height: 160,
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE3E8F0), width: 1.5)),
            child: TextField(
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: ecEmailCon,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  //borderRadius: BorderRadius.circular(Dimensions.radius8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.only(
                  left: 20,
                  right: Dimensions.radius20 / 2,
                  top: Dimensions.radius20 / 2,
                  bottom: Dimensions.radius20 / 2,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'E-mail Address',
                hintMaxLines: 1,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE3E8F0), width: 1.5)),
            child: TextField(
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              controller: ecPassCon,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  //borderRadius: BorderRadius.circular(Dimensions.radius8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.only(
                  left: 20,
                  right: Dimensions.radius20 / 2,
                  top: Dimensions.radius20 / 2,
                  bottom: Dimensions.radius20 / 2,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                hintMaxLines: 1,
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              login(authController);
            },
            child: Container(
              height: 40,
              width: double.maxFinite,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(3)),
              child: const Center(
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login(AuthController authController) {
    String email = ecEmailCon.text;
    String pass = ecPassCon.text;
    if (email.isEmpty) {
      showCustomSnakebar('Type your email', title: "Email");
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnakebar('Type a valid email', title: "Invalid Email");
    } else if (pass.isEmpty) {
      showCustomSnakebar('Type your password', title: "Password");
    } else if (pass.length < 6) {
      showCustomSnakebar('The password must be at least 6 characters.',
          title: "Password");
    } else {
      authController.login(email, pass).then((status) {
        if (status.isSuccess) {

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
              // ModalRoute.withName(RouteHelper.getInitial()
              ((route) => false
              ),
            );
          // Get.toNamed(RouteHelper.getAccountPage());
        } else {
          showCustomSnakebar(status.message);
        }
      });
    }
  }

  void otpLogin(AuthController authController) {
    String phone = ecPhone.text;
    if (phone.isEmpty) {
      showCustomSnakebar('Type your phone number', title: "Phone");
    } else if (!GetUtils.isPhoneNumber(phone)) {
      showCustomSnakebar('Type a valid phone number', title: "Invalid Phone");
    } else {
      authController.sendOtp(phone).then((status) {
        if (status.isSuccess) {
          Get.toNamed(RouteHelper.getVerifyOtpPage(phone));
        } else {
          showCustomSnakebar(status.message);
        }
      });
    }
  }
}
