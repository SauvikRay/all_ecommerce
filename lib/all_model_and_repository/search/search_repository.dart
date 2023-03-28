import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybuybd/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'search_model.dart';

class SearchRepository {
  SharedPreferences? preferences;
  Future<SearchResponse> searchedByKeyword({required String keyWord}) async {
   
    final Uri url = Uri.parse(
        "${Constants.BASE_URL}${Constants.PRODUCT_SEARCH_URL}?s=$keyWord");
    log("SearchUrl: $url");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      // log("seatchProduct: ${response.body}");
    }
    return searchFromJson(response.body);
  }
}
