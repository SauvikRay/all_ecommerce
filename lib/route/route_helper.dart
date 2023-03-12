import 'package:get/get.dart';
import 'package:skybuybd/pages/auth/forgot_password.dart';
import 'package:skybuybd/pages/auth/login.dart';
import 'package:skybuybd/pages/auth/register_page.dart';
import 'package:skybuybd/pages/auth/verify_otp.dart';
import 'package:skybuybd/pages/account/account_page.dart';
import 'package:skybuybd/pages/category/category_page.dart';
import 'package:skybuybd/pages/auth/login/login_page.dart';
import 'package:skybuybd/pages/home/landing_page.dart';
import 'package:skybuybd/pages/product/category_product.dart';
import 'package:skybuybd/pages/product/single_product_page.dart';
import 'package:skybuybd/pages/splash/splash_page.dart';
import 'package:skybuybd/pages/wishlist/wishlist_page.dart';

import '../pages/auth/login/otp_page.dart';
import '../pages/category/subcategory_page.dart';
import '../pages/home/home_page.dart';
import '../pages/payment/payment_page.dart';
import '../pages/product/search_product.dart';
import '../pages/seller/seller_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String signInPage = "/sign-in";
  static const String otpPage = "/otp";
  static const String loginPage = "/login";
  static const String registerPage = "/register";
  static const String verifyOtpPage = "/verify-otp";
  static const String forgotPasswordPage = "/forgot-password";
  static const String initial = "/";
  static const String singleProductView = "/product-single";
  static const String paymentPage = "/payment";
  static const String wishListPage = "/wishlist";
  static const String accountPage = "/account";
  static const String subCategoryPage = "/sub-category";
  static const String childCategoryPage = "/child-category";
  static const String categoryProductPage = "/category-product";
  static const String searchPage = "/search-product";
  static const String sellerStorePage = "/seller-store";
  //static const String cartPage = "/cart";

  static String getSplashPage() => splashPage;
  static String getSignInPage() => signInPage;
  static String getOtp(String phone) => '$otpPage?phone=$phone';
  static String getLoginPage() => '$loginPage';
  static String getRegisterPage() => '$registerPage';
  static String getVerifyOtpPage(String phone) => '$verifyOtpPage?phone=$phone';
  static String getForgotPasswordPage() => '$forgotPasswordPage';
  static String getInitial() => initial;
  static String getSingleProductPage(String slug) =>
      '$singleProductView?slug=$slug';
  static String getPaymentPage(String cartListJson) =>
      '$paymentPage?cartListJson=$cartListJson';
  static String getWishListPage() => '$wishListPage';
  static String getAccountPage() => '$accountPage';

  ///Sub-category page
  static String getSubCategoryPage(
          String parentCatName, String parentCatSlug) =>
      '$subCategoryPage?parentCatName=$parentCatName&parentCatSlug=$parentCatSlug';

  ///Child-category page
  static String getChildCategoryPage(
          String parentCatName, String subCatName, String subCatSlug) =>
      '$childCategoryPage?parentCatName=$parentCatName&subCatName=$subCatName&subCatSlug=$subCatSlug';

  ///Category product page
  static String getCategoryProductPage(String parentCatName, String subCatName,
          String childCatName, String childCatSlug) =>
      '$categoryProductPage?parentCatName=$parentCatName&subCatName=$subCatName&childCatName=$childCatName&childCatSlug=$childCatSlug';

  ///Search page
  static String getSearchPage(String searchKey, String type, String filePath) =>
      '$searchPage?searchKey=$searchKey&type=$type&filePath=$filePath';

  ///Seller store
  static String getSellerStorePage(String sellerName) =>
      '$sellerStorePage?sellerName=$sellerName';

  ///Cart
  //static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () => const SplashPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: signInPage,
        page: () => const LoginPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: otpPage,
        page: () {
          var phone = Get.parameters['phone'];
          return OtpPage(phone: phone!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: loginPage,
        page: () => const Login(),
        transition: Transition.fadeIn),
    GetPage(
        name: registerPage,
        page: () => const Registration(),
        transition: Transition.fadeIn),
    GetPage(
        name: verifyOtpPage,
        page: () {
          var phone = Get.parameters['phone'];
          return VerifyOtp(phone: phone!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: forgotPasswordPage,
        page: () => const ForgotPassword(),
        transition: Transition.fadeIn),
    GetPage(
        name: initial,
        page: () => const LandingPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: singleProductView,
        page: () {
          var slug = Get.parameters['slug'];
          return SingleProductPage(slug: slug!);
        },
        transition: Transition.fade),
    GetPage(
        name: paymentPage,
        page: () {
          var cartListJson = Get.parameters['cartListJson'];
          return PaymentPage(cartListJson: cartListJson!);
        },
        transition: Transition.fade),
    GetPage(
        name: wishListPage,
        page: () => WishlistPage(),
        transition: Transition.fade),
    GetPage(
        name: accountPage,
        page: () => AccountPage(),
        transition: Transition.fade),

    ///Sub-category
    GetPage(
      name: subCategoryPage,
      page: () {
        var parentCatName = Get.parameters['parentCatName'];
        var parentCatSlug = Get.parameters['parentCatSlug'];
        return CategoryPage(
            parentCatName: parentCatName!, parentCatSlug: parentCatSlug!);
      },
      transition: Transition.fadeIn,
    ),

    ///Child Category
    GetPage(
      name: childCategoryPage,
      page: () {
        var parentCatName = Get.parameters['parentCatName'];
        var subCatName = Get.parameters['subCatName'];
        var subCatSlug = Get.parameters['subCatSlug'];
        return SubCategoryPage(
            parentCatName: parentCatName!,
            subCatName: subCatName!,
            subCatSlug: subCatSlug!);
      },
      transition: Transition.fadeIn,
    ),

    /// Category Product
    GetPage(
      name: categoryProductPage,
      page: () {
        var parentCatName = Get.parameters['parentCatName'];
        var subCatName = Get.parameters['subCatName'];
        var childCatName = Get.parameters['childCatName'];
        var childCatSlug = Get.parameters['childCatSlug'];
        return CategoryProduct(
            parentCatName: parentCatName!,
            subCatName: subCatName!,
            childCatName: childCatName!,
            childCatSlug: childCatSlug!);
      },
      transition: Transition.fadeIn,
    ),

    /// Search Product
    GetPage(
      name: searchPage,
      page: () {
        var searchKey = Get.parameters['searchKey'];
        var type = Get.parameters['type'];
        var filePath = Get.parameters['filePath'];
        return SearchPage(
            searchKey: searchKey!, type: type!, filePath: filePath!);
      },
      transition: Transition.fadeIn,
    ),

    ///Cart Page
    //GetPage(name: cartPage, page: () => CartPage(),transition: Transition.fade),

    /// Seller Store
    GetPage(
      name: sellerStorePage,
      page: () {
        var sellerName = Get.parameters['sellerName'];
        return SellerPage(sellerName: sellerName!);
      },
      transition: Transition.fadeIn,
    ),
  ];
}
