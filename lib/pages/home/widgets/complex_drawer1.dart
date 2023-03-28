import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:skybuybd/utils/app_colors.dart';
import 'package:skybuybd/utils/dimentions.dart';

import '../../../controller/category_controller.dart';
import '../../../models/drawer/cdm.dart';
import '../../../models/drawer/cdms.dart';
import '../../../route/route_helper.dart';
import '../../../utils/constants.dart';
import 'Txt.dart';

class ComplexDrawer1 extends StatefulWidget {
  const ComplexDrawer1({Key? key}) : super(key: key);

  @override
  State<ComplexDrawer1> createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer1> {
  int selectedIndex = -1; //Don't set it to 0
  bool isExpanded = true;

  static List<CDM> cdms = [
    CDM("assets/cat/shoes.png", "Shoes", "shoes", []),
  ];

  Future<void> _loadResources() async {
    await Get.find<CategoryController>().getParentCategoryList();
  }

  @override
  void initState() {
    super.initState();
    //_loadResources();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<CategoryController>(builder: (categoryController) {
      return categoryController.isLoaded
          ? Drawer(
              child: Container(
                width: width,
                color: Colors.transparent,
                child: row(categoryController),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor));
    });
  }

  Widget row(CategoryController categoryController) {
    return Row(children: [
      blackIconTiles(categoryController),
      invisibleSubMenus(categoryController),
    ]);
  }

  Widget blackIconTiles(CategoryController categoryController) {
    return Container(
      width: Dimensions.width304,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categoryController.menuList.length,
              itemBuilder: (BuildContext context, int index) {
                //  if(index==0) return controlTile();
                //print("CDM Index : "+index.toString());
                CDM cdm = categoryController.menuList[index];
                bool selected = selectedIndex == index;
                return ExpansionTile(
                    onExpansionChanged: (z) {
                      if (z == true) {
                        //check here cdms is null @if null check new one
                        print("Otc id : " + cdm.otc_id);
                        EasyLoading.show();
                        Get.find<CategoryController>()
                            .getSubcategoryByOtc(cdm.otc_id)
                            .then((response) {
                          EasyLoading.dismiss();
                          if (response.isSuccess) {
                            if (response.message == "child") {
                              print("Drawer :: Going to child category page");
                            } else if (response.message == "product") {
                              print("Drawer :: Going to product page");
                            }
                          } else {
                            print("Drawer :: something Else");
                          }
                        });
                      }
                      setState(() {
                        //print("Index : "+z.toString());
                        selectedIndex = z ? index : -1;
                      });
                    },
                    //leading: Icon(cdm.icon, color: Colors.white),
                    /*leading: Image.network(
                        "${Constants.BASE_URL}/${cdm.img}",
                        color: Colors.black,
                        height: Dimensions.height30,
                        width: Dimensions.width30
                    ),*/
                    leading: CachedNetworkImage(
                      imageUrl: "${Constants.BASE_URL}/${cdm.img}",
                      height: Dimensions.height30,
                      width: Dimensions.width30,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    title: Txt(
                      text: cdm.title,
                      //color: Colors.white,
                      color: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    trailing: cdm.submenus.isEmpty
                        ? null
                        : Icon(
                            selected
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            //color: Colors.white,
                            color: Colors.black,
                          ),
                    children: cdm.submenus.map((subMenu) {
                      return sMenuButton(subMenu, false, cdm.title);
                    }).toList());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget invisibleSubMenus(CategoryController categoryController) {
    // List<CDM> _cmds = cdms..removeAt(0);
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: isExpanded ? 0 : 175,
      color: AppColors.compexDrawerCanvasColor,
      //color: AppColors.primaryDarkColor,
      child: Column(
        children: [
          Container(height: 95),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (context, index) {
                  CDM cmd = cdms[index];
                  List<CDMS> subMenuList = cdms[index].submenus;
                  // if(index==0) return Container(height:95);
                  //controll button has 45 h + 20 top + 30 bottom = 95

                  bool selected = selectedIndex == index;
                  bool isValidSubMenu = selected && cmd.submenus.isNotEmpty;
                  return subMenuWidget(subMenuList, isValidSubMenu, cmd.title);
                }),
          ),
        ],
      ),
    );
  }

  Widget subMenuWidget(
      List<CDMS> submenus, bool isValidSubMenu, String parent) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: isValidSubMenu ? submenus.length.toDouble() * 37.5 : 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isValidSubMenu
              ? AppColors.complexDrawerBlueGrey
              : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListView.builder(
          padding: EdgeInsets.all(6),
          itemCount: isValidSubMenu ? submenus.length : 0,
          itemBuilder: (context, index) {
            String subMenu = submenus[index].title;
            CDMS sMenu = submenus[index];
            return sMenuButton(sMenu, index == 0, parent);
          }),
    );
  }

  Widget sMenuButton(CDMS subMenu, bool isTitle, String parent) {
    return InkWell(
      onTap: () {
        //handle the function
        //if index==0? donothing: doyourlogic here
        print('tapping submenu : ${subMenu.otc_id}');
        Get.find<CategoryController>()
            .getSubCategoryList(subMenu.otc_id)
            .then((response) {
          if (response.isSuccess) {
            if (response.message == "child") {
              print("Drawer :: Going to child category page");
              Get.toNamed(RouteHelper.getChildCategoryPage(
                  parent, subMenu.title, subMenu.otc_id));
            } else if (response.message == "product") {
              print("Drawer :: Going to product page");
              Get.toNamed(RouteHelper.getCategoryProductPage(
                  parent, subMenu.title, "", subMenu.otc_id));
            }
          } else {
            print("Drawer :: something Else");
          }
        });
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(
          left: Dimensions.width8 * 2,
          right: Dimensions.width8 * 3,
          top: Dimensions.height8,
          bottom: Dimensions.width8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Txt(
                text: subMenu.title,
                fontSize: isTitle ? 17 : 14,
                color: isTitle ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
                maxLines: 2,
                useoverflow: true,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
