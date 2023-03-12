import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybuybd/controller/category_controller.dart';
import 'package:skybuybd/pages/home/widgets/main_app_bar.dart';

import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';
import '../../controller/home_controller.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';

///Sub Category Page
class CategoryPage extends StatefulWidget {
  final String parentCatName;
  final String parentCatSlug;
  const CategoryPage({
    Key? key,
    required this.parentCatName,
    required this.parentCatSlug,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late bool isUserLoggedIn;
  int selectedIndexBottom = -1;

  double priceFactor = 1.0;

  //Image picker
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  File? file;

  @override
  void initState() {
    super.initState();
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();

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
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CategoryController>().getSubCategoryList(widget.parentCatSlug);

    // Focus nodes are necessary
    final textFieldFocusNode = FocusNode();
    TextEditingController controller = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.pageBg,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: MainAppBar(),
      ),
      body: GetBuilder<CategoryController>(builder: (categoryController) {
        return categoryController.isLoaded
            ? _buildBody(categoryController)
            : const Center(
                child:
                    CircularProgressIndicator(color: AppColors.primaryColor));
      }),
    );
  }

  Widget _buildBody(CategoryController categoryController) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width15,
        right: Dimensions.width15,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.height20),
            Text(
              widget.parentCatName,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.font24),
            ),
            SizedBox(height: Dimensions.height20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: Text(
                    'Home',
                    style: TextStyle(
                        fontSize: Dimensions.font14,
                        color: AppColors.primaryColor),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: Dimensions.iconSize16,
                  color: Colors.black,
                ),
                Text(
                  widget.parentCatName,
                  style: TextStyle(
                      fontSize: Dimensions.font14,
                      color: Colors.black.withOpacity(0.8)),
                ),
              ],
            ),
            SizedBox(height: Dimensions.height15),
            SizedBox(
              height: 900,
              child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.only(
                      left: 0,
                      right: 0,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10),
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  children: categoryController.subCategoryList.map((data) {
                    return GestureDetector(
                      onTap: () {
                        //category product
                        //Get.toNamed(RouteHelper.getSubCategoryPage(data.id!, widget.catName, data.name!, data.slug!));
                        showCustomSnakebar("Please wait...",
                            isError: false,
                            title: "Category",
                            color: Colors.green);
                        Get.find<CategoryController>()
                            .getSubCategoryList(data.slug!)
                            .then((response) {
                          if (response.isSuccess) {
                            if (response.message == "child") {
                              if (kDebugMode) {
                                print("Going to child category page");
                              }
                              //Child exist
                              Get.toNamed(RouteHelper.getChildCategoryPage(
                                  widget.parentCatName,
                                  data.name!,
                                  data.slug!));
                            } else if (response.message == "product") {
                              if (kDebugMode) {
                                print("Going to product page");
                              }
                              //Product exist
                              Get.toNamed(RouteHelper.getCategoryProductPage(
                                  widget.parentCatName,
                                  data.name!,
                                  "",
                                  data.slug!));
                            }
                          } else {
                            if (kDebugMode) {
                              print("Error homepage category item click;");
                            }
                          }
                        });

                        ///check if child category exist
                        /*if(categoryController.isChildCategoryExist){
                          Get.toNamed(RouteHelper.getChildCategoryPage(widget.parentCatName, data.name!, data.slug!));
                        }else{
                          //Go to category Product
                          Get.toNamed(RouteHelper.getCategoryProductPage(widget.parentCatName, data.name!, "", data.slug!));
                        }*/
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              'https://www.skybuybd.com/storage/setting/loader/300.png',
                              height: Dimensions.height100,
                            ),
                            SizedBox(height: Dimensions.height10),
                            Text(
                              data.name!,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: Dimensions.font14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
            )
          ],
        ),
      ),
    );
  }
}

//SubCategory Item
class SubCategory {
  int id;
  String title;
  String img;

  SubCategory(this.id, this.title, this.img);
}
