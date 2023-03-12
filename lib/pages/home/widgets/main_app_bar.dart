import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybuybd/controller/auth_controller.dart';
import 'package:skybuybd/pages/home/widgets/search_bar.dart';
import 'package:skybuybd/route/route_helper.dart';
import 'package:skybuybd/utils/app_colors.dart';
import 'package:skybuybd/utils/constants.dart';
import 'package:skybuybd/utils/dimentions.dart';
import 'package:skybuybd/widgets/app_icon.dart';
import 'package:skybuybd/widgets/big_text.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late bool isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();

    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      toolbarHeight: Dimensions.height10 * 10,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Image.asset(
        Constants.appBarLogo,
        height: Dimensions.appBarLogoHeight,
        width: Dimensions.appBarLogoWidth,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.height10 * 4),
        child: const SearchBar(),
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
                isUserLoggedIn
                    ? Get.toNamed(RouteHelper.getWishListPage())
                    : Get.toNamed(RouteHelper.getLoginPage());
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
                // setState(() {
                //   selectedIndex = 3;
                // });
              },
            ),
            IconButton(
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
}
