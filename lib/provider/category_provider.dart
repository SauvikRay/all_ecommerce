import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/category/new_sub_category_model.dart';


class CategoryProvider extends ChangeNotifier {
  List<CategoryList>? subCategoryList = [];

  getSubCategory(String slug) async {
    subCategoryList = [];
    Uri url = Uri.parse("https://www.skybuybd.com/api/v1/categories?id=$slug");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    subCategoryList =
        newSubCategoryModelFromJson(response.body).categoryList!.children;
    log('sub cat list length : ' + subCategoryList!.length.toString());
    notifyListeners();
  }
}
