import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/dimentions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("on a loading state --> "+Get.find<AuthController>().isLoading.toString());
    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.width20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.width20*5/2),
          color: AppColors.primaryColor
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
