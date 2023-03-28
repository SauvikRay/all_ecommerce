
import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybuybd/data/repository/home_repo.dart';
import 'package:skybuybd/models/conversion_rate.dart';
import 'package:skybuybd/models/home/banner_model.dart';
import 'package:skybuybd/models/home/home_model.dart';
import 'package:skybuybd/models/home/top_cat_product_model.dart';
import 'package:skybuybd/models/home/top_cats_model.dart';
import 'package:skybuybd/models/shipping_text.dart';
import '../models/category/category_model.dart';
import '../models/home/announcement_model.dart';
import '../models/home/recent_product_model.dart';

class HomeController extends GetxController implements GetxService{
  final HomeRepo homeRepo;

  HomeController({
    required this.homeRepo
  });

  //Loading state
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //Conversion price status
  bool _isConversionPriceLoaded = false;
  bool get isConversionPriceLoaded => _isConversionPriceLoaded;

  ConversionRate _conversionRateServer = ConversionRate();
  ConversionRate get conversionRateServer => _conversionRateServer;
  double _conversionPrice = 0.0;
  double get conversionPrice => _conversionPrice;

  //Shipping Text
  bool _isShippingTextLoaded = false;
  bool get isShippingTextLoaded => _isShippingTextLoaded;

  //Shipping text model
  ShippingText _shippingText = ShippingText();
  ShippingText get shippingText => _shippingText;

  //Announcement State
  AnnouncementModel _announcement = AnnouncementModel();
  AnnouncementModel get announcement{
    return _announcement;
  }

  //Top Category State
  List<TopCatModel> _topCatModel = [];
  List<TopCatModel> get topCatModel{
    return _topCatModel;
  }

  //Home State
  HomeModel _homeModel = HomeModel();
  HomeModel get homeModel{
    return _homeModel;
  }

  List<BannerModel> _bannerList = [];
  List<BannerModel> get bannerList{
    return _bannerList;
  }

  RecentProductModel _recentProductModel = RecentProductModel();
  RecentProductModel get recentProductModel{
    return _recentProductModel;
  }

  List<TopCategoryProductModel> _shoes = [];
  List<TopCategoryProductModel> get shoes{
    return _shoes;
  }

  List<TopCategoryProductModel> _bag = [];
  List<TopCategoryProductModel> get bag{
    return _bag;
  }

  List<TopCategoryProductModel> _jewelry = [];
  List<TopCategoryProductModel> get jewelry{
    return _jewelry;
  }

  List<TopCategoryProductModel> _baby = [];
  List<TopCategoryProductModel> get baby{
    return _baby;
  }

  List<TopCategoryProductModel> _watch = [];
  List<TopCategoryProductModel> get watch{
    return _watch;
  }

  Future<void> getHomePageItem() async{
    Response response = await homeRepo.getHomePageItems();
    if (kDebugMode) {
      print("Home API Status Code : ${response.statusCode.toString()}");
    }
    if(response.statusCode == 200){

      //All
      //_homeModel = HomeModel.fromJson(response.body);

      //Announcement
      _announcement = AnnouncementModel.fromJson(response.body["announcement"]);
      if (kDebugMode) {
        //print("Announcement Data : ${response.body.toString()}");
      }

      //Top Category
      _topCatModel = [];
      var result = response.body["top_cats"];
      List<TopCatModel> tcm  = (result as List<dynamic>).map((dynamic el) => TopCatModel.fromJson(el as Map<String, dynamic>)).toList();
      _topCatModel.addAll(tcm);
      if (kDebugMode) {
        //print("Top Category Data : ${_topCatModel.toString()}");
      }

      //Banner
      _bannerList = [];
      var resultBanner = response.body["banners"];
      List<BannerModel> bm  = (resultBanner as List<dynamic>).map((dynamic el) => BannerModel.fromJson(el as Map<String, dynamic>)).toList();
      _bannerList.addAll(bm);
      if (kDebugMode) {
        //print("Banner Data : ${_bannerList.toString()}");
      }

      //Recent Product
      //_recentProductModel = RecentProductModel.fromJson(response.body["recentProducts"]);
      if (kDebugMode) {
        //print("RecentProduct : ${_recentProductModel.toJson().toString()}");
      }
  
      //Shoes
      _shoes = [];
      var resultShoe = response.body["shoes"];
      List<TopCategoryProductModel> shoes  = (resultShoe as List<dynamic>).map((dynamic el) => TopCategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _shoes.addAll(shoes);
      if (kDebugMode) {
        //print("Shoes : ${_shoes.toString()}");
      }

      //Bag
     _bag = [];
      var resultBag = response.body["bag"];
      List<TopCategoryProductModel> bag  = (resultBag as List<dynamic>).map((dynamic el) => TopCategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _bag.addAll(bag);
      if (kDebugMode) {
        //print("Bags : ${_bag.toString()}");
      }

      //Jewelry
      _jewelry = [];
      var resultJewelry = response.body["jewelry"];
      List<TopCategoryProductModel> jewelry  = (resultJewelry as List<dynamic>).map((dynamic el) => TopCategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _jewelry.addAll(jewelry);
      if (kDebugMode) {
       print("Jewelry : ${_jewelry.toString()}");
      }

      //Baby
      _baby = [];
      var resultBaby= response.body["baby"];
      List<TopCategoryProductModel> baby  = (resultBaby as List<dynamic>).map((dynamic el) => TopCategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _baby.addAll(baby);
      if (kDebugMode) {
        print("Baby : ${_baby.toString()}");
      }

      //Watch
      _watch = [];
      var resultWatch= response.body["watch"];
      List<TopCategoryProductModel> watch  = (resultWatch as List<dynamic>).map((dynamic el) => TopCategoryProductModel.fromJson(el as Map<String, dynamic>)).toList();
      _watch.addAll(watch);
      if (kDebugMode) {
        print("Watch : ${_watch.toString()}");
      }

      _isLoaded = true;
      update();
    }else{
      if (kDebugMode) {
        print('Error on Homepage API');
      }
    }
  }

  Future<void> getConversionRate() async{
    _isConversionPriceLoaded = false;
    update();
    Response response = await homeRepo.getConversionRate();

    if(response.statusCode == 200){

      _conversionRateServer = ConversionRate.fromJson(response.body);
      _conversionPrice = _conversionRateServer.rate ?? 20.0;
      print("Conversion Price : ${_conversionPrice}");
      homeRepo.setConversionRate(_conversionPrice);
    }

    _isConversionPriceLoaded = true;
    update();
  }

  SharedPreferences getSharedPref(){
    return homeRepo.preferences;
  }

  Future<void> getShippingText() async{
    _isShippingTextLoaded = false;
    update();
    Response response = await homeRepo.getShippingText();

    if(response.statusCode == 200){
      _shippingText = ShippingText.fromJson(response.body);
      _isShippingTextLoaded = true;
    }


    update();
  }


}