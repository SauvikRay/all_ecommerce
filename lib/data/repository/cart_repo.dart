import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';
import 'dart:io';

class CartRepo{
  final ApiClient apiClient;
  final SharedPreferences preferences;

  CartRepo({
    required this.apiClient,
    required this.preferences
  });

  ///Cart Get
  Future<Response> getCartList() async{
    return await apiClient.getData(Constants.CART_GET_URL);
  }
  
  ///Cart Delete
  Future<Response> cartDelete(String ids) async {
    return await apiClient.postData(Constants.CART_DELETE_URL, {"item_id":ids});
  }
  
  ///Cart Post
  Future<Response> cartPost(
      String id,
      int checked,
      int QuantityRanges,
      String Title,
      String ItemData,
      int minQuantity,
      int localDelivery,
      int shippingRate,
      int BatchLotQuantity,
      int NextLotQuantity,
      dynamic ActualWeight,
      int FirstLotQuantity
      ) async{
    return await apiClient.postData(Constants.CART_POST_URL, {
      "id":id,
      "checked":checked,
      "QuantityRanges":QuantityRanges,
      "Title":Title,
      "ItemData":ItemData,
      "minQuantity":minQuantity,
      "localDelivery":localDelivery,
      "ItemId":id,
      "shipped_by":"air",
      "shippingRate":shippingRate,
      "BatchLotQuantity":BatchLotQuantity,
      "NextLotQuantity":NextLotQuantity,
      "ActualWeight":ActualWeight,
      "FirstLotQuantity":FirstLotQuantity
    });
  }

  ///Wishlist Get
  Future<Response> getWishlist() async{
    return await apiClient.getData(Constants.WISHLIST_GET_URL);
  }

  ///Wishlist Post
  Future<Response> postWishlist(String itemId,String title,String image,int price) async{
    return await apiClient.postData(Constants.WISHLIST_POST_URL,{
      "item_id":itemId,
      "Title":title,
      "MainPictureUrl":image,
      "OriginalPrice":price,
      "created_at": ''
    });
  }

}