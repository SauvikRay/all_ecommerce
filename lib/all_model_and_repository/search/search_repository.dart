import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybuybd/utils/constants.dart';

import 'search_model.dart';

class SearchRepository {
  SharedPreferences? preferences;
  Future<SearchResponse> searchedByKeyword(
      {required String keyWord, int page = 0}) async {
    final Uri url = Uri.parse(
        "${Constants.BASE_URL}${Constants.PRODUCT_SEARCH_URL}?s=$keyWord&page=$page");
    log("SearchUrl: $url");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      // log("seatchProduct: ${response.body}");
    }
    return searchFromJson(response.body);
  }

  Future<SearchResponse> searchedByImage(
      {required String image, int page = 0}) async {
    log("page : " + page.toString());
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://www.skybuybd.com/api/v1/image-search'));

    request.fields.addAll({
      "page": page.toString(),
    });
    request.files.add(await http.MultipartFile.fromPath('picture', image));

    http.StreamedResponse response = await request.send();

    return searchFromJson(await response.stream.bytesToString());
  }
}
