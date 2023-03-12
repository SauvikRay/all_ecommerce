import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/registration/signup_body_model.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';

class CategoryRepo{
  final ApiClient apiClient;
  final SharedPreferences preferences;

  CategoryRepo({
    required this.apiClient,
    required this.preferences
  });

  Future<Response> getParentCategoryList() async{
    return await apiClient.getData(Constants.PARENT_CATEGORY_URL);
  }

  Future<Response> getSubcategoryList(String value) async{
    Map<String,String> queryParameters = {
      'id': value,
    };
    return await apiClient.getSubcategoryList(Constants.CATEGORY_PRODUCT_URL,queryParameters);
  }

  Future<Response> getSubcategoryByOtc(String otcId) async{
    Map<String,String> queryParameters = {
      'id': otcId,
    };
    return await apiClient.getSubcategoryList(Constants.CATEGORY_PRODUCT_URL,queryParameters);
  }
}