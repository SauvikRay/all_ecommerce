import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skybuybd/base/footer.dart';

import '../../controller/auth_controller.dart';
import '../home/widgets/dimond_bottom_bar.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import 'package:get/get.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  late bool isUserLoggedIn;
  bool isSignInSelected = false;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {

    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigation(selectedIndex),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      toolbarHeight: Dimensions.height10*10,
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
                horizontal: Dimensions.width10,
                vertical: Dimensions.height10
            ),
            child: SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(Dimensions.radius20/2),
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
          )
      ),
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
                    right:8,
                    top:5,
                    child: BigText(
                      text: '0',
                      size: 12,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              onTap: (){
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
                    right:8,
                    top:5,
                    child: BigText(
                      text: '0',
                      size: 12,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              onTap: (){
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
                isUserLoggedIn ? Get.toNamed(RouteHelper.getAccountPage()) : Get.toNamed(RouteHelper.getLoginPage());
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.maxFinite,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),
                  ),
                  SizedBox(height:10),
                  Text(
                    'Email Address',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14
                    ),
                  ),
                  SizedBox(height:10),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFE3E8F0),
                            width: 1.5
                        )
                    ),
                    child: TextField(
                      textAlign: TextAlign.start ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(Dimensions.radius8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: Dimensions.radius20/2,
                          top: Dimensions.radius20/2,
                          bottom: Dimensions.radius20/2,
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
                    width: double.maxFinite,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(3)
                    ),
                    child: Center(
                      child: Text(
                        'Send Password Reset Link',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'OR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Have an account? ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "Sign In now",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                isSignInSelected = true;
                                Get.offNamed(RouteHelper.getLoginPage());
                              },
                          ),

                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
            thickness: 20,
          ),
          Footer()
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(int selectedIndex){
    return DiamondBottomNavigation(
      itemIcons: const [
        CupertinoIcons.home,
        CupertinoIcons.line_horizontal_3,
        CupertinoIcons.cart,
        CupertinoIcons.chat_bubble,
      ],
      itemName: const [
        'Home','Category','','Cart','Chat'
      ],
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
      }else if (index == 1) {
        setState(() {
          selectedIndex = 1;
        });
        Get.offNamed(RouteHelper.getInitial());
      }else if (index == 2) {
        //Refresh home page
        setState(() {
          selectedIndex = 2;
        });
        Get.offNamed(RouteHelper.getInitial());
      }else if (index == 3) {
        //Cart Page
        setState(() {
          selectedIndex = 3;
        });
        Get.offNamed(RouteHelper.getInitial());
      }else if (index == 4) {
        //Chat Page
        setState(() {
          selectedIndex = 4;
        });
        Get.offNamed(RouteHelper.getInitial());
      }else{
        setState(() {
          selectedIndex = index;
        });
        Get.offNamed(RouteHelper.getInitial());
      }
    });
  }

}
