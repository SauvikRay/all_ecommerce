import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skybuybd/apps/categories/domain/use_cases/get_category_use_case.dart';
import 'package:skybuybd/apps/categories/domain/use_cases/get_subcategroy_by_otc_usecase.dart';
import 'package:skybuybd/apps/core/error/failure.dart';
import 'package:skybuybd/models/category/category_model.dart';
import 'package:skybuybd/models/category/sub_category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUseCase getCategoryUseCase;

  CategoryBloc({
    required this.getCategoryUseCase,
  }) : super(CategoryInitial()) {
    on<GetCategories>((event, emit) async {
      emit(CategoryLoading());
      Either<Failure, List<CategoryModel>> result = await getCategoryUseCase();
      result.fold((l) => emit(CategoryError(message: l.message)), (r) {
        emit(CategorySuccess(categories: r));
      });
    });
  }
}
