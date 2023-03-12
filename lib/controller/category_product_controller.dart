
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybuybd/models/category/category_product_model.dart';
import 'package:skybuybd/models/product_details/product_details_model.dart';
import '../data/repository/category_product_repo.dart';
import '../data/repository/category_repo.dart';
import '../models/category/category_model.dart';

class CategoryProductController extends GetxController implements GetxService{
  final CategoryProductRepo categoryProductRepo;

  CategoryProductController({
    required this.categoryProductRepo
  });

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isProductDetailsLoaded = false;
  bool get isProductDetailsLoaded => _isProductDetailsLoaded;

  List<CategoryProductModel> _shoesList = [];
  List<CategoryProductModel> get shoesList => _shoesList;

  List<CategoryProductModel> _bagsList = [];
  List<CategoryProductModel> get bagsList => _bagsList;

  List<CategoryProductModel> _jewelryList = [];
  List<CategoryProductModel> get jewelryList => _jewelryList;

  List<CategoryProductModel> _babyList = [];
  List<CategoryProductModel> get babyList => _babyList;

  List<CategoryProductModel> _watchList = [];
  List<CategoryProductModel> get watchList => _watchList;

  List<CategoryProductModel> _categoryProductList = [];
  List<CategoryProductModel> get categoryProductList => _categoryProductList;

  ProductDetailModel _productDetailModel = ProductDetailModel();
  ProductDetailModel get productDetailModel => _productDetailModel;


  Future<void> getShoeList() async{
    Response response = await categoryProductRepo.getCategoryProductList('shoes');

    if(response.statusCode == 200){
      _shoesList = [];
      var result = response.body["products"]["data"];
      List<CategoryProductModel> catty  = (result as List<dynamic>).map((dynamic el) => CategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _shoesList.addAll(catty);
      if (kDebugMode) {
        //print("CP Shoes : $_shoesList");
      }
      _isLoaded = true;
      update();

    }else{
      if (kDebugMode) {
        print('Error on receiving category product list shoes.');
      }
    }
  }

  Future<void> getBagList() async{
    Response response = await categoryProductRepo.getCategoryProductList('bags');

    if(response.statusCode == 200){
      _bagsList = [];
      var result = response.body["products"]["data"];
      List<CategoryProductModel> catty  = (result as List<dynamic>).map((dynamic el) => CategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _bagsList.addAll(catty);
      if (kDebugMode) {
        //print("CP bags : $_bagsList");
      }
      _isLoaded = true;
      update();

    }else{
      if (kDebugMode) {
        print('Error on receiving category product list bag.');
      }
    }
  }

  Future<void> getJewelryList() async{
    Response response = await categoryProductRepo.getCategoryProductList('jewelry');

    if(response.statusCode == 200){
      _jewelryList = [];
      var result = response.body["products"]["data"];
      List<CategoryProductModel> catty  = (result as List<dynamic>).map((dynamic el) => CategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _jewelryList.addAll(catty);
      if (kDebugMode) {
        //print("CP JewelryList : $_jewelryList");
      }
      _isLoaded = true;
      update();

    }else{
      if (kDebugMode) {
        print('Error on receiving category product list jewelry.');
      }
    }
  }

  Future<void> getBabyList() async{
    Response response = await categoryProductRepo.getCategoryProductList('baby-items');

    if(response.statusCode == 200){
      _babyList = [];
      var result = response.body["products"]["data"];
      List<CategoryProductModel> catty  = (result as List<dynamic>).map((dynamic el) => CategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _babyList.addAll(catty);
      if (kDebugMode) {
        //print("CP babyList : $_babyList");
      }
      _isLoaded = true;
      update();

    }else{
      if (kDebugMode) {
        print('Error on receiving category product list baby.');
      }
    }
  }

  Future<void> getWatchList() async{
    Response response = await categoryProductRepo.getCategoryProductList('watch');

    if(response.statusCode == 200){
      _watchList = [];
      var result = response.body["products"]["data"];
      List<CategoryProductModel> catty  = (result as List<dynamic>).map((dynamic el) => CategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _watchList.addAll(catty);
      if (kDebugMode) {
        //print("CP watch : $_watchList");
      }
      _isLoaded = true;
      update();

    }else{
      if (kDebugMode) {
        print('Error on receiving category product list watch.');
      }
    }
  }

  Future<void> getCategoryProductList(String slug) async{

    Response response = await categoryProductRepo.getCategoryProductList(slug);
    print("CP : "+response.statusCode.toString());

    if(response.statusCode == 200){
      _categoryProductList = [];
      var result = response.body["products"]["data"];
      List<CategoryProductModel> catty  = (result as List<dynamic>).map((dynamic el) => CategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _categoryProductList.addAll(catty);
      _isLoaded = true;
      update();

    }else{
      if (kDebugMode) {
        print('Error on receiving category product list by category slug.');
      }
    }
  }

  void deleteCategoryProductList(){
    _categoryProductList = [];
    update();
  }

}