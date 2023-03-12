import 'package:dartz/dartz.dart';
import 'package:skybuybd/apps/categories/domain/repository/i_category_repository.dart';
import 'package:skybuybd/apps/core/error/failure.dart';
import 'package:skybuybd/models/category/category_model.dart';

class GetCategoryUseCase {
  ICategoryRepository categoryRepository;

  GetCategoryUseCase({required this.categoryRepository});

  Future<Either<Failure, List<CategoryModel>>> call() async {
    return await categoryRepository.getParentCategoryList();
  }
}
