import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skybuybd/models/wishlist_model.dart';
import 'package:skybuybd/pages/account/account_page.dart';
import 'package:skybuybd/pages/auth/login.dart';

import '../base/show_custom_snakebar.dart';
import '../controller/auth_controller.dart';
import '../pages/cart/cart_page.dart';
import '../pages/product/search_product.dart';
import '../pages/wishlist/wishlist_page.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../utils/dimentions.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(125);
}

class _CustomAppbarState extends State<CustomAppbar> {
  late bool isUserLoggedIn;
  final textFieldFocusNode = FocusNode();

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      // toolbarHeight: Dimensions.height10 * 10,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Image.asset(
        Constants.appBarLogo,
        height: Dimensions.appBarLogoHeight,
        width: Dimensions.appBarLogoWidth,
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.height10 * 4),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10, vertical: Dimensions.height10),
            child: SizedBox(
              height: Dimensions.height45,
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
                        // Get.toNamed(
                        //     // RouteHelper.getSearchPage(keyword, "keyword", ""));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage(
                             searchKey: keyword,
                            type: "keyword",
                            // filePath: filePath!
                            ),)
                        );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WishlistPage(),
                  ),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(
                      cartlist: [],
                    ),
                  ),
                );
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
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountPage(),
                        ),
                      )
                    : Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                         (route) => false);
              },
            ),
          ],
        ),
      ],
    );
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
                // _imageFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Choose from camera'),
              onTap: () {
                // _imageFromCamera();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    },
  );
}

// _imageFromGallery() async {
//   _image = await _picker.pickImage(source: ImageSource.gallery);
//   if (_image != null) {
//     setState(() {
//       file = File(_image!.path);
//     });
//     //saveInStorage(file!);
//     if (file != null) {
//       //showCustomSnakebar("Image picked successfully",isError: false,title: "Image",color: AppColors.primaryColor);
//       //Get.find<ProductController>().uploadImage(file!);
//       Get.toNamed(RouteHelper.getSearchPage("", "image", file!.path));
//     } else {
//       print("File is null");
//     }
//   }
// }
