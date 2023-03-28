import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';
import '../../controller/category_product_controller.dart';
import '../../controller/home_controller.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../home/widgets/dimond_bottom_bar.dart';

///Category Product
class CategoryProduct extends StatefulWidget {
  // final String parentCatName;
  // final String subCatName;
  // final String childCatName;
  final String childCatSlug;
  const CategoryProduct(
      {Key? key,
      // required this.parentCatName,
      // required this.subCatName,
      // required this.childCatName,
      required this.childCatSlug})
      : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  late bool isUserLoggedIn;
  int selectedIndexBottom = -1;

  double priceFactor = 1.0;

  //Image picker
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;

  _imageFromCamera() async {
    _image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (_image != null) {
      setState(() {
        file = File(_image!.path);
      });
      //saveInStorage(file!);
      if (file != null) {
        //showCustomSnakebar("Image picked successfully",isError: false,title: "Image",color: AppColors.primaryColor);
        //Get.find<ProductController>().uploadImage(file!);
        Get.toNamed(RouteHelper.getSearchPage("", "image", file!.path));
      } else {
        print("File is null");
      }
    }
  }

  _imageFromGallery() async {
    _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        file = File(_image!.path);
      });
      //saveInStorage(file!);
      if (file != null) {
        //showCustomSnakebar("Image picked successfully",isError: false,title: "Image",color: AppColors.primaryColor);
        //Get.find<ProductController>().uploadImage(file!);
        Get.toNamed(RouteHelper.getSearchPage("", "image", file!.path));
      } else {
        print("File is null");
      }
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Choose from camera'),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

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

  // @override
  // void initState() {
  //   Get.find<CategoryController>().getSubCategoryList(widget.childCatSlug);
  //   super.initState();
  // }

  AppBar _buildAppBar(
      FocusNode textFieldFocusNode, TextEditingController controller) {
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
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(Dimensions.radius20 / 2),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.btnColorBlueDark,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      //Text Search
                      textFieldFocusNode.unfocus();
                      textFieldFocusNode.canRequestFocus = false;

                      String keyword = controller.text;
                      if (keyword.isEmpty) {
                        showCustomSnakebar("Search keyword is empty!",
                            isError: false, title: "Search Error");
                      } else {
                        Get.toNamed(
                            RouteHelper.getSearchPage(keyword, "keyword", ""));
                      }

                      //Enable the text field's focus node request after some delay
                      Future.delayed(const Duration(milliseconds: 100), () {
                        textFieldFocusNode.canRequestFocus = true;
                      });
                    },
                    child: Container(
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

  @override
  Widget build(BuildContext context) {
    // Focus nodes are necessary
    final textFieldFocusNode = FocusNode();
    TextEditingController controller = TextEditingController();

    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
            // backgroundColor: AppColors.pageBg,
            // appBar: _buildAppBar(textFieldFocusNode, controller),
            // body: GetBuilder<CategoryProductController>(
            //     builder: (catProdController) {
            //   return catProdController.isLoaded
            //       ? _buildBody(catProdController)
            //       : const Center(
            //           child: CircularProgressIndicator(
            //               color: AppColors.primaryColor),
            //         );
            // }),
            // bottomNavigationBar: _buildDiamondBottomNavigation(),
            ),
      ),
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
    );
  }

  Widget _buildDiamondBottomNavigation() {
    return DiamondBottomNavigation(
      itemIcons: const [
        CupertinoIcons.home,
        CupertinoIcons.line_horizontal_3,
        CupertinoIcons.cart,
        CupertinoIcons.chat_bubble,
      ],
      itemName: const ['Home', 'Category', '', 'Cart', 'Chat'],
      centerIcon: Icons.place,
      selectedIndex: selectedIndexBottom,
      onItemPressed: onPressed,
      selectedColor: AppColors.btnColorBlueDark,
      unselectedColor: Colors.black,
    );
  }

  void onPressed(index) {
    setState(() {
      selectedIndexBottom = index;
      if (index == 0) {
        setState(() {
          selectedIndexBottom = 0;
        });
        Get.toNamed(RouteHelper.getInitial());
      } else if (index == 1) {
        setState(() {
          selectedIndexBottom = 1;
        });
        Get.toNamed(RouteHelper.getInitial());
      } else if (index == 2) {
        //Refresh home page
        setState(() {
          selectedIndexBottom = 2;
        });
        Get.toNamed(RouteHelper.getInitial());
      } else if (index == 3) {
        //Cart Page
        setState(() {
          selectedIndexBottom = 3;
        });
        Get.toNamed(RouteHelper.getInitial());
      } else if (index == 4) {
        //Chat Page
        setState(() {
          selectedIndexBottom = 4;
        });
        Get.toNamed(RouteHelper.getInitial());
      } else {
        setState(() {
          selectedIndexBottom = index;
        });
      }
    });
  }

  // Widget _buildBody(CategoryProductController catProdController) {
  //   return Container(
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 60,
  //             color: Colors.white,
  //             padding: EdgeInsets.all(16),
  //             margin: EdgeInsets.only(left: 16, right: 16, top: 16),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 const Text(
  //                   'Home',
  //                   style: TextStyle(fontSize: 14, color: Colors.black),
  //                 ),
  //                 const Icon(
  //                   Icons.arrow_forward_ios,
  //                   size: 16,
  //                   color: Colors.black,
  //                 ),
  //                 Text(
  //                   widget.parentCatName ?? '',
  //                   style: TextStyle(
  //                       fontSize: 13, color: Colors.black.withOpacity(0.8)),
  //                 ),
  //                 const Icon(
  //                   Icons.arrow_forward_ios,
  //                   size: 16,
  //                   color: Colors.black,
  //                 ),
  //                 Text(
  //                   widget.subCatName ?? '',
  //                   style: TextStyle(
  //                       fontSize: 13, color: Colors.black.withOpacity(0.8)),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             color: Colors.white,
  //             padding: EdgeInsets.all(16),
  //             margin: EdgeInsets.all(16),
  //             child: Container(
  //               child: _buildProductGrid(catProdController.categoryProductList),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildProductGrid(List<CategoryProductModel> prodList) {
  //   return Container(
  //     width: double.maxFinite,
  //     color: Colors.white,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Container(
  //           height: 1260,
  //           child: GridView.count(
  //               physics: const NeverScrollableScrollPhysics(),
  //               scrollDirection: Axis.vertical,
  //               childAspectRatio: 1 / 1.3,
  //               padding:
  //                   const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
  //               crossAxisCount: 2,
  //               crossAxisSpacing: 0,
  //               mainAxisSpacing: 0,
  //               children: prodList.map((data) {
  //                 return GestureDetector(
  //                   onTap: () {
  //                     Get.toNamed(RouteHelper.getSingleProductPage(data.id!));
  //                   },
  //                   child: Container(
  //                     decoration: const BoxDecoration(
  //                       border: Border(
  //                         right: BorderSide(
  //                           color: AppColors.borderColor,
  //                           width: 1.0,
  //                         ),
  //                         top: BorderSide(
  //                           color: AppColors.borderColor,
  //                           width: 1.0,
  //                         ),
  //                         left: BorderSide(
  //                           color: AppColors.borderColor,
  //                           width: 1.0,
  //                         ),
  //                       ),
  //                     ),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Padding(
  //                           padding: const EdgeInsets.all(10.0),
  //                           child: Image.network(
  //                             data.mainPictureUrl!,
  //                             height: 120,
  //                             width: double.infinity,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(
  //                               horizontal: 16, vertical: 5),
  //                           child: Text(
  //                             data.title!,
  //                             textAlign: TextAlign.end,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: const TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.black,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(
  //                               horizontal: 16, vertical: 5),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text(
  //                                 '৳ ${(data.price?.originalPrice * priceFactor).round()}',
  //                                 textAlign: TextAlign.end,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 style: const TextStyle(
  //                                     fontSize: 12,
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                               Text(
  //                                 'SOLD: 3242',
  //                                 textAlign: TextAlign.end,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 style: const TextStyle(
  //                                     fontSize: 12, color: Colors.grey),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               }).toList()),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
