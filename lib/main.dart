import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skybuybd/all_model_and_repository/product/product_provider.dart';
import 'package:skybuybd/helper/dependencies.dart' as dep;
import 'package:skybuybd/route/route_helper.dart';
import 'package:skybuybd/utils/constants.dart';

import 'provider/cart_provider.dart';
import 'provider/category_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.APP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: Footer(),
        initialRoute: RouteHelper.getSplashPage(),
        getPages: RouteHelper.routes,
        //home: AccountPage(),
        //home: HomePage(),
        //home: CategoryPage(parentCatId: 1,catName: 'Baby Items'),
        //home: SingleProductPage(),
        builder: EasyLoading.init(),
      ),
    );

    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: Constants.APP_NAME,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   //home: Footer(),
    //   initialRoute: RouteHelper.getSplashPage(),
    //   getPages: RouteHelper.routes,
    //   //home: AccountPage(),
    //   //home: HomePage(),
    //   //home: CategoryPage(parentCatId: 1,catName: 'Baby Items'),
    //   //home: SingleProductPage(),
    // );
  }
}
