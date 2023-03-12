import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybuybd/apps/categories/domain/repository/category_repository.dart';
import 'package:skybuybd/apps/categories/domain/repository/i_category_repository.dart';
import 'package:skybuybd/apps/categories/presentation/providers/category_state.dart';
import 'package:skybuybd/apps/core/di.dart';
import 'package:skybuybd/apps/core/error/failure.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  return CategoryNotifier(injector<CategoryRepository>());
});

class CategoryNotifier extends StateNotifier<CategoryState> {
  final ICategoryRepository categoryRepo;
  CategoryNotifier(this.categoryRepo) : super(CategoryState.init());

  getCategories() async {
    state = state.copyWith(loading: true);
    final data = await categoryRepo.getParentCategoryList();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: const ServerFailure(message: ''),
            categories: r));
    Logger().i(state.categories);
  }
}
