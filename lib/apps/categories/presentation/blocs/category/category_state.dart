part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError({required this.message});
}

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;

  const CategorySuccess({required this.categories});
}
