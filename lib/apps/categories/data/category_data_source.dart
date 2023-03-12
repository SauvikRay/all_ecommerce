import 'dart:convert';
import 'dart:developer';

import 'package:skybuybd/apps/categories/data/i_category_data_source.dart';
import 'package:skybuybd/apps/core/network/i_network_client.dart';
import 'package:skybuybd/data/api/api_endpoints.dart';
import 'package:skybuybd/models/category/sub_category_model.dart';
import 'package:skybuybd/models/category/category_model.dart';

class CategoryDataSource extends ICategoryDataSource {
  final INetworkClient networkClient;

  CategoryDataSource({required this.networkClient});

  @override
  Future<List<CategoryModel>> getParentCategoryList() async {
    String result = await networkClient.get(
      paramas: const NetworkParams(
        endPoint: ApiEndpoints.parentCategoryUrl,
      ),
    );

    var dJson = jsonDecode(result);

    // log('cat result: $result');

    List<CategoryModel> response = (dJson["categoryList"] as List<dynamic>)
        .map((dynamic el) => CategoryModel.fromJson(el as Map<String, dynamic>))
        .toList();

    log('cat response: $response');

    return response;
  }

  @override
  Future<List<SubCategoryModel>> getSubcategoryByOtc(String otcId) async {
    String result = await networkClient.get(
      paramas: NetworkParams(
        endPoint: '${ApiEndpoints.parentCategoryUrl}?id=$otcId',
      ),
    );

    var dJson = jsonDecode(result);

    log('sub-cat result: $result');

    List<SubCategoryModel> response =
        (dJson["categoryList"]["children"] as List<dynamic>)
            .map((dynamic el) =>
                SubCategoryModel.fromJson(el as Map<String, dynamic>))
            .toList();

    log('sub-cat response: $response');

    return response;
  }

  @override
  Future<List<SubCategoryModel>> getSubcategoryList(String value) {
    // TODO: implement getSubcategoryList
    throw UnimplementedError();
  }
}
