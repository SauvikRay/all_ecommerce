import 'package:equatable/equatable.dart';
import 'package:skybuybd/apps/core/error/failure.dart';
import 'package:skybuybd/models/category/category_model.dart';

class CategoryState extends Equatable {
  final bool loading;
  final Failure failure;
  final List<CategoryModel> categories;
  const CategoryState({
    required this.loading,
    required this.failure,
    required this.categories,
  });

  CategoryState copyWith({
    bool? loading,
    Failure? failure,
    List<CategoryModel>? categories,
  }) {
    return CategoryState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      categories: categories ?? this.categories,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, categories];

  factory CategoryState.init() => const CategoryState(
        loading: false,
        failure: ServerFailure(message: ''),
        categories: [],
      );
}
