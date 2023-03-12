import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skybuybd/base/footer.dart';
import 'package:skybuybd/controller/cart_controller.dart';
import 'package:skybuybd/models/wishlist_model.dart';

import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../home/home_page.dart';
import 'package:get/get.dart';
import '../home/widgets/dimond_bottom_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {

  late bool isUserLoggedIn;

  List<Wishlist> wishlist = [];

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
      if(file != null){
        //showCustomSnakebar("Image picked successfully",isError: false,title: "Image",color: AppColors.primaryColor);
        //Get.find<ProductController>().uploadImage(file!);
        Get.toNamed(RouteHelper.getSearchPage("","image",file!.path));
      }else{
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
      if(file != null){
        //showCustomSnakebar("Image picked successfully",isError: false,title: "Image",color: AppColors.primaryColor);
        //Get.find<ProductController>().uploadImage(file!);
        Get.toNamed(RouteHelper.getSearchPage("","image",file!.path));
      }else{
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
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    Get.find<CartController>().getWishList();
  }
  
  @override
  Widget build(BuildContext context) {
    // Focus nodes are necessary
    final textFieldFocusNode = FocusNode();
    TextEditingController controller = TextEditingController();
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(textFieldFocusNode,controller),
          body: GetBuilder<CartController>(builder: (cartController){

            wishlist = cartController.wishlist;

            return cartController.isWishListLoaded ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //color: Colors.redAccent,
                    height: (wishlist.length*((Dimensions.height100*2)+Dimensions.height50)),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10),
                    child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        childAspectRatio: 2/1.1,
                        padding: EdgeInsets.zero,
                        crossAxisCount: 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        children: wishlist.map((data) {
                          return GestureDetector(
                            onTap: (){
                              //Get.toNamed(RouteHelper.getSingleProductPage(data.id!));
                            },
                            child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.width15/2),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: Dimensions.height20*4,
                                        width: Dimensions.width50*2,
                                        decoration: BoxDecoration(
                                           image: DecorationImage(
                                             image: NetworkImage(data.mainPictureUrl!),
                                               fit: BoxFit.cover
                                             ),
                                             shape: BoxShape.rectangle,
                                             borderRadius: BorderRadius.circular(Dimensions.radius15/3)
                                          )
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      Text(
                                        data.title!,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "৳ ${data.originalPrice}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width30),
                                          AppIcon(
                                            icon: CupertinoIcons.delete,
                                            iconColor: Colors.white,
                                            backgroundColor: AppColors.primaryColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          );
                        }).toList()
                    ),
                  ),
                  Container(
                    child: const Footer(),
                  ),
                ],
              ),
            ) : const Center(child: CircularProgressIndicator());
          }),
        ),
      ),
      onWillPop: () async{
        Navigator.pop(Get.context!);
        return false;
      },
    );
  }

  AppBar _buildAppBar(FocusNode textFieldFocusNode,TextEditingController controller) {
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
          preferredSize: Size.fromHeight(Dimensions.height56),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10,
                vertical: Dimensions.height10
            ),
            child: SizedBox(
              height: Dimensions.height45,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(Dimensions.radius20/2),
                  prefixIcon: GestureDetector(
                    onTap: (){
                      _showPicker(context);
                    },
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.btnColorBlueDark,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      //Text Search
                      textFieldFocusNode.unfocus();
                      textFieldFocusNode.canRequestFocus = false;

                      String keyword = controller.text;
                      if(keyword.isEmpty){
                        showCustomSnakebar("Search keyword is empty!",isError: false,title: "Search Error");
                      }else{
                        Get.toNamed(RouteHelper.getSearchPage(keyword,"keyword",""));
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
                        color: Colors.black,
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
                isUserLoggedIn ? Get.toNamed(RouteHelper.getAccountPage()) : Get.toNamed(RouteHelper.getLoginPage());
              },
            ),
          ],
        ),
      ],
    );
  }

}

