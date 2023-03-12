import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skybuybd/apps/core/presentation/widgets/app_drawer.dart';
import 'package:skybuybd/controller/category_product_controller.dart';
import 'package:skybuybd/pages/home/widgets/main_app_bar.dart';
import 'package:skybuybd/utils/value_utility.dart';

import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';
import '../../controller/home_controller.dart';
import '../../models/category/category_product_model.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../home/home_page_body.dart';
import '../home/widgets/dimond_bottom_bar.dart';
import 'single_product_page.dart';
import 'package:get/get.dart';
import '../home/widgets/dimond_bottom_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

///Category Product
class CategoryProduct extends StatefulWidget {
  final String parentCatName;
  final String subCatName;
  final String childCatName;
  final String childCatSlug;
  const CategoryProduct(
      {Key? key,
      required this.parentCatName,
      required this.subCatName,
      required this.childCatName,
      required this.childCatSlug})
      : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  late bool isUserLoggedIn;
  int selectedIndexBottom = -1;

  double priceFactor = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (Get.find<HomeController>()
            .getSharedPref()
            .containsKey(Constants.CONVERSION_RATE)) {
          priceFactor = Get.find<HomeController>()
              .getSharedPref()
              .getDouble(Constants.CONVERSION_RATE)!;
        } else {
          priceFactor = 20.0;
        }
      });
    });
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    Get.find<CategoryProductController>()
        .getCategoryProductList(widget.childCatSlug);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const AppDrawer(),
        backgroundColor: AppColors.pageBg,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: MainAppBar(),
        ),
        body:
            GetBuilder<CategoryProductController>(builder: (catProdController) {
          return catProdController.isLoaded
              ? _buildBody(catProdController)
              : const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                );
        }),
        bottomNavigationBar: DiamondBottomNavigation(
          itemIcons: const [
            CupertinoIcons.home,
            CupertinoIcons.line_horizontal_3,
            CupertinoIcons.cart,
            CupertinoIcons.chat_bubble,
          ],
          itemName: const ['Home', 'Category', '', 'Cart', 'Chat'],
          centerIcon: Icons.place,
          selectedIndex: BottomNavUtility.index.value,
          onItemPressed: (value) {
            if (value == 1) {
              scaffoldKey.currentState?.openDrawer();
            } else {
              BottomNavUtility.index.value = value;
            }
          },
          selectedColor: AppColors.btnColorBlueDark,
          unselectedColor: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody(CategoryProductController catProdController) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 60,
              color: Colors.white,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Home',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black,
                  ),
                  Text(
                    widget.parentCatName ?? '',
                    style: TextStyle(
                        fontSize: 13, color: Colors.black.withOpacity(0.8)),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black,
                  ),
                  Text(
                    widget.subCatName ?? '',
                    style: TextStyle(
                        fontSize: 13, color: Colors.black.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              child: Container(
                child: _buildProductGrid(catProdController.categoryProductList),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<CategoryProductModel> prodList) {
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 1260,
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                childAspectRatio: 1 / 1.3,
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: prodList.map((data) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSingleProductPage(data.id!));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: AppColors.borderColor,
                            width: 1.0,
                          ),
                          top: BorderSide(
                            color: AppColors.borderColor,
                            width: 1.0,
                          ),
                          left: BorderSide(
                            color: AppColors.borderColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              data.mainPictureUrl!,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: Text(
                              data.title!,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '৳ ${(data.price?.originalPrice * priceFactor).round()}',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'SOLD: 3242',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
