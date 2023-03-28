import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:skybuybd/all_model_and_repository/product/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<Datum>? productList = [];

  getProductList(String slug) async {
    productList = [];
    Uri url = Uri.parse("https://www.skybuybd.com/api/v1/categories?id=$slug");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    productList = productModelFromJson(response.body).products!.data;
    // log('product list : ' + productList![0].title!);

    notifyListeners();
  }
}
