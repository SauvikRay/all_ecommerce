
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybuybd/models/response_model.dart';
import '../data/repository/category_repo.dart';
import '../models/category/category_model.dart';
import '../models/category/sub_category_model.dart';
import '../models/drawer/cdm.dart';
import '../models/drawer/cdms.dart';

class CategoryController extends GetxController implements GetxService{
  final CategoryRepo categoryRepo;

  CategoryController({
    required this.categoryRepo
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isChildCategoryExist = false;
  bool get isChildCategoryExist => _isChildCategoryExist;

  List<CategoryModel> _parentCategoryList = [];
  List<CategoryModel> get parentCategoryList => _parentCategoryList;

  List<SubCategoryModel> _subCategoryList = [];
  List<SubCategoryModel> get subCategoryList => _subCategoryList;

  //CDM Menus
  List<CDM> _menuList = [];
  List<CDM> get menuList => _menuList;

  List<CDMS> _subMenuList = [];
  List<CDMS> get subMenuList => _subMenuList;


  Future<void> getParentCategoryList() async{
    Response response = await categoryRepo.getParentCategoryList();
    if(response.statusCode == 200){

      _parentCategoryList = [];
      var result = response.body["categoryList"];

      List<CategoryModel> catty  = (result as List<dynamic>).map((dynamic el) => CategoryModel.fromJson(el as Map<String, dynamic>)).toList();
      _parentCategoryList.addAll(catty);
      
      for(final item in _parentCategoryList){
        menuList.add(CDM(item.icon ?? '', item.name ?? '', item.otcId ?? '', []));
      }
      
      _isLoaded = true;
      update();
    }else{
      print('Error parent category');
    }
  }

  Future<ResponseModel> getSubCategoryList(String catSlug) async{

    _isLoading = true;
    //update();

    Response response = await categoryRepo.getSubcategoryList(catSlug);

    if (kDebugMode) {
      print("SB status code : ${response.statusCode}");
    }

    late ResponseModel responseModel;
    if(response.statusCode == 200){

      _subCategoryList = [];
      var result = response.body["categoryList"]["children"];
      var childs = response.body["child"];
      if(childs != null && childs > 0 ){
        print("Child found");
        _isChildCategoryExist = true;
        responseModel = ResponseModel(true, "child","child");
      }else{
        print("Product found");
        _isChildCategoryExist = false;
        responseModel = ResponseModel(true, "product","product");
      }
      List<SubCategoryModel> catty  = (result as List<dynamic>).map((dynamic el) => SubCategoryModel.fromJson(el as Map<String, dynamic>)).toList();
      _subCategoryList.addAll(catty);
      _isLoaded = true;
      _isLoading = false;
      update();
    }else{
      responseModel = ResponseModel(true, response.statusCode.toString(),"failed");
      if (kDebugMode) {
        print('Error sub-category');
      }
    }

    return responseModel;
  }

  Future<ResponseModel> getSubcategoryByOtc(String otcId) async{

    _isLoading = true;
    update();

    Response response = await categoryRepo.getSubcategoryByOtc(otcId);

    late ResponseModel responseModel;
    if(response.statusCode == 200){

      _subCategoryList = [];
      var result = response.body["categoryList"]["children"];
      var childs = response.body["child"];
      if(childs != null && childs > 0 ){
        _isChildCategoryExist = true;

        //Sub categories
        List<SubCategoryModel> catty  = (result as List<dynamic>).map((dynamic el) => SubCategoryModel.fromJson(el as Map<String, dynamic>)).toList();
        _subCategoryList.addAll(catty);
        //Add submenu to menu list
        late CDM parentMenu;
        for(final item in _menuList){
          if(item.otc_id == otcId){
            parentMenu = item;
            int index = _menuList.indexOf(item);
            _subMenuList = [];
            for(final item in _subCategoryList){
              _subMenuList.add(CDMS(item.name!, item.slug!));
            }
            item.submenus.addAll(_subMenuList);
            update();
          }
        }
        responseModel = ResponseModel(true, "child","child");
      }else{
        _isChildCategoryExist = false;
        responseModel = ResponseModel(true, "product","product");
      }

      _isLoaded = true;
      _isLoading = false;
      update();
    }else{
      responseModel = ResponseModel(true, response.statusCode.toString(),"failed");
      if (kDebugMode) {
        print('Error sub-category');
      }
    }

    return responseModel;
  }

}