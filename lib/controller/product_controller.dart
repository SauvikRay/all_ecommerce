import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skybuybd/base/show_custom_snakebar.dart';
import 'package:skybuybd/data/repository/product_repo.dart';
import 'package:skybuybd/models/category/category_product_model.dart';
import 'package:skybuybd/models/product_details/product_details.dart';
import 'package:skybuybd/models/product_details/product_details_model.dart';
import 'package:skybuybd/pages/product/single_product_page.dart';
import '../all_model_and_repository/product_details/model_product_varient_size.dart';
import '../data/repository/category_product_repo.dart';
import '../data/repository/category_repo.dart';
import '../data/service/ImageService.dart';
import '../models/category/category_model.dart';
import 'package:http/http.dart' as http;
import '../models/home/picture_model.dart';
import '../models/product/color_image.dart';
import '../models/product/product_size.dart';
import '../models/product/small_image.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  bool _isProductDetailsLoaded = false;
  bool get isProductDetailsLoaded => _isProductDetailsLoaded;

  bool _isSizeQueryFinished = false;
  bool get isSizeQueryFinished => _isSizeQueryFinished;

  bool _isSizeExist = false;
  bool get isSizeExist => _isSizeExist;

  bool _isSearchComplete = false;
  bool get isSearchComplete => _isSearchComplete;

  bool _isQuantityRangeExist = false;
  bool get isQuantityRangeExist => _isQuantityRangeExist;

  ProductDetailModel _productDetailModel = ProductDetailModel();
  ProductDetailModel get productDetailModel => _productDetailModel;

  String _largeImage = "";
  String get largeImage => _largeImage;

  List<PictureModel> _images = [];
  List<PictureModel> get images => _images;

  List<SmallImage> _smallImageList = [];
  List<SmallImage> get smallImageList => _smallImageList;

  List<QuantityRange> _quantityRangeList = [];
  List<QuantityRange> get quantityRangeList => _quantityRangeList;

  List<Attribute> _attributeList = [];
  List<Attribute> get attributeList => _attributeList;

  List<ConfiguredItems> _configuredItems = [];
  List<ConfiguredItems> get configuredItems => _configuredItems;

  List<ColorImage> _colorImageList = [];
  List<ColorImage> get colorImageList => _colorImageList;

  List<ProductSize> _initialProductSizeList = [];
  List<ProductSize> get initialProductSizeList => _initialProductSizeList;
  List<ProductSize> _productSizeList = [];
  List<ProductSize> get productSizeList => _productSizeList;

  List<CategoryProductModel> _searchedProdList = [];
  List<CategoryProductModel> get searchedProdList => _searchedProdList;
  List<CategoryProductModel> _sellerProductList = [];
  List<CategoryProductModel> get sellerProductList => _sellerProductList;

  Future<void> getProductDetails(String slug) async {
    _isProductDetailsLoaded = false;

    Response response = await productRepo.getProductDetails(slug);

    if (kDebugMode) {
      print("Product Details :${response.statusCode.toString()}");
    }
    _largeImage = '';
    _smallImageList = [];

    if (response.statusCode == 200) {
      _productDetailModel = ProductDetailModel();
      var result = response.body;
      _productDetailModel = ProductDetailModel.fromJson(result);

      _largeImage = _productDetailModel.productDetails!.mainPictureUrl!;
      List<PictureModel>? images =
          _productDetailModel.productDetails?.pictures!;
      _images = [];
      _images.addAll(images!);
      for (int i = 0; i < _images.length; i++) {
        _smallImageList
            .add(SmallImage(i + 1, _images[i].url, i + 1 == 1 ? true : false));
      }

      var qtyRangeList = _productDetailModel.productDetails!.quantityRanges;
      if (qtyRangeList != null && qtyRangeList.isNotEmpty) {
        _isQuantityRangeExist = true;
        List<QuantityRange>? qtyRanges =
            _productDetailModel.productDetails!.quantityRanges!;
        _quantityRangeList = [];
        _quantityRangeList = qtyRanges;
      } else {
        _isQuantityRangeExist = false;
      }

      _sellerProductList = [];
      _attributeList = [];
      _configuredItems = [];
      _colorImageList = [];
      _productSizeList = [];
      _attributeList = _productDetailModel.productDetails!.attributes!;
      _configuredItems = _productDetailModel.productDetails!.configuredItems!;

      for (int i = 0; i < _attributeList.length; i++) {
        if (_attributeList[i].propertyName! == "Color" ||
            _attributeList[i].propertyName! == "Machining type") {
          _colorImageList.add(ColorImage(
              i + 1,
              0,
              _attributeList[i].value!,
              _attributeList[i].imageUrl ?? "",
              _attributeList[i].vid!,
              i + 1 == 1 ? true : false));
        } /*else if(_attributeList[i].propertyName! == "Size"){
          _initialProductSizeList.add(ProductSize(i+1, _attributeList[i].value!, i+1==1 ? true : false));
        }*/
      }

      if (_colorImageList != null && _colorImageList.length > 0) {
        getSizeListForSpecificColor(
            _colorImageList != null ? _colorImageList[0].vid : "");
      }

      _sellerProductList = productDetailModel.SellerProductLists!;

      _isProductDetailsLoaded = true;
      update();
    } else {
      showCustomSnakebar("Product Loading Failed");
      if (kDebugMode) {
        print('Error on getting product details');
      }
    }
  }

  Future<void> productSearchByKeyword(String keyword) async {
    _isSearchComplete = false;
    update();

    Response response = await productRepo.searchProductByKeyword(keyword);

    if (response.statusCode == 200) {
      var result = response.body["items"]["data"];
      List<CategoryProductModel> catty = (result as List<dynamic>)
          .map((dynamic el) =>
              CategoryProductModel.fromJson(el as Map<String, dynamic>))
          .toList();
      _searchedProdList.addAll(catty);

      _isSearchComplete = true;
      update();
    } else {
      if (kDebugMode) {
        print('Error on search product');
      }
    }
  }

  Future<void> productSearchByImage(String filePath) async {
    clearSearchData();
    _isSearchComplete = false;
    update();

    Response response = await productRepo.searchProductByImage(filePath);

    if (response.statusCode == 200) {
      print("response.body : ${response}");

      var result = response.body["items"]["data"];
      List<CategoryProductModel> catty = (result as List<dynamic>)
          .map((dynamic el) =>
              CategoryProductModel.fromJson(el as Map<String, dynamic>))
          .toList();
      _searchedProdList.addAll(catty);

      _isSearchComplete = true;
      update();
    } else {
      if (kDebugMode) {
        print('Error on image search product');
      }
    }
  }

  //Working for image search
  void uploadImage(File file) async {
    _searchedProdList = [];
    try {
      _isSearchComplete = false;
      _searchedProdList = [];
      update();
      if (file != null) {
        var response = await ImageService.uploadFile(file.path);
        if (response.statusCode == 200) {
          var result = response.data["items"]["data"];
          print("Data : ${response.data}");
          /*for(dynamic item in result){
            _searchedProdList.add(CategoryProductModel.fromJson(item["items"]["data"]));
          }*/
          List<CategoryProductModel> catty = (result as List<dynamic>)
              .map((dynamic el) =>
                  CategoryProductModel.fromJson(el as Map<String, dynamic>))
              .toList();
          _searchedProdList.addAll(catty);

          _isSearchComplete = true;
          update();

          //get image url from api response
          //imageURL = response.data['user']['image'];

          //Get.snackbar('Success', 'Image uploaded successfully', margin: EdgeInsets.only(top: 5,left: 10,right: 10));
        } else if (response.statusCode == 401) {
          //Get.offAllNamed('/sign_up');
        } else {
          //Get.snackbar('Failed', 'Error Code: ${response.statusCode}', margin: EdgeInsets.only(top: 5,left: 10,right: 10));
        }
      } else {
        //Get.snackbar('Failed', 'Image not selected', margin: EdgeInsets.only(top: 5,left: 10,right: 10));
      }
    } finally {
      _isSearchComplete = true;
      update();
    }
  }

