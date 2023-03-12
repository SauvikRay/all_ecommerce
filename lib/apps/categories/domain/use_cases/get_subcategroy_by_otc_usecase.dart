import 'package:dartz/dartz.dart';
import 'package:skybuybd/apps/categories/domain/repository/i_category_repository.dart';
import 'package:skybuybd/apps/core/error/failure.dart';
import 'package:skybuybd/models/category/sub_category_model.dart';

class GetSubCategoryByOTCUseCase {
  ICategoryRepository categoryRepository;

  GetSubCategoryByOTCUseCase({required this.categoryRepository});

  Future<Either<Failure, List<SubCategoryModel>>> call({required String otc}) async {
    return await categoryRepository.getSubcategoryByOtc(otc);
  }
}
