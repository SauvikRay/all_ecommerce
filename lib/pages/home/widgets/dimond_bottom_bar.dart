import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:skybuybd/utils/app_colors.dart';
import 'package:skybuybd/utils/dimentions.dart';

class DiamondBottomNavigation extends StatelessWidget {
  final List<IconData> itemIcons;
  final List<String> itemName;
  final IconData centerIcon;
  final int selectedIndex;
  final Function(int) onItemPressed;
  final double? height;
  final Color selectedColor;
  final Color selectedLightColor;
  final Color unselectedColor;
  const DiamondBottomNavigation({
    Key? key,
    required this.itemIcons,
    required this.itemName,
    required this.centerIcon,
    required this.selectedIndex,
    required this.onItemPressed,
    this.height,
    this.selectedColor = const Color(0xff46BDFA),
    this.unselectedColor = const Color(0xffB5C8E7),
    this.selectedLightColor = const Color(0xff77E2FE),
  })  : assert(itemIcons.length == 4 || itemIcons.length == 2,
  "Item must equal 4 or 2"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    final height = this.height ?? getRelativeHeight(0.076);

    return Container(
      color: Colors.transparent,
      height: height + getRelativeHeight(0.025),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height,
              color: Colors.white,
              child: Padding(
                //padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.1)),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: itemIcons.length == 4
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(0);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      itemIcons[0],
                                      color: selectedIndex == 0
                                          ? selectedColor
                                          : unselectedColor,
                                    ),
                                    Text(
                                      itemName[0],
                                      style: TextStyle(
                                        color: selectedIndex == 0
                                            ? selectedColor
                                            : unselectedColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.width15),
                          if (itemIcons.length == 4)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                splashColor: selectedColor.withOpacity(0.5),
                                onTap: () {
                                  onItemPressed(1);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        itemIcons[1],
                                        color: selectedIndex == 1
                                            ? selectedColor
                                            : unselectedColor,
                                      ),
                                      Text(
                                        itemName[1],
                                        style: TextStyle(
                                          color: selectedIndex == 1
                                              ? selectedColor
                                              : unselectedColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: itemIcons.length == 4
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(itemIcons.length == 4 ? 3 : 2);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      itemIcons[itemIcons.length == 4 ? 2 : 1],
                                      color: selectedIndex ==
                                          (itemIcons.length == 4 ? 3 : 2)
                                          ? selectedColor
                                          : unselectedColor,
                                    ),
                                    Text(
                                      itemName[itemIcons.length ==  4 ? 3 : 2],
                                      style: TextStyle(
                                        color: selectedIndex == (itemIcons.length == 4 ? 3 : 2)
                                            ? selectedColor
                                            : unselectedColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.width15),
                          if (itemIcons.length == 4)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                splashColor: selectedColor.withOpacity(0.5),
                                onTap: () {
                                  onItemPressed(4);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        itemIcons[3],
                                        color: selectedIndex == 4
                                            ? selectedColor
                                            : unselectedColor,
                                      ),
                                      Text(
                                        itemName[4],
                                        style: TextStyle(
                                          color: selectedIndex == 4
                                              ? selectedColor
                                              : unselectedColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    onItemPressed(itemIcons.length == 4 ? 2 : 1);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: Offset(0, 3),
                          color: Colors.grey,
                        )
                      ],
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      /*gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          selectedLightColor,
                          selectedColor,
                        ],
                      ),*/
                    ),
                    height: getDiamondSize(),
                    width: getDiamondSize(),
                    padding: EdgeInsets.all(Dimensions.radius20/4),
                    child: Center(
                      child: Image.asset(
                          'assets/logo/300w.png'
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static initSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }
}

double getRelativeHeight(double percentage) {
  return percentage * SizeConfig.screenHeight;
}

double getRelativeWidth(double percentage) {
  return percentage * SizeConfig.screenWidth;
}

double getDiamondSize() {
  var width = SizeConfig.screenWidth;
  if (width > 1000) {
    return 0.045 * SizeConfig.screenWidth;
  } else if (width > 900) {
    return 0.055 * SizeConfig.screenWidth;
  } else if (width > 700) {
    return 0.065 * SizeConfig.screenWidth;
  } else if (width > 500) {
    //return 0.075 * SizeConfig.screenWidth;
    //return 0.1 * SizeConfig.screenWidth;
    return 80;
  } else {
    //return 0.135 * SizeConfig.screenWidth;
    return 65;
  }
}