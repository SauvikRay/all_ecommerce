import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/registration/signup_body_model.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences preferences;

  AuthRepo({
    required this.apiClient,
    required this.preferences
  });


  //Sky
  Future<Response> sendOtp(String phone) async{
    return await apiClient.post(Constants.OTP_PHONE_SUBMIT, {"phone":phone});
  }

  Future<Response> verifyOtp(String phone,String otp_code) async{
    return await apiClient.post(Constants.OTP_CODE_SUBMIT, {"phone":phone,"otp_code":otp_code});
  }


  Future<Response> registration(SignUpBody body) async{
    return await apiClient.postData(Constants.REGISTRATION_URL, body.toJson());
  }

  Future<Response> login(String email, String password) async{
    return await apiClient.postData(Constants.LOGIN_URL, {"email":email,"password":password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);

    return await preferences.setString(Constants.TOKEN, token);
  }

  Future<void> saveUserInfo(String image,String name,String fName,String lName,String email,String createdAt,String lastUpdated) async{
    try{
      await preferences.setString(Constants.USER_IMAGE, image);
      await preferences.setString(Constants.USER_NAME, name);
      await preferences.setString(Constants.USER_FIRST_NAME, fName);
      await preferences.setString(Constants.USER_LAST_NAME, lName);
      await preferences.setString(Constants.USER_EMAIL, email);
      await preferences.setString(Constants.USER_CREATED_AT, createdAt);
      await preferences.setString(Constants.USER_LAST_UPDATED, lastUpdated);
    }catch(e){
      throw e;
    }
  }

  Future<String> getUserToken() async {
    return preferences.getString(Constants.TOKEN) ?? 'None';
  }

  bool isUserLoggedIn(){
    return preferences.containsKey(Constants.TOKEN);
  }

  bool clearSharedData(){
    preferences.remove(Constants.TOKEN);
    preferences.remove(Constants.USER_IMAGE);
    preferences.remove(Constants.USER_NAME);
    preferences.remove(Constants.USER_EMAIL);
    preferences.remove(Constants.USER_CREATED_AT);
    preferences.remove(Constants.USER_LAST_UPDATED);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }



}