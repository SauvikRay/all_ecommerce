import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';
import 'package:skybuybd/base/custom_loader.dart';
import 'package:skybuybd/controller/auth_controller.dart';
import 'package:skybuybd/pages/home/home_page.dart';
import 'package:skybuybd/pages/auth/login/login_page.dart';
import 'package:skybuybd/utils/dimentions.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../../base/show_custom_snakebar.dart';
import '../../../route/route_helper.dart';
import '../../../utils/app_colors.dart';

class OtpPage extends StatefulWidget {
  final String phone;
  const OtpPage({Key? key, required this.phone}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OtpFieldController otpController = OtpFieldController();

  @override
  void dispose() {
    super.dispose();
    //otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    verifyOtp(AuthController authController, String otp) {
      String phone = widget.phone;

      if (otp.isEmpty) {
        showCustomSnakebar('Type your otp', title: "OTP");
      } else if (otp.length != 4) {
        showCustomSnakebar('Type otp', title: "Invalid OTP");
      } else {
        authController.verifyOtp(phone, otp).then((status) {
          if (status.isSuccess) {
            print(status.toString());
            showCustomSnakebar(status.message);
            // Get.toNamed(RouteHelper.getInitial());
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return child;
                  },
                ));
          } else {
            showCustomSnakebar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: _buildAppBar(),
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/300w.png',
                    height: 100.0,
                  ),
                  SizedBox(height: Dimensions.height20),
                  const Text(
                    'VERIFICATION CODE',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.black54,
                        letterSpacing: 1),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: const Text(
                      'A verification code is sent to your mobile number  ',
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OTPTextField(
                              controller: otpController,
                              length: 4,
                              width: MediaQuery.of(context).size.width,
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldWidth: 45,
                              fieldStyle: FieldStyle.underline,
                              outlineBorderRadius: 15,
                              style: TextStyle(fontSize: 17),
                              otpFieldStyle: OtpFieldStyle(
                                  borderColor: Colors.white,
                                  backgroundColor: Colors.transparent,
                                  focusBorderColor: Colors.white,
                                  disabledBorderColor: Colors.yellow,
                                  enabledBorderColor: Colors.white,
                                  errorBorderColor: Colors.black),
                              onChanged: (pin) {
                                print("Changed: " + pin);
                              },
                              onCompleted: (pin) {
                                print("Completed: " + pin);
                                if (pin.length == 4) {
                                  verifyOtp(authController, pin);
                                }
                              }),
                          /*Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryLightColor,
                      boxShadow: [
                        BoxShadow(color: Colors.red.withOpacity(0.5), blurRadius: 5.0, spreadRadius: .4),
                      ]
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'XXXX',
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Colors.transparent,

                      hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.7)
                      ),
                      border: InputBorder.none,
                      prefixIcon: Row(
                          children: [
                            SizedBox(width: 16),
                            Icon(
                              Icons.lock,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 20)
                          ]
                      ),
                      prefixIconConstraints: BoxConstraints(
                          minWidth: 25,
                          minHeight: 20,
                          maxHeight: 30,
                          maxWidth: 90
                      ),
                    ),
                    controller: otpController,
                    keyboardType: const TextInputType.numberWithOptions(signed: false,decimal: false),
                  ),
                ),*/
                        ],
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: 180,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
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
                            child: Text(
                              "submit".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                ],
              )
            : CustomLoader();
      }),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        children: [
          GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              //size: 40 ,
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
