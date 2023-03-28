import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:skybuybd/controller/category_controller.dart';

import '../../provider/category_provider.dart';
import '../../route/route_helper.dart';
import '../../utils/dimentions.dart';
import '../product/category_product.dart';

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
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  late CategoryProvider categoryProvider;

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

    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.getSubCategory(widget.parentCatSlug);

    // isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //    if (Get.find<HomeController>()
    //         .getSharedPref()
    //         .containsKey(Constants.CONVERSION_RATE)) {
    //       priceFactor = Get.find<HomeController>()
    //           .getSharedPref()
    //           .getDouble(Constants.CONVERSION_RATE)!;
    //     } else {
    //       priceFactor = 20.0;
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CategoryController>().getSubCategoryList(widget.parentCatSlug);

    // Focus nodes are necessary
    final textFieldFocusNode = FocusNode();
    TextEditingController controller = TextEditingController();

    return _buildBody();
    // return Scaffold(
    // resizeToAvoidBottomInset: false,
    // backgroundColor: AppColors.pageBg,
    // appBar: _buildAppBar(textFieldFocusNode, controller),
    // body: GetBuilder<CategoryController>(builder: (categoryController) {
    //   return categoryController.isLoaded
    //       ? _buildBody(categoryController)
    //       : const Center(
    //           child:
    //               CircularProgressIndicator(color: AppColors.primaryColor));
    // }),
    // bottomNavigationBar: _buildDiamondBottomNavigation(),
    // );
  }

  // AppBar _buildAppBar(
  //     FocusNode textFieldFocusNode, TextEditingController controller) {
  //   return AppBar(
  //     backgroundColor: AppColors.primaryColor,
  //     elevation: 0,
  //     toolbarHeight: Dimensions.height10 * 10,
  //     centerTitle: false,
  //     automaticallyImplyLeading: false,
  //     title: GestureDetector(
  //       onTap: () {
  //         Get.toNamed(RouteHelper.getInitial());
  //       },
  //       child: Image.asset(
  //         Constants.appBarLogo,
  //         height: Dimensions.appBarLogoHeight,
  //         width: Dimensions.appBarLogoWidth,
  //       ),
  //     ),
  //     bottom: PreferredSize(
  //         preferredSize: Size.fromHeight(Dimensions.height10 * 4),
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(
  //               horizontal: Dimensions.width10, vertical: Dimensions.height10),
  //           child: SizedBox(
  //             height: Dimensions.height45,
  //             child: TextField(
  //               controller: controller,
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(Dimensions.radius8),
  //                   borderSide: BorderSide.none,
  //                 ),
  //                 contentPadding: EdgeInsets.all(Dimensions.radius20 / 2),
  //                 prefixIcon: GestureDetector(
  //                   onTap: () {
  //                     _showPicker(context);
  //                   },
  //                   child: const Icon(
  //                     Icons.camera_alt_rounded,
  //                     color: AppColors.btnColorBlueDark,
  //                   ),
  //                 ),
  //                 suffixIcon: GestureDetector(
  //                   onTap: () {
  //                     //Text Search
  //                     textFieldFocusNode.unfocus();
  //                     textFieldFocusNode.canRequestFocus = false;

  //                     String keyword = controller.text;
  //                     if (keyword.isEmpty) {
  //                       showCustomSnakebar("Search keyword is empty!",
  //                           isError: false, title: "Search Error");
  //                     } else {
  //                       Get.toNamed(
  //                           RouteHelper.getSearchPage(keyword, "keyword", ""));
  //                     }

  //                     //Enable the text field's focus node request after some delay
  //                     Future.delayed(const Duration(milliseconds: 100), () {
  //                       textFieldFocusNode.canRequestFocus = true;
  //                     });
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.only(
  //                         topRight: Radius.circular(Dimensions.radius8),
  //                         bottomRight: Radius.circular(Dimensions.radius8),
  //                       ),
  //                       color: AppColors.btnColorBlueDark,
  //                     ),
  //                     child: const Icon(
  //                       Icons.search_outlined,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //                 filled: true,
  //                 fillColor: Colors.white,
  //                 hintText: 'Search by keyword',
  //                 hintMaxLines: 1,
  //               ),
  //             ),
  //           ),
  //         )),
  //     actions: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           GestureDetector(
  //             child: Stack(
  //               children: [
  //                 AppIcon(
  //                   icon: CupertinoIcons.heart,
  //                   backgroundColor: Colors.transparent,
  //                   size: 50,
  //                   iconSize: 28,
  //                   iconColor: Colors.white,
  //                 ),
  //                 Positioned(
  //                   right: 0,
  //                   top: 0,
  //                   child: AppIcon(
  //                     icon: Icons.circle,
  //                     size: 24,
  //                     iconColor: Colors.white,
  //                     backgroundColor: Colors.transparent,
  //                   ),
  //                 ),
  //                 Positioned(
  //                   right: 8,
  //                   top: 5,
  //                   child: BigText(
  //                     text: '0',
  //                     size: 12,
  //                     color: Colors.black,
  //                   ),
  //                 )
  //               ],
  //             ),
  //             onTap: () {
  //               //Goto Wishlist
  //               Get.toNamed(RouteHelper.getWishListPage());
  //             },
  //           ),
  //           GestureDetector(
  //             child: Stack(
  //               children: [
  //                 AppIcon(
  //                   icon: CupertinoIcons.shopping_cart,
  //                   backgroundColor: Colors.transparent,
  //                   size: 50,
  //                   iconSize: 28,
  //                   iconColor: Colors.white,
  //                 ),
  //                 Positioned(
  //                   right: 0,
  //                   top: 0,
  //                   child: AppIcon(
  //                     icon: Icons.circle,
  //                     size: 24,
  //                     iconColor: Colors.white,
  //                     backgroundColor: Colors.transparent,
  //                   ),
  //                 ),
  //                 Positioned(
  //                   right: 8,
  //                   top: 5,
  //                   child: BigText(
  //                     text: '0',
  //                     size: 12,
  //                     color: Colors.black,
  //                   ),
  //                 )
  //               ],
  //             ),
  //             onTap: () {
  //               //Goto Cart
  //               Get.toNamed(RouteHelper.getInitial());
  //             },
  //           ),
  //           IconButton(
  //             /*icon: const FaIcon(
  //               FontAwesomeIcons.userCircle,
  //               color: Colors.black54,
  //             ),*/
  //             icon: const Icon(
  //               CupertinoIcons.person_crop_circle,
  //               color: Colors.white,
  //             ),
  //             tooltip: 'Profile',
  //             onPressed: () {
  //               isUserLoggedIn
  //                   ? Get.toNamed(RouteHelper.getAccountPage())
  //                   : Get.toNamed(RouteHelper.getLoginPage());
  //             },
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildDiamondBottomNavigation() {
  //   return DiamondBottomNavigation(
  //     itemIcons: const [
  //       CupertinoIcons.home,
  //       CupertinoIcons.line_horizontal_3,
  //       CupertinoIcons.cart,
  //       CupertinoIcons.chat_bubble,
  //     ],
  //     itemName: const ['Home', 'Category', '', 'Cart', 'Chat'],
  //     centerIcon: Icons.place,
  //     selectedIndex: selectedIndexBottom,
  //     onItemPressed: onPressed,
  //     selectedColor: AppColors.btnColorBlueDark,
  //     unselectedColor: Colors.black,
  //   );
  // }

  // void onPressed(index) {
  //   setState(() {
  //     selectedIndexBottom = index;
  //     if (index == 0) {
  //       setState(() {
  //         selectedIndexBottom = 0;
  //       });
  //       Get.toNamed(RouteHelper.getInitial());
  //     } else if (index == 1) {
  //       setState(() {
  //         selectedIndexBottom = 1;
  //       });
  //       Get.toNamed(RouteHelper.getInitial());
  //     } else if (index == 2) {
  //       //Refresh home page
  //       setState(() {
  //         selectedIndexBottom = 2;
  //       });
  //       Get.toNamed(RouteHelper.getInitial());
  //     } else if (index == 3) {
  //       //Cart Page
  //       setState(() {
  //         selectedIndexBottom = 3;
  //       });
  //       Get.toNamed(RouteHelper.getInitial());
  //     } else if (index == 4) {
  //       //Chat Page
  //       setState(() {
  //         selectedIndexBottom = 4;
  //       });
  //       Get.toNamed(RouteHelper.getInitial());
  //     } else {
  //       setState(() {
  //         selectedIndexBottom = index;
  //       });
  //     }
  //   });
  // }

  Widget _buildBody() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: Dimensions.width15,
        right: Dimensions.width15,
        top: Dimensions.width15,
        bottom: 30,
      ),
      child: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          List subCategoryList = provider.subCategoryList!;
          if (subCategoryList.isNotEmpty) {
            return GridView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemCount: provider.subCategoryList!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: CategoryProduct(
                        childCatSlug: subCategoryList[index].slug!,
                      ),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Container(
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo/300.png',
                          height: 80,
                          width: 80,
                        ),
                        Center(
                          child: Text(
                            subCategoryList[index].name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
        },
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
