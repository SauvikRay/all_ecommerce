import 'package:dartz/dartz.dart';
import 'package:skybuybd/apps/core/error/failure.dart';
import 'package:skybuybd/models/category/category_model.dart';
import 'package:skybuybd/models/category/sub_category_model.dart';

abstract class ICategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> getParentCategoryList();
  Future<Either<Failure, List<SubCategoryModel>>> getSubcategoryList(
      String value);
  Future<Either<Failure, List<SubCategoryModel>>> getSubcategoryByOtc(
      String otcId);
}
