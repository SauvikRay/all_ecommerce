import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybuybd/apps/core/error/exceptions.dart';
import 'package:skybuybd/data/api/api_endpoints.dart';
import 'package:skybuybd/utils/constants.dart';

import 'i_network_client.dart';

class NetworkClient implements INetworkClient {
  final Dio dio;

  NetworkClient({required this.dio});

  @override
  Future<String> get({required NetworkParams paramas}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    late String token;

    token = preferences.getString(Constants.TOKEN) ?? "";

    Response response;
    try {
      response = await dio.get(
        ApiEndpoints.baseUrl + paramas.endPoint,
        options: Options(
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          contentType: paramas.contentType,
        ),
      );
      return jsonEncode(response.data);
    } on DioError catch (e) {
      throw ServerException(
        errorMessage: e.message,
        errorData:
            e.response != null ? e.response!.data : e.requestOptions.data,
      );
    }
  }

  @override
  Future<dynamic> post({required PostParamas paramas}) async {
    Response response;
    try {
      var formData;
      if (paramas.body != null) {
        if (paramas.isJsonBody) {
          formData = jsonEncode(paramas.body);
        } else {
          formData = FormData.fromMap(paramas.body);
        }
      }
      response = await dio.post(
        ApiEndpoints.baseUrl + paramas.endPoint,
        data: formData,
        options: Options(
          contentType: paramas.contentType,
          headers: paramas.headers,
        ),
      );

      return response.data;
    } on DioError catch (e) {
      if (kDebugMode) print('post exception is $e');
      if (e.type == DioErrorType.other) {
        throw ServerException(errorMessage: 'No Internet connection!');
      } else if (e.type == DioErrorType.response) {
        return e.response!.data;
      } else {
        throw ServerException(
            errorMessage: e.message,
            errorData:
                e.response != null ? e.response!.data : e.requestOptions.data);
      }
    }
  }
}
