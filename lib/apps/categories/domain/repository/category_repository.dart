import 'package:dartz/dartz.dart';
import 'package:skybuybd/apps/categories/data/i_category_data_source.dart';
import 'package:skybuybd/apps/categories/domain/repository/i_category_repository.dart';
import 'package:skybuybd/apps/core/error/exceptions.dart';
import 'package:skybuybd/models/category/sub_category_model.dart';
import 'package:skybuybd/models/category/category_model.dart';
import 'package:skybuybd/apps/core/error/failure.dart';

class CategoryRepository extends ICategoryRepository {
  ICategoryDataSource categoryDataSource;
  CategoryRepository({required this.categoryDataSource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getParentCategoryList() async {
    try {
      List<CategoryModel> result =
          await categoryDataSource.getParentCategoryList();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.errorMessage, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<SubCategoryModel>>> getSubcategoryByOtc(
      String otcId) async {
    try {
      List<SubCategoryModel> result =
          await categoryDataSource.getSubcategoryByOtc(otcId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.errorMessage, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<SubCategoryModel>>> getSubcategoryList(
      String value) {
    // TODO: implement getSubcategoryList
    throw UnimplementedError();
  }
}
