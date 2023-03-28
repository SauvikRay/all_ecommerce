import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skybuybd/new_cart/product_model.dart';

import '../base/show_custom_snakebar.dart';
import '../utils/app_colors.dart';
import '../utils/dimentions.dart';

class ProdyctDetailsScreen extends StatefulWidget {
  const ProdyctDetailsScreen({super.key});

  @override
  State<ProdyctDetailsScreen> createState() => _ProdyctDetailsScreenState();
}

class _ProdyctDetailsScreenState extends State<ProdyctDetailsScreen> {
  int selectedIndex = 0;
  bool isFirst = true;

  List<ColorModel> colorModel = [
    ColorModel(
      colorId: 1,
      color: "Red",
      isColorSelected: false,
      quantity: 0,
      variant: [
        VarientModel(
            varientId: 10,
            price: 100,
            size: 24,
            varientColor: "Red",
            stock: 10,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 20,
            price: 200,
            size: 26,
            varientColor: "Red",
            stock: 5,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 30,
            price: 300,
            size: 28,
            varientColor: "Red",
            stock: 7,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 40,
            price: 400,
            size: 30,
            varientColor: "Red",
            stock: 6,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 50,
            price: 500,
            size: 32,
            varientColor: "Red",
            stock: 4,
            varientAmount: 0,
            isVarientSelected: false),
      ],
    ),
    ColorModel(
      colorId: 1,
      color: "Green",
      isColorSelected: false,
      quantity: 0,
      variant: [
        VarientModel(
            varientId: 10,
            price: 100,
            size: 38,
            varientColor: "Green",
            stock: 10,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 20,
            price: 200,
            size: 40,
            varientColor: "Green",
            stock: 5,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 30,
            price: 300,
            size: 42,
            varientColor: "Green",
            stock: 7,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 40,
            price: 400,
            size: 44,
            varientColor: "Green",
            stock: 6,
            varientAmount: 0,
            isVarientSelected: false),
      
      ],
    ),
    ColorModel(
      colorId: 1,
      color: "Blue",
      isColorSelected: false,
      quantity: 0,
      variant: [
        VarientModel(
            varientId: 10,
            price: 100,
            size: 50,
            varientColor: "Blue",
            stock: 10,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 20,
            price: 200,
            size: 52,
            varientColor: "Blue",
            stock: 5,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 30,
            price: 300,
            size: 54,
            varientColor: "Blue",
            stock: 7,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 40,
            price: 400,
            size: 56,
            varientColor: "Blue",
            stock: 6,
            varientAmount: 0,
            isVarientSelected: false),
        VarientModel(
            varientId: 50,
            price: 500,
            size: 58,
            varientColor: "Blue",
            stock: 4,
            varientAmount: 0,
            isVarientSelected: false),
      ],
    ),
  ];

  List<VarientModel>? varientModel;

  var cartedProductItem = [];

  bool selectedcolorModel = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("new details"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Produyct details"),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: colorModel.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(width: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   if (isFirst) {
                          //     selectedIndex = index;
                          //     colorModel[selectedIndex].isColorSelected = true;
                          //     isFirst = false;
                          //   } else {
                          //     colorModel[selectedIndex].isColorSelected = false;
                          //     selectedIndex = index;
                          //     colorModel[selectedIndex].isColorSelected = true;
                          //   }
                          // });
                          for (var item in colorModel) {
                            setState(() {
                              item.isColorSelected = false;
                            });
                            colorModel[index].isColorSelected = true;
                          }
                          setState(() {
                            varientModel = colorModel[index].variant;
                          });
                          log(varientModel.toString());
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: colorModel[index]
                                            .isColorSelected // selectedcolorModel
                                        ? Colors.green
                                        : Colors.black)),
                            child: Center(
                                child: Text("${colorModel[index].color}"))),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                (varientModel != null)
                    ? SizedBox(
                        height: 200,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: varientModel!.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemBuilder: (context, variantIndex) {
                            return Row(
                              children: [
                                Text("${varientModel![variantIndex].size}"),
                                Spacer(),
                                varientModel![variantIndex].varientAmount == 0
                                    ? GestureDetector(
                                        child: const Text('Add'),
                                        onTap: () {
                                          var data = {
                                            "id": varientModel![variantIndex]
                                                .varientId,
                                            'amount':
                                                varientModel![variantIndex]
                                                        .varientAmount +
                                                    1
                                          };
                                          setState(() {
                                            // cartedProductItem.add(data);
                                            varientModel![variantIndex]
                                                    .varientAmount =
                                                varientModel![variantIndex]
                                                        .varientAmount +
                                                    1;
                                          });
                                          log(cartedProductItem.toString());
                                        },
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.5,
                                                color: Color(0xFF14395c)),
                                            top: BorderSide(
                                                width: 1.5,
                                                color: Color(0xFF14395c)),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //Remove Button
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  // cartedProductItem.add(data);
                                                  varientModel![variantIndex]
                                                          .varientAmount =
                                                      varientModel![
                                                                  variantIndex]
                                                              .varientAmount -
                                                          1;
                                                });
                                              },
                                              child: Container(
                                                width: Dimensions.width30,
                                                height: Dimensions.height30,
                                                color:
                                                    AppColors.btnColorBlueDark,
                                                child: const Icon(Icons.remove,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            //Quantity
                                            Container(
                                              width: Dimensions.width30,
                                              height: Dimensions.height30,
                                              color: Colors.white,
                                              child: Center(
                                                child: Text(
                                                  "${varientModel![variantIndex].varientAmount}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            //Add Button
                                            GestureDetector(
                                              onTap: () {
                                                var data = {
                                                  "id": varientModel![
                                                          variantIndex]
                                                      .varientId,
                                                  'amount': varientModel![
                                                              variantIndex]
                                                          .varientAmount +
                                                      1
                                                };
                                                setState(() {
                                                  cartedProductItem.add(data);
                                                  varientModel![variantIndex]
                                                          .varientAmount =
                                                      varientModel![
                                                                  variantIndex]
                                                              .varientAmount +
                                                          1;
                                                });
                                                log(cartedProductItem
                                                    .toString());
                                              },
                                              child: Container(
                                                width: Dimensions.width30,
                                                height: Dimensions.height30,
                                                color:
                                                    AppColors.btnColorBlueDark,
                                                child: const Icon(Icons.add,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
