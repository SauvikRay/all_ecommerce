import 'category_model.dart';

class CategoryResponse{


  late List<CategoryModel> _categoryList;
  List<CategoryModel> get categoryList => _categoryList;

  CategoryResponse({ required categoryList }){
    this._categoryList = categoryList;
  }

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['categoryList'] != null) {
      _categoryList = <CategoryModel>[];
      json['categoryList'].forEach((v) {
        _categoryList.add(CategoryModel.fromJson(v));
      });
    }
  }



}