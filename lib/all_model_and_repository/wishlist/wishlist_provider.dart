import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;

import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';
import '../../models/wishlist_model.dart';

class WishlistProvider extends ChangeNotifier {
  List<Datum>? wishlist = [];

  addToWishlist(String itemId, String title, String image, int price) async {
    EasyLoading.show();
    String token = await Get.find<AuthController>().getUserTokel();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://www.skybuybd.com/api/v1/wishlist/store'));
    request.fields.addAll({
      'item_id': itemId,
      'Title': title,
      'MainPictureUrl': image,
      'OriginalPrice': price.toString(),
      'created_at': ''
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      showCustomSnakebar('Product added in your wishlist',
          title: 'Success', color: Colors.green);
      EasyLoading.dismiss();
    } else {
      showCustomSnakebar('Have an error', title: 'Error', color: Colors.red);
      EasyLoading.dismiss();
    }
  }

  getWishlist() async {
    wishlist = [];
    String token = await Get.find<AuthController>().getUserTokel();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://www.skybuybd.com/api/v1/wishlist/customer-wishlist'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      WishlistResponse wishlistResponse =
          wishlistResponseFromJson(await response.stream.bytesToString());
      for (int i = 0; i < wishlistResponse.data!.length; i++) {
        wishlist!.add(wishlistResponse.data![i]);
      }
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }
}
