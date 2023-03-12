import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skybuybd/apps/categories/domain/use_cases/get_subcategroy_by_otc_usecase.dart';
import 'package:skybuybd/apps/core/error/failure.dart';
import 'package:skybuybd/models/category/sub_category_model.dart';

part 'sub_category_event.dart';
part 'sub_category_state.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  final GetSubCategoryByOTCUseCase getSubCategoryByOTCUseCase;

  SubCategoryBloc({
    required this.getSubCategoryByOTCUseCase,
  }) : super(SubCategoryInitial()) {
    on<GetSubCategoriesByOtc>((event, emit) async {
      emit(SubCategoryLoading());
      Either<Failure, List<SubCategoryModel>> result =
          await getSubCategoryByOTCUseCase(otc: event.otc);
      result.fold((l) => emit(SubCategoryError(message: l.message)), (r) {
        emit(SubCategoryByOtcSuccess(subCategories: r));
      });
    });
  }
}
