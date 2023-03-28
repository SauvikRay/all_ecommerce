import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skybuybd/base/custom_loader.dart';
import 'package:skybuybd/controller/auth_controller.dart';
import 'package:skybuybd/utils/app_colors.dart';
import 'package:flag/flag.dart';
import 'package:skybuybd/utils/dimentions.dart';

import '../../../base/show_custom_snakebar.dart';
import '../../../route/route_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    void sendOtp(AuthController authController) {
      String phone = phoneController.text.trim();

      if (phone.isEmpty) {
        showCustomSnakebar('Type your phone', title: "Phone");
      } else if (!GetUtils.isPhoneNumber(phone)) {
        showCustomSnakebar('Type a valid phone number', title: "Invalid Phone");
      } else {
        authController.sendOtp(phone).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getOtp(phone));
          } else {
            showCustomSnakebar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? Container(
                color: AppColors.primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo/300w.png',
                      height: 100.0,
                    ),
                    SizedBox(height: Dimensions.height20),
                    const Text(
                      'WELCOME',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.black54),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: const Text(
                        'Login or register first to explore the global wholesale marketplace',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ),
                    SizedBox(height: 25),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  /*border: Border.all(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid,
                            strokeAlign: StrokeAlign.outside,
                          ),*/
                                  color: AppColors.primaryLightColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.red.withOpacity(0.5),
                                        blurRadius: 5.0,
                                        spreadRadius: .4),
                                  ]),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '017XX-XXXXXX',
                                  alignLabelWithHint: true,
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.7)),
                                  border: InputBorder.none,
                                  prefixIcon: Row(children: [
                                    SizedBox(width: 16),
                                    Flag.fromCode(
                                      FlagsCode.BD,
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.fitWidth,
                                      flagSize: FlagSize.size_4x3,
                                      borderRadius: 0,
                                    ),
                                    SizedBox(width: 20)
                                  ]),
                                  prefixIconConstraints: BoxConstraints(
                                      minWidth: 25,
                                      minHeight: 20,
                                      maxHeight: 30,
                                      maxWidth: 90),
                                ),
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Container(
                          width: 180,
                          child: TextButton(
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black.withOpacity(0.8)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      //side: BorderSide(color: Colors.red)
                                    ),
                                  )),
                              onPressed: () {
                                sendOtp(authController);
                              },
                              child: Text(
                                "NEXT".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : CustomLoader();
      }),
    );
  }
}
