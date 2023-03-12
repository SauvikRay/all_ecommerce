import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:skybuybd/apps/categories/presentation/blocs/category/category_bloc.dart';
import 'package:skybuybd/apps/categories/presentation/providers/category_provider.dart';
import 'package:skybuybd/apps/core/di.dart';
import 'package:skybuybd/apps/core/presentation/widgets/app_drawer.dart';
import 'package:skybuybd/controller/auth_controller.dart';
import 'package:skybuybd/pages/account/account_page.dart';
import 'package:skybuybd/pages/auth/login.dart';
import 'package:skybuybd/pages/cart/cart_page.dart';
import 'package:skybuybd/pages/home/home_page_body.dart';
import 'package:skybuybd/pages/home/widgets/complex_drawer1.dart';
import 'package:skybuybd/pages/home/widgets/dimond_bottom_bar.dart';
import 'package:skybuybd/pages/home/widgets/main_app_bar.dart';
import 'package:skybuybd/utils/app_colors.dart';
import 'package:skybuybd/utils/value_utility.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool isUserLoggedIn;

  @override
  void initState() {
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screens = [
      HomePageBody(),
      const AccountPage(),
      HomePageBody(),
      isUserLoggedIn
          ? const CartPage(
              cartlist: [],
            )
          : const Login(),
      const Center(child: Text('Chat')),
    ];
    return ValueListenableBuilder(
      valueListenable: BottomNavUtility.index,
      builder: (context, value, child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: MainAppBar(),
          ),
          drawer: const AppDrawer(),
          body: IndexedStack(
            index: BottomNavUtility.index.value,
            children: screens,
          ),
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
                _scaffoldKey.currentState?.openDrawer();
                //  ref.read(categoryProvider.notifier).getCategories();
              } else {
                BottomNavUtility.index.value = value;
              }
            },
            selectedColor: AppColors.btnColorBlueDark,
            unselectedColor: Colors.black,
          ),
        );
      },
    );
  }
}
