import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybuybd/controller/cart_controller.dart';
import 'package:skybuybd/controller/category_controller.dart';
import 'package:skybuybd/controller/order_controller.dart';
import 'package:skybuybd/data/repository/cart_repo.dart';
import 'package:skybuybd/data/repository/category_repo.dart';
import 'package:skybuybd/data/repository/home_repo.dart';

import '../controller/auth_controller.dart';
import '../controller/category_product_controller.dart';
import '../controller/home_controller.dart';
import '../controller/product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/category_product_repo.dart';
import '../data/repository/order_repo.dart';
import '../data/repository/product_repo.dart';
import '../utils/constants.dart';

Future<void> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences,fenix: true);

  //Api Client
  Get.lazyPut(() => ApiClient(preferences: Get.find(),appBaseUrl: Constants.BASE_URL),fenix: true);

  //Repo
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), preferences: Get.find()),fenix: true);
  Get.lazyPut(() => HomeRepo(apiClient: Get.find(), preferences: Get.find()),fenix: true);
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find(), preferences: Get.find()),fenix: true);
  Get.lazyPut(() => CategoryProductRepo(apiClient: Get.find(), preferences: Get.find()),fenix: true);
  Get.lazyPut(() => ProductRepo(apiClient: Get.find(), preferences: Get.find()),fenix: true);
  Get.lazyPut(() => OrderRepo(apiClient: Get.find(), preferences: Get.find()),fenix: true);
  Get.lazyPut(() => CartRepo(apiClient: Get.find(), preferences: Get.find()),fenix: true);

  //Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()),fenix: true);
  Get.lazyPut(() => HomeController(homeRepo: Get.find()),fenix: true);
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()),fenix: true);
  Get.lazyPut(() => CategoryProductController(categoryProductRepo: Get.find()),fenix: true);
  Get.lazyPut(() => ProductController(productRepo: Get.find()),fenix: true);
  Get.lazyPut(() => OrderController(orderRepo: Get.find()),fenix: true);
  Get.lazyPut(() => CartController(cartRepo: Get.find()),fenix: true);
}