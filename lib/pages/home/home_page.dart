import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:skybuybd/base/show_custom_snakebar.dart';
import 'package:skybuybd/common_widgets/appbar.dart';
import 'package:skybuybd/pages/cart/cart_page.dart';
import 'package:skybuybd/pages/home/home_page_body.dart';
import 'package:skybuybd/pages/home/widgets/complex_drawer1.dart';
import 'package:skybuybd/pages/home/widgets/dimond_bottom_bar.dart';
import 'package:skybuybd/utils/app_colors.dart';
import 'package:skybuybd/utils/constants.dart';
import 'package:skybuybd/utils/dimentions.dart';
import 'package:skybuybd/widgets/app_icon.dart';
import 'package:skybuybd/widgets/big_text.dart';

import '../../controller/auth_controller.dart';
import '../../route/route_helper.dart';
import '../account/account_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isUserLoggedIn;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 2;
  int selectedIndexBottom = 0;
  String text = "Home";

  List pages = [
    HomePageBody(),
    AccountPage(),
    HomePageBody(),
    CartPage(
      cartlist: [],
    ),
    Container(child: Center(child: Text('Chat'))),
  ];

  void onTapNav(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else if (index == 1) {
      _scaffoldKey.currentState?.openDrawer(); // CHANGE THIS LINE
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

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
    print("okkkk");
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  int selectedItem = 0;

  List<Widget> _buildScreens() {
    return [
      HomePageBody(),
      HomePageBody(),
      HomePageBody(),
      CartPage(
        cartlist: [],
      ),
      Container(child: Center(child: Text('Chat'))),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.line_horizontal_3),
        title: ("Category"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const SizedBox(
          height: 40,
          width: 40,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/logo/300w.png'),
          ),
        ),
        inactiveIcon: const SizedBox(
          height: 40,
          width: 40,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/logo/300w.png'),
          ),
        ),
        title: ('SkyBuy'),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: ("Cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chat_bubble),
        title: ("Chat"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor));
    // Focus nodes are necessary
    final textFieldFocusNode = FocusNode();

    TextEditingController controller = TextEditingController();
    return Scaffold(
      key: _scaffoldKey,
      drawer: const ComplexDrawer1(),
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          EasyLoading.dismiss();
        }
      },
      appBar: CustomAppbar(), //_buildAppBar(textFieldFocusNode, controller),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.grey[300]!,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        navBarStyle: NavBarStyle.style15,
        onItemSelected: (value) {
          if (value == 1) {
            // selectedItem = value + 1;
            _scaffoldKey.currentState?.openDrawer();
          }
        },
      ),
      // bottomNavigationBar: _buildDiamondBottomNavigation(selectedIndex),
    );
  }

  AppBar _buildAppBar(
      FocusNode textFieldFocusNode, TextEditingController controller) {
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
                setState(() {
                  selectedIndex = 3;
                });
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

  BottomNavigationBarItem getHomeItem() {
    return BottomNavigationBarItem(
        icon: Container(
          padding: EdgeInsets.all(4),
          decoration: const BoxDecoration(
              color: AppColors.primaryDark,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 2)
              ],
              gradient: LinearGradient(
                colors: [AppColors.primaryDarkColor, AppColors.primaryColor],
              )),
          height: 56,
          width: 56,
          child: Image.asset('assets/logo/300w.png'),
        ),
        label: '');
  }

  Widget _buildDiamondBottomNavigation(int selectedIndex) {
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
          selectedIndex = 0;
        });
      } else if (index == 1) {
        _scaffoldKey.currentState?.openDrawer();
      } else if (index == 2) {
        //Refresh home page
        setState(() {
          selectedIndex = 2;
        });
      } else if (index == 3) {
        //Cart Page
        setState(() {
          selectedIndex = 3;
        });
      } else if (index == 4) {
        //Chat Page
        setState(() {
          selectedIndex = 4;
        });
      } else {
        setState(() {
          selectedIndexBottom = index;
        });
      }
    });
  }

  Widget _buildBottomNavigationBar(int selectedIndex) {
    return Container(
      color: AppColors.primaryColor,
      child: ClipRRect(
        /*borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),*/
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 5,
          currentIndex: selectedIndex,
          onTap: onTapNav,
          selectedItemColor: AppColors.primaryDark,
          unselectedItemColor: Colors.black.withOpacity(0.8),
          items: [
            const BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(CupertinoIcons.home, size: 24),
            ),
            const BottomNavigationBarItem(
              label: 'Category',
              icon: Icon(CupertinoIcons.line_horizontal_3, size: 24),
            ),
            /*const BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(Icons.person_rounded,size: 24),
            ),*/
            getHomeItem(),
            const BottomNavigationBarItem(
              label: 'Cart',
              icon: Icon(CupertinoIcons.cart, size: 24),
            ),
            const BottomNavigationBarItem(
              label: 'Chat',
              icon: Icon(CupertinoIcons.chat_bubble, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  //Call this method on click of each bottom app bar item to update the screen
  /*void updateTabSelection(int index, String buttonText) {
      setState(() {
        //print('Index :'+index.toString());
        selectedIndex = index;
        text = buttonText;
      });
    }*/
}
