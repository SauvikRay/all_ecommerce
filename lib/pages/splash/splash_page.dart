import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skybuybd/controller/category_controller.dart';
import 'package:skybuybd/controller/home_controller.dart';
import 'package:skybuybd/pages/auth/login/login_page.dart';
import 'package:skybuybd/utils/app_colors.dart';
import 'package:skybuybd/utils/constants.dart';
import 'package:skybuybd/utils/dimentions.dart';

import '../../controller/category_product_controller.dart';
import '../../route/route_helper.dart';
import '../home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _loadResources() async {
    await Get.find<HomeController>().getConversionRate();
    await Get.find<HomeController>().getShippingText();
    await Get.find<HomeController>().getHomePageItem();
    await Get.find<CategoryController>().getParentCategoryList();
    await Get.find<CategoryProductController>().getShoeList();
    await Get.find<CategoryProductController>().getBagList();
    await Get.find<CategoryProductController>().getJewelryList();
    await Get.find<CategoryProductController>().getBabyList();
    await Get.find<CategoryProductController>().getWatchList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();

    if (kDebugMode) {
      print(Dimensions.screenHeight);
      print(Dimensions.screenWidth);
    }

    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.primaryColor,
          child: Stack(
            children: [
              Positioned(
                top: Dimensions.height200,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo/300w.png',
                        height: Dimensions.height30 * 6,
                        width: Dimensions.width30 * 5,
                      ),
                      //SizedBox(height: 5),
                      Text(
                        'Sky Buy',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 48,
                            fontFamily: 'times new roman'),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(bottom: Dimensions.height50),
                  child: const Center(
                    child: Text(
                      '\u00a9 ${Constants.APP_NAME}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: Constants.delay), () {});
    // Get.toNamed(RouteHelper.getInitial());
    Get.toNamed(RouteHelper.getSingleProductPage("abb-624289340878"));
  }
}
