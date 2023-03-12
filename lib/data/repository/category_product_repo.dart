import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';

class CategoryProductRepo{
  final ApiClient apiClient;
  final SharedPreferences preferences;

  CategoryProductRepo({
    required this.apiClient,
    required this.preferences
  });

  Future<Response> getCategoryProductList(String value) async{
    Map<String,String> queryParameters = {
      'id': value,
    };
    return await apiClient.getCategoryProduct(Constants.CATEGORY_PRODUCT_URL,queryParameters);
  }

}