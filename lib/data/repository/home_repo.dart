import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/registration/signup_body_model.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';

class HomeRepo{
  final ApiClient apiClient;
  final SharedPreferences preferences;

  HomeRepo({
    required this.apiClient,
    required this.preferences
  });

  Future<Response> getHomePageItems() async{
    return await apiClient.getData(Constants.HOME_PAGE_URL);
  }

  //Receiving from server
  Future<Response> getConversionRate() async{
    return await apiClient.getData(Constants.CONVERSION_RATE_URL);
  }

  Future<Response> getShippingText() async{
    return await apiClient.getData(Constants.SHIPPING_TEXT_URL);
  }

  Future<bool> setConversionRate(double value) async {
    return await preferences.setDouble(Constants.CONVERSION_RATE, value);
  }

  SharedPreferences getSharedPref(){
    return preferences;
  }
}