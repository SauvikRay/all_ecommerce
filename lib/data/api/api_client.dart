import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../utils/constants.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;

  late Map<String,String> _mainHeader;
  late Map<String,String> _queryParam;
  late String key;
  late String value;

  late SharedPreferences preferences;

  ApiClient({required this.appBaseUrl,required this.preferences}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 40);
    token = preferences.getString(Constants.TOKEN) ?? "";
    _mainHeader = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
    };
    _queryParam = {
      'id' : 'value',
    };
  }

  void updateHeader(String token){
    _mainHeader = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : '$token',
    };
  }

  Future<Response> getData(String url, {Map<String, String>? headers}) async{
    try{
      Response response = await get(
        url,
        headers: headers ?? _mainHeader
      );
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async{
    try{
      Response response = await post(uri, body,headers: _mainHeader);

      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> getCategoryProduct(String url, Map<String, String>? queryParam,{Map<String, String>? headers}) async{

    try{
      Response response = await get(
        url,
        headers: headers ?? _mainHeader,
        query: queryParam
      );
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> getProductDetails(String url,{Map<String, String>? headers}) async{

    try{
      Response response = await get(
          url,
          headers: headers ?? _mainHeader
      );
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> getSubcategoryList(String url,Map<String, String>? queryParam, {Map<String, String>? headers}) async{

    try{
      Response response = await get(
          url,
          headers: headers ?? _mainHeader,
          query: queryParam
      );
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> searchProductByKeyword(String url, Map<String, String>? queryParam,{Map<String, String>? headers}) async{

    try{
      Response response = await get(
          url,
          headers: headers ?? _mainHeader,
          query: queryParam
      );
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> searchProductByImage(String url,String filePath) async{

    final FormData _formData = FormData({
      'picture': MultipartFile(File(filePath), filename: filePath),
    });


    try{
      Response response = await post(url,_formData,headers: _mainHeader);

      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

}