List <ColorImageNew> newColorImages=[];
List <ProductSizedVarient> newSizedVarient=[];
  void getSizeListForSpecificColor(String vid) {
    _isSizeQueryFinished = false;
    _isSizeExist = false;
    update();

    _productSizeList = [];

    if (_configuredItems.isNotEmpty) {
      log("Configure Items${_configuredItems.length}");
      for (int i = 0; i < _configuredItems.length; i++) {
        if (_configuredItems[i].configurators!.length >= 2) {
          _isSizeExist = true;
          update();
          for (int j = 0; j < _configuredItems[i].configurators!.length; j++) {
            log("Configured ITems configurations:${_configuredItems[i].id}");
            if (_configuredItems[i].configurators![j].vid! == vid) {
              _productSizeList.add(ProductSize(i,_configuredItems[i].id!, _configuredItems[i].configurators![1].vid!,"",_configuredItems[i].quantity!,0,vid,false,));
            }
            log("Last List ${_productSizeList.length}");
          }
        } else {
          _isSizeExist = false;
          update();
        }
      }
    } else {
      print("no configured item");
    }
    _isSizeQueryFinished = true;
    update();
               
  }

  void clearSearchData() {
    _searchedProdList = [];
    update();
  }


//   getNewProductSizedListByColor(){
//     newSizedVarient=[];
   


//       for(var colorImage in colorImageList){
              
//           _isSizeQueryFinished = false;
//     _isSizeExist = false;
//     update();

//     _productSizeList = [];

//     if (_configuredItems.isNotEmpty) {

//       for (int i = 0; i < _configuredItems.length; i++) {
//         if (_configuredItems[i].configurators!.length >= 2) {
//           _isSizeExist = true;
//           update();
//           for (int j = 0; j < _configuredItems[i].configurators!.length; j++) {
           
//             if (_configuredItems[i].configurators![j].vid! == colorImage.vid) {
    

//                 newSizedVarient.add(
//                 ProductSizedVarient(i,_configuredItems[i].id!,_configuredItems[i].configurators![1].vid!,"",_configuredItems[i].quantity!,0,colorImage.vid,false));
         

            
//             }

//           }
//         } else {
//           _isSizeExist = false;
//           update();
//         }
//       }
//     } else {
//       print("no configured item");
//     }
//     _isSizeQueryFinished = true;
//     update();

//       }
// // log("New Color IMage Lis ${newSizedVarient.length}");

//   }

}

