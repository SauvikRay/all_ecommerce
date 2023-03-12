import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../api/api_client.dart';
import 'dart:io';

class ProductRepo{
  final ApiClient apiClient;
  final SharedPreferences preferences;

  ProductRepo({
    required this.apiClient,
    required this.preferences
  });

  Future<Response> getProductDetails(String slug) async{
    return await apiClient.getProductDetails(Constants.PRODUCT_DETAILS_URL+slug);
  }

  Future<Response> searchProductByKeyword(String keyword) async{
    Map<String,String> queryParameters = {
      's': keyword,
    };
    return await apiClient.searchProductByKeyword(Constants.PRODUCT_SEARCH_URL,queryParameters);
  }

  Future<http.StreamedResponse> searchProductByImage0(String filepath) async {
    var request = http.MultipartRequest('POST', Uri.parse(Constants.BASE_URL+Constants.PRODUCT_IMAGE_SEARCH_URL));
    request.fields['picture'] = filepath.toString();
    request.files.add(http.MultipartFile.fromBytes('picture', File(filepath).readAsBytesSync(),filename: filepath));
    var res = await request.send();
    return res;
  }

  Future<Response> searchProductByImage(String filepath) async {
    return await apiClient.searchProductByImage(Constants.PRODUCT_IMAGE_SEARCH_URL, filepath);
  }

}