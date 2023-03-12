import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skybuybd/utils/app_colors.dart';

import '../../../utils/constants.dart';
import 'Txt.dart';

class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({Key? key}) : super(key: key);

  @override
  State<ComplexDrawer> createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {

  int selectedIndex = -1; //Don't set it to 0
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      color: AppColors.compexDrawerCanvasColor,
      child: row(),
    );
  }

  Widget row() {
    return Row(children: [
      isExpanded ? blackIconTiles() : blackIconMenu(),
      invisibleSubMenus(),
    ]);
  }

  Widget blackIconTiles() {
    return Container(
      width: 200,
      //color: AppColors.complexDrawerBlack,
      color: Colors.white,
      child: Column(
        children: [
          controlTile(),
          Expanded(
            child: ListView.builder(
              itemCount: cdms.length,
              itemBuilder: (BuildContext context, int index) {
                //  if(index==0) return controlTile();

                CDM cdm = cdms[index];
                bool selected = selectedIndex == index;
                return ExpansionTile(
                    onExpansionChanged: (z) {
                      setState(() {
                        selectedIndex = z ? index : -1;
                      });
                    },
                    //leading: Icon(cdm.icon, color: Colors.white),
                    leading: Image.asset(cdm.img, color: Colors.black,height: 30,width: 30,),
                    title: Txt(
                      text: cdm.title,
                      //color: Colors.white,
                      color: Colors.black,
                    ),
                    trailing: cdm.submenus.isEmpty
                        ? null
                        : Icon(
                      selected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      //color: Colors.white,
                      color: Colors.black,
                    ),
                    children: cdm.submenus.map((subMenu) {
                      return sMenuButton(subMenu, false);
                    }).toList());
              },
            ),
          ),
          //accountTile(),
        ],
      ),
    );
  }

  Widget controlTile() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: ListTile(
        leading: Image.asset('assets/logo/ballon.png'),
        title: Txt(
          text: "SkyBuy BD",
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        onTap: expandOrShrinkDrawer,
      ),
    );
  }

  Widget blackIconMenu() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: 100,
      //color: AppColors.complexDrawerBlack,
      color: Colors.white,
      child: Column(
        children: [
          controlButton(),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (contex, index) {
                  // if(index==0) return controlButton();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      //child: Icon(cdms[index].icon, color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(cdms[index].img, color: Colors.black),
                      ),
                    ),
                  );
                }),
          ),
          //accountButton(),
        ],
      ),
    );
  }

  Widget invisibleSubMenus() {
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
                  // if(index==0) return Container(height:95);
                  //controll button has 45 h + 20 top + 30 bottom = 95

                  bool selected = selectedIndex == index;
                  bool isValidSubMenu = selected && cmd.submenus.isNotEmpty;
                  return subMenuWidget([cmd.title]..addAll(cmd.submenus), isValidSubMenu);
                }),
          ),
        ],
      ),
    );
  }

  Widget controlButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: InkWell(
        onTap: expandOrShrinkDrawer,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: Image.asset(
            'assets/logo/ballon.png',width: 50,height: 50,
          ),
        ),
      ),
    );
  }

  Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: isValidSubMenu ? submenus.length.toDouble() * 37.5 : 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isValidSubMenu ? AppColors.complexDrawerBlueGrey : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListView.builder(
          padding: EdgeInsets.all(6),
          itemCount: isValidSubMenu ? submenus.length : 0,
          itemBuilder: (context, index) {
            String subMenu = submenus[index];
            return sMenuButton(subMenu, index == 0);
          }),
    );
  }

  Widget sMenuButton(String subMenu, bool isTitle) {
    return InkWell(
      onTap: () {
        //handle the function
        //if index==0? donothing: doyourlogic here
        print('tapping submenu');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Txt(
          text: subMenu,
          fontSize: isTitle ? 17 : 14,
          color: isTitle ? Colors.white : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget accountButton({bool usePadding = true}) {
    return Padding(
      padding: EdgeInsets.all(usePadding ? 8 : 0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.white70,
          image: DecorationImage(
            image: NetworkImage(Constants.avatar2),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget accountTile() {
    return Container(
      color: AppColors.complexDrawerBlueGrey,
      child: ListTile(
        leading: accountButton(usePadding: false),
        title: Txt(
          text: "Prem Shanhi",
          color: Colors.white,
        ),
        subtitle: Txt(
          text: "Web Designer",
          color: Colors.white70,
        ),
      ),
    );
  }

  static List<CDM> cdms = [
    CDM("assets/cat/shoes.png", "Shoes", "", ["Men Shoes", "Men Boots", "Ladies Shoes","Ladies Boots","Ladies High Heels"]),
    CDM("assets/cat/bags.png", "Bags","", []),
    CDM("assets/cat/jewelry.png", "Jewelry","", []),
    CDM("assets/cat/beauty-and-pers.png", "Beauty & Personal Care","", []),
    CDM("assets/cat/mens-clothing.png", "Men's Clothing","", []),
    CDM("assets/cat/women-clothing.png", "Women Clothing","", []),
    CDM("assets/cat/baby-items.png", "Baby Items","", []),
    CDM("assets/cat/eyewear.png", "Eyewear","", []),
    CDM("assets/cat/office-school.png", "Office & School Supplies","", []),
    CDM("assets/cat/seasonal-product.png", "Seasonal Product","", []),
    CDM("assets/cat/phone-accessori.png","", "Phone Accessories", []),
    CDM("assets/cat/sports-fitness.png", "Sports & Fitness","", []),
    CDM("assets/cat/entertainment.png", "Entertainment Item","", []),
    CDM("assets/cat/watches.png", "Watches","", []),
    CDM("assets/cat/automobile-item.png", "Automobile Items","", []),
    CDM("assets/cat/groceries.png", "Groceries & Pets","", []),
    CDM("assets/cat/electronics-gad.png", "Electronics & Gadgets","", []),
    CDM("assets/cat/home-and-kitchen.png", "Home & Kitchen","", []),
  ];

  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

}

class CDM {
  //complex drawer menu
  final String img;
  final String title;
  final String otc_id;
  final List<String> submenus;

  CDM(this.img, this.title, this.otc_id, this.submenus);
}
