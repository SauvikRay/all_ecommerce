import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skybuybd/controller/category_controller.dart';
import 'package:skybuybd/pages/home/home_page.dart';
import 'package:skybuybd/pages/product/category_product.dart';

import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

import 'package:get/get.dart';

import '../home/widgets/dimond_bottom_bar.dart';
import '../home/widgets/dimond_bottom_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

///Child Category Page
class SubCategoryPage extends StatefulWidget {
  final String parentCatName;
  final String subCatName;
  final String subCatSlug;
  const SubCategoryPage({
    Key? key,
    required this.parentCatName,
    required this.subCatName,
    required this.subCatSlug,
  }) : super(key: key);

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  late bool isUserLoggedIn;
  int selectedIndexBottom = -1;

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
    Get.find<CategoryController>().getSubCategoryList(widget.subCatSlug);
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
  }

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
          preferredSize: Size.fromHeight(Dimensions.height10 * 4),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10, vertical: Dimensions.height10),
            child: SizedBox(
              height: Dimensions.height45,
              child: TextField(
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
                      Future.delayed(Duration(milliseconds: 100), () {
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
                Get.toNamed(RouteHelper.getInitial());
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.pageBg,
        appBar: _buildAppBar(textFieldFocusNode, controller),
        body: GetBuilder<CategoryController>(builder: (categoryController) {
          return categoryController.isLoaded
              ? _buildBody(categoryController)
              : const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor));
        }),
        bottomNavigationBar: _buildDiamondBottomNavigation(),
      ),
      onWillPop: () async {
        Get.toNamed(RouteHelper.getInitial());
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

  Widget _buildBody(CategoryController categoryController) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width15,
        right: Dimensions.width15,
        top: Dimensions.width15,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subCatName,
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
                Icon(
                  Icons.arrow_forward_ios,
                  size: Dimensions.iconSize16,
                  color: Colors.black,
                ),
                Text(
                  widget.subCatName,
                  style: TextStyle(
                      fontSize: Dimensions.font14,
                      color: Colors.black.withOpacity(0.8)),
                ),
              ],
            ),
            SizedBox(height: Dimensions.height15),
            Container(
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
                        Get.toNamed(RouteHelper.getCategoryProductPage(
                            widget.parentCatName,
                            widget.subCatName,
                            data.name!,
                            data.slug!));
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
