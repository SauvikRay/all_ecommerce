
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skybuybd/data/repository/cart_repo.dart';
import 'package:skybuybd/data/repository/order_repo.dart';
import 'package:skybuybd/data/repository/product_repo.dart';
import 'package:skybuybd/models/category/category_product_model.dart';
import 'package:skybuybd/models/invoice_model.dart';
import 'package:skybuybd/models/order_model.dart';
import 'package:skybuybd/models/product_details/product_details.dart';
import 'package:skybuybd/models/product_details/product_details_model.dart';
import 'package:skybuybd/models/user_address_model.dart';
import 'package:skybuybd/pages/product/single_product_page.dart';
import 'package:skybuybd/pages/wishlist/wishlist_page.dart';
import '../data/repository/category_product_repo.dart';
import '../data/repository/category_repo.dart';
import '../data/service/ImageService.dart';
import '../models/cart_model.dart';
import '../models/category/category_model.dart';
import 'package:http/http.dart' as http;
import '../models/home/picture_model.dart';
import '../models/product/color_image.dart';
import '../models/product/product_size.dart';
import '../models/product/small_image.dart';
import '../models/response_model.dart';
import '../models/wishlist_model.dart';

class CartController extends GetxController implements GetxService{
  final CartRepo cartRepo;

  CartController({
    required this.cartRepo
  });

  ///For Cart
  bool _isCartListLoaded = false;
  bool get isCartListLoaded => _isCartListLoaded;

  CartModel _cartModel = CartModel();
  CartModel get cartModel => _cartModel;

  List<Cart> _cartList = [];
  List<Cart> get cartList => _cartList;

  bool _isCartSend = false;
  bool get isCartSend => _isCartSend;

  bool _isCartDeleted = false;
  bool get isCartDeleted => _isCartDeleted;

  ///For Wishlist
  bool _isWishListLoaded = false;
  bool get isWishListLoaded => _isWishListLoaded;

  WishListModel _wishlistModel = WishListModel();
  WishListModel get wishlistModel => _wishlistModel;

  List<Wishlist> _wishlist = [];
  List<Wishlist> get wishlist => _wishlist;

  bool _isWishlistPost = false;
  bool get isWishlistPost => _isWishlistPost;


  Future<ResponseModel> cartDelete(String ids) async {

    _isCartDeleted = false;
    update();

    Response response = await cartRepo.cartDelete(ids);

    late ResponseModel responseModel;
    if(response.statusCode == 200){
      print("Cart delete : ${response.body}");
      responseModel = ResponseModel(true, response.body["message"],'deleted');
      _isCartSend = true;
      update();
    }else{
      responseModel = ResponseModel(false, 'error','not deleted');
      update();
    }

    return responseModel;

  }

  Future<ResponseModel> cartPost(
      String id,
      int checked,
      int QuantityRanges,
      String Title,
      String ItemData,
      int minQuantity,
      int localDelivery,
      int shippingRate,
      int BatchLotQuantity,
      int NextLotQuantity,
      dynamic ActualWeight,
      int FirstLotQuantity
      ) async{

    _isCartSend = false;
    update();

    Response response = await cartRepo.cartPost(
        id, 
        checked, 
        QuantityRanges, 
        Title, 
        ItemData, 
        minQuantity, 
        localDelivery, 
        shippingRate, 
        BatchLotQuantity, 
        NextLotQuantity, 
        ActualWeight, 
        FirstLotQuantity
    );

    late ResponseModel responseModel;
    if(response.statusCode == 200){
      print("Cart post : ${response.body}");
      responseModel = ResponseModel(true, response.body["message"],response.body["status"]);
      _isCartSend = true;
      update();
    }else{
      responseModel = ResponseModel(false, response.body["message"],response.body["status"]);
      print("Error cart post status code : ${response.statusCode}");
    }
    return responseModel;
  }

  Future<ResponseModel> getCartList() async{

    _cartModel = CartModel();
    _cartList = [];
    _isCartListLoaded = false;
    update();

    Response response = await cartRepo.getCartList();
    late ResponseModel responseModel;
    if(response.statusCode == 200){

      _cartModel = CartModel.fromJson(response.body);
      _cartList = _cartModel.cart!;
      _isCartListLoaded = true;
      responseModel = ResponseModel(true, 'ok','success');
      update();

    }else{
      responseModel = ResponseModel(false, 'not ok','failed');
      if (kDebugMode) {
        print('Error on getting customer cart');
      }

    }
    return responseModel;
  }

  ///Wishlist
  Future<ResponseModel> getWishList() async{

    _wishlistModel = WishListModel();
    _wishlist = [];
    _isWishListLoaded = false;
    update();

    Response response = await cartRepo.getWishlist();
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      print('W : ${response.body}');
      _wishlistModel = WishListModel.fromJson(response.body);
      var result = response.body["data"];
      _wishlist = (result as List<dynamic>).map((dynamic el) => Wishlist.fromJson(el as Map<String, dynamic>)).toList();
      print('W1 : ${_wishlist.length}');
      _isWishListLoaded = true;
      responseModel = ResponseModel(true, 'ok','success');
      update();

    }else{
      responseModel = ResponseModel(false, 'not ok','failed');
      if (kDebugMode) {
        print('Error on getting customer wishlist');
      }

    }
    return responseModel;
  }

  Future<ResponseModel> postWishList(String itemId,String title,String image,int price) async{

    _isWishlistPost = false;
    update();

    Response response = await cartRepo.postWishlist(
        itemId,
        title,
        image,
        price
    );

    late ResponseModel responseModel;
    if(response.statusCode == 200){
      print("Wishlist post : ${response.body}");
      responseModel = ResponseModel(true, 'posted','ok');
      _isWishlistPost = true;
      update();
    }else{
      responseModel = ResponseModel(false, 'not posted','not ok');
      print("Error wishlist post status code : ${response.statusCode}");
    }
    return responseModel;
  }

}