import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybuybd/base/show_custom_snakebar.dart';
import 'package:skybuybd/models/core/Data.dart';
import 'package:skybuybd/models/core/User.dart' as localuser;
import 'package:skybuybd/models/registration/RegistrationResponse.dart';

import '../data/repository/auth_repo.dart';
import '../models/registration/RegistrationErrorResponse.dart';
import '../models/registration/signup_body_model.dart';
import '../models/response_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //Sky
  Future<ResponseModel> sendOtp(String phone) async {
    _isLoading = true;
    update();

    Response response = await authRepo.sendOtp(phone);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      //authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(
          true, response.body["message"], response.body["status"]);
    } else {
      responseModel = ResponseModel(
          false, 'Something going wrong!', response.body["status"]);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyOtp(String phone, String verifyOtp) async {
    _isLoading = true;
    update();

    Response response = await authRepo.verifyOtp(phone, verifyOtp);
    late ResponseModel responseModel;
    late Data data;
    if (response.statusCode == 200) {
      data = Data.fromJson(response.body["data"]);
      if (kDebugMode) {
        log("Otp Verify Response : ${data.toJson().toString()}");
      }

      String token = response.body["data"]["token"];
      authRepo.saveUserToken(token);
      responseModel = ResponseModel(
          true, response.body["message"], response.body["status"]);
    } else {
      responseModel = ResponseModel(
          false, response.body["message"], response.body["status"]);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> registration(SignUpBody body) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(body);
    late ResponseModel responseModel;
    late RegistrationResponse registrationResponse;
    late RegistrationErrorResponse errorResponse;
    if (response.statusCode == 200) {
      registrationResponse = RegistrationResponse.fromJson(response.body);
      if (kDebugMode) {
        print(
            "Registration Response : ${registrationResponse.toJson().toString()}");
      }
      String? token = registrationResponse.data?.token;
      authRepo.saveUserToken(token ?? '');
      if (kDebugMode) {
        print(token);
      }
      showCustomSnakebar(response.body["message"],
          title: response.body["message"], color: Colors.green);
      responseModel = ResponseModel(
          true, response.body["message"], response.body["status"]);
    } else if (response.statusCode == 422) {
      errorResponse = RegistrationErrorResponse.fromJson(response.body);
      if (kDebugMode) {
        print("Registration Response : ${errorResponse.toJson().toString()}");
      }
      var concatenate = StringBuffer();
      errorResponse.data?.forEach((item) {
        concatenate.write(item);
      });
      showCustomSnakebar(concatenate.toString(),
          title: response.body["message"]);
      //responseModel = ResponseModel(false, response.body["message"],response.body["status"]);
    } else {
      responseModel = ResponseModel(
          false, response.body["message"], response.body["status"]);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();

    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    late Data data;
    late RegistrationErrorResponse errorResponse;

    if (response.statusCode == 200) {
      data = Data.fromJson(response.body["data"]);
      String? token = data.token;
      localuser.User user = data.user!;
      authRepo.saveUserToken(token ?? '');
      saveUserInfo(user.avatarType!, user.name!, user.firstName ?? '',
          user.lastName ?? '', user.email!, user.createdAt!, user.updatedAt!);
      showCustomSnakebar(response.body["message"],
          title: response.body["status"], color: Colors.green);
      responseModel = ResponseModel(
          true, response.body["message"], response.body["status"]);
    } else if (response.statusCode == 422) {
      errorResponse = RegistrationErrorResponse.fromJson(response.body);
      if (kDebugMode) {
        print("Login error Response : ${errorResponse.toJson().toString()}");
      }
      var concatenate = StringBuffer();
      errorResponse.data?.forEach((item) {
        concatenate.write(item);
      });
      showCustomSnakebar(concatenate.toString(),
          title: response.body["message"]);
    } else {
      responseModel = ResponseModel(
          false, response.body["message"], response.body["status"]);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserInfo(String image, String name, String fName, String lName,
      String email, String createdAt, String lastUpdated) {
    authRepo.saveUserInfo(
        image, name, fName, lName, email, createdAt, lastUpdated);
  }

  bool isUserLoggedIn() {
    return authRepo.isUserLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  Future<String> getUserTokel() {
    return authRepo.getUserToken();
  }
}
