part of 'sub_category_bloc.dart';

abstract class SubCategoryState extends Equatable {
  const SubCategoryState();

  @override
  List<Object> get props => [];
}

class SubCategoryInitial extends SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {}

class SubCategoryError extends SubCategoryState {
  final String message;

  const SubCategoryError({required this.message});
}

class SubCategoryByOtcSuccess extends SubCategoryState {
  final List<SubCategoryModel> subCategories;

  const SubCategoryByOtcSuccess({required this.subCategories});
}
