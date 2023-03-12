import 'package:skybuybd/models/category/category_model.dart';
import 'package:skybuybd/models/category/sub_category_model.dart';

abstract class ICategoryDataSource {
  Future<List<CategoryModel>> getParentCategoryList();
  Future<List<SubCategoryModel>> getSubcategoryList(String value);
  Future<List<SubCategoryModel>> getSubcategoryByOtc(String otcId);
}
