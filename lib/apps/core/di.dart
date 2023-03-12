import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:skybuybd/apps/categories/data/category_data_source.dart';
import 'package:skybuybd/apps/categories/data/i_category_data_source.dart';
import 'package:skybuybd/apps/categories/domain/repository/category_repository.dart';
import 'package:skybuybd/apps/categories/domain/repository/i_category_repository.dart';
import 'package:skybuybd/apps/categories/domain/use_cases/get_category_use_case.dart';
import 'package:skybuybd/apps/categories/domain/use_cases/get_subcategroy_by_otc_usecase.dart';
import 'package:skybuybd/apps/categories/presentation/blocs/category/category_bloc.dart';
import 'package:skybuybd/apps/categories/presentation/blocs/sub_category_bloc/sub_category_bloc.dart';
import 'package:skybuybd/apps/core/network/i_network_client.dart';
import 'package:skybuybd/apps/core/network/network_client.dart';

final injector = GetIt.instance;

Future<void> injectDependencies() async {
  injector.registerLazySingleton<Dio>(() => Dio());

  injector.registerLazySingleton<INetworkClient>(
      () => NetworkClient(dio: injector()));

  injector.registerLazySingleton<ICategoryDataSource>(
      () => CategoryDataSource(networkClient: injector()));

  injector.registerLazySingleton<ICategoryRepository>(
      () => CategoryRepository(categoryDataSource: injector()));

  injector.registerLazySingleton<GetCategoryUseCase>(
      () => GetCategoryUseCase(categoryRepository: injector()));

  injector.registerLazySingleton<GetSubCategoryByOTCUseCase>(
      () => GetSubCategoryByOTCUseCase(categoryRepository: injector()));

  // injector.registerLazySingleton<RegisterUseCase>(
  //     () => RegisterUseCase(authRepository: injector()));

  // injector.registerLazySingleton<RefreshUseCase>(
  //     () => RefreshUseCase(authRepository: injector()));

  injector.registerLazySingleton<CategoryBloc>(() => CategoryBloc(
        getCategoryUseCase: injector(),
      ));

injector.registerLazySingleton<SubCategoryBloc>(() => SubCategoryBloc(
        getSubCategoryByOTCUseCase: injector(),
      ));
  // injector.registerLazySingleton<RandomFileBloc>(
  //     () => RandomFileBloc(getRandomFileUseCase: injector()));
}
