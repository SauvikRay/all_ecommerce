import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skybuybd/base/footer.dart';
import 'package:skybuybd/base/show_custom_snakebar.dart';
import 'package:skybuybd/controller/cart_controller.dart';
import 'package:skybuybd/controller/order_controller.dart';
import 'package:skybuybd/models/DeleteModel.dart';
import 'package:skybuybd/models/meta_data.dart';
import 'package:skybuybd/pages/payment/payment_page.dart';
import 'package:skybuybd/pages/product/single_product_page.dart';
import 'package:skybuybd/utils/app_colors.dart';
import 'package:skybuybd/utils/constants.dart';
import 'package:skybuybd/widgets/app_icon.dart';
import 'package:skybuybd/widgets/big_text.dart';

import '../../base/page_loader.dart';
import '../../controller/auth_controller.dart';
import '../../models/cart_model.dart';
import '../../route/route_helper.dart';
import '../../utils/dimentions.dart';
import '../home/home_page.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  final List<Cart> cartlist;
  const CartPage({Key? key,required this.cartlist}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  //Checkbox all
  bool checkAll = false;
  bool firstItem = false;
  bool secondItem = false;

  late bool isUserLoggedIn;
  late double width;

  List<Cart> cartList = [];

  @override
  void initState() {
    super.initState();

    Get.find<CartController>().getCartList();
    Get.find<OrderController>().getCustomerAddressList();
  }

  @override
  Widget build(BuildContext context) {

    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    width = MediaQuery.of(context).size.width;

    //Body
    /*Widget _buildBody(){
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header Counter
            Container(
              height: Dimensions.height30*2,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor
                        ),
                        child: Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.width10),
                      Text(
                        'CART',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '24 November, 2022',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 2,
              color: AppColors.newBorderColor,
            ),
            SizedBox(height: Dimensions.height10/2),
            //Header 2
            Container(
              height: Dimensions.width20*3,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: checkAll,
                    onChanged: (value) {
                      setState(() {
                        checkAll = value!;
                        firstItem = value;
                        secondItem = value;
                      });
                    },
                    activeColor: Colors.white,
                    checkColor: AppColors.primaryColor,
                    fillColor: MaterialStateProperty.all(Colors.white),
                    focusColor: Colors.white,
                  ),
                  Text(
                    'From China'.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return Colors.blue.withOpacity(0.04);
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed))
                            return Colors.blue.withOpacity(0.12);
                          return null; // Defer to the widget's default.
                        },
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () { },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      child: const Text(
                        'Remove All',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Header 3
            Container(
              width: width,
              height: Dimensions.width20*2,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
              child: Text(
                'ORDER ID: #12523XX',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.95),
                    letterSpacing: 0
                ),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.newBorderColor,
            ),
            //Cart Items with variation
            Container (
              height: 700,
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
              child: ListView.builder(
                  itemCount: cartList.length,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 350,
                      child: Column(
                        children: [
                          //1st element / cart item
                          Container(
                            height: 350,
                            padding: EdgeInsets.only(top: Dimensions.height10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Item Parent Header //Header size 130
                                Container(
                                  height:130,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Checkbox(
                                            value: firstItem,
                                            onChanged: (value) {
                                              setState(() {
                                                firstItem = value!;
                                              });
                                            },
                                            activeColor: Colors.white,
                                            checkColor: Colors.white,
                                            fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                                            focusColor: Colors.white,
                                          ),
                                          SizedBox(width: Dimensions.width10/2),
                                          Container(
                                            height: Dimensions.height30*2,
                                            width: Dimensions.width20*3,
                                            padding: EdgeInsets.symmetric(horizontal: 4),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                color: Colors.white,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        cartList[index].image
                                                    ),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          Expanded(
                                            child: Text(
                                              cartList[index].name,
                                              maxLines: 4,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10/2),
                                          AppIcon(
                                            icon: Icons.delete_forever,
                                            backgroundColor: Colors.redAccent,
                                            iconColor: Colors.white,
                                            iconSize: 20,
                                            size: 30,
                                          ),
                                          SizedBox(width: Dimensions.width10/2),
                                        ],
                                      ),
                                      Container(
                                        height: 50,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                                                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                                      (Set<MaterialState> states) {
                                                    if (states.contains(MaterialState.hovered))
                                                      return Colors.blue.withOpacity(0.04);
                                                    if (states.contains(MaterialState.focused) ||
                                                        states.contains(MaterialState.pressed))
                                                      return Colors.blue.withOpacity(0.12);
                                                    return null; // Defer to the widget's default.
                                                  },
                                                ),
                                                backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                                              ),
                                              onPressed: () { },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                                                child: Text(
                                                  cartList[index].shipment,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.width20),
                                            TextButton(
                                              style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                                                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                                      (Set<MaterialState> states) {
                                                    if (states.contains(MaterialState.hovered))
                                                      return Colors.blue.withOpacity(0.04);
                                                    if (states.contains(MaterialState.focused) ||
                                                        states.contains(MaterialState.pressed))
                                                      return Colors.blue.withOpacity(0.12);
                                                    return null; // Defer to the widget's default.
                                                  },
                                                ),
                                                backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                                              ),
                                              onPressed: () { },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                                                child: Text(
                                                  cartList[index].shipment_days,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 1,
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
                                const Divider(
                                  height: 1,
                                  thickness: 2,
                                  color: AppColors.newBorderColor,
                                ),
                                //Variant list
                                //First element + First child
                                Container(
                                  height: 150,
                                  color: Colors.white,
                                  padding: EdgeInsets.only(right: Dimensions.height10,left: Dimensions.width30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          BigText(
                                            text: "COLOR: ${cartList[index].pvList[0].color}",
                                            size: 16,
                                          ),
                                          SizedBox(height: Dimensions.height10/2),
                                          BigText(
                                            text: "SIZE: ${cartList[index].pvList[0].size}",
                                            size: 16,
                                          ),
                                          SizedBox(height: Dimensions.height10),
                                          Container(
                                            height: 40,
                                            padding: EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                    shape: CircleBorder(),
                                                    backgroundColor: AppColors.primaryColor,
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    //size: 30,
                                                    shadows: [
                                                      Shadow(
                                                          color: AppColors.primaryColor,
                                                          offset: Offset.zero,
                                                          blurRadius: 5
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                    height:30,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    child: Center(
                                                      child: BigText(
                                                        text: '1',
                                                      ),
                                                    )
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                    shape: CircleBorder(),
                                                    backgroundColor: AppColors.primaryColor,
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    //size: 30,
                                                    shadows: [
                                                      Shadow(
                                                          color: AppColors.primaryColor,
                                                          offset: Offset.zero,
                                                          blurRadius: 5
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.height10),
                                          BigText(
                                            text: "৳: ${cartList[index].pvList[0].price}",
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                      BigText(
                                          text: "৳: ${cartList[index].pvList[0].price}"
                                      ),
                                      AppIcon(
                                        icon: Icons.close,
                                        backgroundColor: AppColors.primaryColor,
                                        iconColor: Colors.white,
                                        iconSize: 16,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 2,
                                  color: AppColors.newBorderColor,
                                ),
                                Container(
                                  height: 50,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        text: "10",
                                        size: 16,
                                      ),
                                      BigText(
                                        text: "৳ 126",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: AppColors.newBorderColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            //Total
            Container(
              height: 40,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(width: 30),
                  Text(
                    '৳ 188',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.newBorderColor,
            ),
            //Chaina shipping
            Container(
              height: 40,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'China Local Shiping',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(width: 30),
                  Text(
                    '৳ 0',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.newBorderColor,
            ),
            //Shipping address & others + Checkout info
            Container(
              height: 460,
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Manage',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryColor
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: AppColors.primaryColor
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Add Shipping Address',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Apply Coupon',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 48,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: AppColors.primaryColor
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width-134,
                          child: const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                //borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Coupon',
                              hintMaxLines: 1,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('coupon');
                          },
                          child: Container(
                            width: 100,
                            height: 48,
                            padding: EdgeInsets.only(left: 16.0,top: 1,bottom: 1,right: 16),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: const Center(
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  const SizedBox(
                    height: 40,
                    child: Text(
                      'Order Summary',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),
                    ),
                  ),
                  SizedBox(height: 0),
                  const Divider(
                    height: 0,
                    thickness: 1.5,
                    color: AppColors.newBorderColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Products Price',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54
                          ),
                        ),
                        Text(
                          '৳ 0',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1.5,
                    color: AppColors.newBorderColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Need to Pay 50%',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54
                          ),
                        ),
                        Text(
                          '৳ 0',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1.5,
                    color: AppColors.newBorderColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Due',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54
                          ),
                        ),
                        Text(
                          '৳ 0',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1.5,
                    color: AppColors.newBorderColor,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: const Text(
                      'পণ্য আসার পর শিপিং মেথড অনুযায়ী বাম পাশে উল্লেখিত প্রতি কেজি হিসেবে শিপিং ও কাস্টমস চার্জ যোগ হবে',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }*/
    //Appbar
    AppBar _buildAppBar() {
      return AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        toolbarHeight: Dimensions.height10*10,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getInitial());
          },
          child: Image.asset(
            Constants.appBarLogo,
            height: Dimensions.appBarLogoHeight,
            width: Dimensions.appBarLogoWidth,
          ),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(Dimensions.height56),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10
              ),
              child: SizedBox(
                height: Dimensions.height48,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(Dimensions.radius20/2),
                    prefixIcon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius8),
                          bottomRight: Radius.circular(Dimensions.radius8),
                        ),
                        color: Colors.black,
                      ),
                      child: const Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search by keyword',
                    hintMaxLines: 1,
                  ),
                ),
              ),
            )
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Stack(
                  children: [
                    AppIcon(
                      icon: CupertinoIcons.heart,
                      backgroundColor: Colors.transparent,
                      size: 50,
                      iconSize: 28,
                      iconColor: Colors.white,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: AppIcon(
                        icon: Icons.circle,
                        size: 24,
                        iconColor: Colors.white,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      right:8,
                      top:5,
                      child: BigText(
                        text: '0',
                        size: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                onTap: (){
                  //Goto Wishlist
                  Get.toNamed(RouteHelper.getWishListPage());
                },
              ),
              GestureDetector(
                child: Stack(
                  children: [
                    AppIcon(
                      icon: CupertinoIcons.shopping_cart,
                      backgroundColor: Colors.transparent,
                      size: 50,
                      iconSize: 28,
                      iconColor: Colors.white,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: AppIcon(
                        icon: Icons.circle,
                        size: 24,
                        iconColor: Colors.white,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      right:8,
                      top:5,
                      child: BigText(
                        text: '0',
                        size: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                onTap: (){
                  //Goto Cart

                },
              ),
              IconButton(
                /*icon: const FaIcon(
                FontAwesomeIcons.userCircle,
                color: Colors.black54,
              ),*/
                icon: const Icon(
                  CupertinoIcons.person_crop_circle,
                  color: Colors.white,
                ),
                tooltip: 'Profile',
                onPressed: () {
                  Get.toNamed(RouteHelper.getAccountPage());
                },
              ),
            ],
          ),
        ],
      );
    }

    void cartPost(String id, int checked, int QuantityRanges, String Title, String ItemData, int minQuantity, int localDelivery, int shippingRate, int BatchLotQuantity, int NextLotQuantity, dynamic ActualWeight, int FirstLotQuantity){
      //Cart Post
      Get.find<CartController>().cartPost(
          id, //id ->Product detail id
          checked, //checked
          QuantityRanges, //QuantityRanges
          Title,//Title
          ItemData, //ItemData
          minQuantity, //minQuantity
          localDelivery, //localDelivery
          shippingRate, //shippingRate
          BatchLotQuantity, //BatchLotQuantity
          NextLotQuantity, //NextLotQuantity
          ActualWeight,  // ActualWeight
          FirstLotQuantity //FirstLotQuantity
      ).then((response) {
        print("Cart Post Response : "+response.toString());
        if(response.isSuccess){
          Get.find<CartController>().getCartList().then((response) {
            print("Cart Get Response : "+response.toString());
            if(response.isSuccess){
              PageLoader(context).stopLoading();
              setState(() {
                cartList = Get.find<CartController>().cartList;
              });
            }
          });
        }
      });
    }

    void cartDelete(DeleteModel model){
      Get.find<CartController>().cartDelete(jsonEncode(model)).then((response) {
        if(response.isSuccess){
          Get.find<CartController>().getCartList().then((response) {
            print("Cart Get Response : "+response.toString());
            if(response.isSuccess){
              PageLoader(context).stopLoading();
              setState(() {
                cartList = Get.find<CartController>().cartList;
              });
            }
          });
        }
      });
    }

    bool findAnyCheckedItem(List<Cart> temp ){
      bool res = false;
      for(final item in temp){
        if(item.itemData!.isChecked!){
          res = true;
        }
      }

      return res;
    }

    Cart getCheckedItem(List<Cart> temp){

      Cart cart = Cart();

      for(final item in temp){
        if(item.itemData!.isChecked!){
          cart = item;
        }
      }

      return cart;
    }

    //Old Body
    Widget _oldBuildBody(CartController cartController){

      cartList = cartController.cartList;

      int calculateTotalPrice(List<Cart> cartList1){
        int result = 0;
        for(final item in cartList1){
          result += item.itemData!.subTotal!;
        }
        return result;
      }

      return Container(
        color: AppColors.pageBg,
        child: SingleChildScrollView(
          child: Column(
              children: [
                //HeaderBox
                Container(
                  height: Dimensions.height50,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                  margin: EdgeInsets.only(
                      left: Dimensions.width15,
                      right: Dimensions.width15,
                      top: 0,
                      bottom: Dimensions.height10/2
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Home',
                        style: TextStyle(
                            fontSize: Dimensions.font14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.black,
                      ),
                      Text(
                        'Checkout',
                        style: TextStyle(
                            fontSize: Dimensions.font14,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
                //Product List
                Container(
                  height: cartList.length*((Dimensions.height100+Dimensions.height20)*3) + Dimensions.height30*6,
                  margin: EdgeInsets.only(
                      left: Dimensions.width15,
                      right: Dimensions.width15,
                      top: 0,
                      bottom: Dimensions.height10/2
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius15/3)
                  ),
                  child: Column(
                    children: [
                      //Table header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                        child: Divider(
                          height: Dimensions.height20,
                          thickness: Dimensions.width15/10,
                          color: AppColors.newBorderColor,
                        ),
                      ),
                      //Table header
                      Container(
                        height: Dimensions.height50,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width15,
                            vertical: Dimensions.height15
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: checkAll,
                              onChanged: (value) {
                                setState(() {
                                  checkAll = value!;
                                  for(final item in cartList){
                                    item.itemData!.isChecked = value;
                                  }
                                });
                              },
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                            ),
                            GestureDetector(
                              onTap: (){
                                if(checkAll){
                                  List<String> ids = [];
                                  for(final item in cartList){
                                    ids.add(item.id!);
                                  }
                                  DeleteModel deleteModel = DeleteModel(id: ids);
                                  PageLoader(context).startLoading();
                                  cartDelete(deleteModel);
                                }else{
                                  List<String> ids = [];
                                  if(findAnyCheckedItem(cartList)){
                                    for(final item in cartList){
                                      if(item.itemData!.isChecked!){
                                        ids.add(item.id!);
                                      }
                                    }
                                    DeleteModel deleteModel = DeleteModel(id: ids);
                                    PageLoader(context).startLoading();
                                    cartDelete(deleteModel);
                                  }else{
                                    showCustomSnakebar('No item checked!');
                                  }
                                }

                              },
                              child: const Text(
                                'Remove',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.height10),
                            const Text(
                              'Product',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(width: Dimensions.width50),
                            const Text(
                              'Total',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                        child: Divider(
                          height: 1,
                          thickness: Dimensions.width15/10,
                          color: AppColors.newBorderColor,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      //Cart List View
                      Container(
                        height: cartList.length*(Dimensions.height100+Dimensions.height20)*3,
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                },
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      //Data
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Checkbox
                                          SizedBox(
                                            width: width/3-110,
                                            child: Checkbox(
                                              value: cartList[index].itemData!.isChecked,
                                              activeColor: Colors.green,
                                              onChanged: (value) {
                                                setState(() {
                                                  checkAll = false;
                                                  cartList[index].itemData!.isChecked = value!;
                                                });
                                              },
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10/2),
                                          //Image
                                          Image.network(
                                            cartList[index].itemData!.image!,
                                            height: Dimensions.height50,
                                            width: width/8,
                                          ),
                                          SizedBox(width: Dimensions.width10/2),
                                          //Name + Color + Size + Price + add/remove
                                          SizedBox(
                                            width: width/2-Dimensions.width10*5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                //Name
                                                Text(
                                                  cartList[index].title ?? 'Product Name',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                                SizedBox(height: Dimensions.height15),
                                                //Color
                                                Text(
                                                    "Color : Black"
                                                ),
                                                SizedBox(height: Dimensions.height10/2),
                                                //Size
                                                Text(
                                                    "Size : Large"
                                                ),
                                                SizedBox(height: Dimensions.height10/2),
                                                //Price
                                                Text(
                                                    "Price : ${cartList[index].itemData!.price!}"
                                                ),
                                                // +/
                                                Container(
                                                  height: Dimensions.height50,
                                                  alignment: Alignment.centerLeft,
                                                  //width: Dimensions.width50*2-Dimensions.width10,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){
                                                          if(cartList[index].itemData!.quantity! > 1){
                                                            //Cart post
                                                            Cart cart = cartList[index];
                                                            MetaDatas data = cart.itemData!;
                                                            print("Prev Qty : ${data.quantity!}");
                                                            data.quantity = data.quantity!-1;
                                                            print("Change Qty : ${data.quantity!}");
                                                            print("Prev SubTotal : ${data.subTotal!}");
                                                            data.subTotal = (data.quantity!)*(data.price!);
                                                            print("Change SubTotal : ${data.subTotal!}");
                                                            PageLoader(context).startLoading();
                                                            cartPost(
                                                                cart.id!,
                                                                0,
                                                                0,
                                                                cart.title!,
                                                                jsonEncode(data),
                                                                0,
                                                                cart.localDelivery!,
                                                                cart.shippingRate!,
                                                                cart.batchLotQuantity!,
                                                                cart.nextLotQuantity!,
                                                                cart.actualWeight,
                                                                cart.firstLotQuantity!
                                                            );
                                                          }else{
                                                            showCustomSnakebar('Item quantity can\'t be less than 1.',title: "Quantity Error!" );
                                                          }
                                                        },
                                                        child: Container(
                                                          width: Dimensions.width30,
                                                          height: Dimensions.height30,
                                                          color: AppColors.primaryColor,
                                                          child: const Icon(Icons.remove,color: Colors.white),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: Dimensions.height30,
                                                        width: Dimensions.width10*4,
                                                        decoration: const BoxDecoration(
                                                          border: Border(
                                                            top: BorderSide(width: 1, color: AppColors.newBorderColor),
                                                            bottom: BorderSide(width: 1, color: AppColors.newBorderColor),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            cartList[index].itemData!.quantity!.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: const TextStyle(
                                                                color: Colors.black
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          Cart cart = cartList[index];
                                                          MetaDatas data = cart.itemData!;
                                                          data.quantity = data.quantity!+1;
                                                          data.subTotal = (data.quantity!)*(data.price!);
                                                          PageLoader(context).startLoading();
                                                          cartPost(
                                                            cart.id!,
                                                            0,
                                                            0,
                                                            cart.title!,
                                                            jsonEncode(data),
                                                            0,
                                                            cart.localDelivery!,
                                                            cart.shippingRate!,
                                                            cart.batchLotQuantity!,
                                                            cart.nextLotQuantity!,
                                                            cart.actualWeight,
                                                            cart.firstLotQuantity!
                                                          );
                                                        },
                                                        child: Container(
                                                          width: Dimensions.width30,
                                                          height: Dimensions.height30,
                                                          color: AppColors.primaryColor,
                                                          child: const Icon(Icons.add,color: Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.height20),
                                                Text(
                                                    'Max Quantity: ${ cartList[index].itemData!.maxQuantity!}'
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          SizedBox(
                                            width: width/8,
                                            child: Text(
                                              ((((cartList[index].itemData!.price!).round())*cartList[index].itemData!.quantity!)).toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      Divider(
                                        height: Dimensions.height10*2,
                                        color: AppColors.newBorderColor,
                                        thickness: Dimensions.width10/5,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      //Total
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: Dimensions.height30),
                            Text(
                              '৳ ${calculateTotalPrice(cartList)}',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                        child: Divider(
                          height: 1,
                          thickness: Dimensions.width15/10,
                          color: AppColors.newBorderColor,
                        ),
                      ),
                      //China shipping
                      Container(
                        padding: EdgeInsets.symmetric(vertical: Dimensions.height8,horizontal: Dimensions.width15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'China Local Shipping',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: Dimensions.width30),
                            Text(
                              '৳ 0',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                //Shipping address & others + Checkout info + Footer
                Container(
                  height: Dimensions.height200*8+Dimensions.height10,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width15,
                      vertical: Dimensions.height15
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping Address',
                            style: TextStyle(
                                fontSize: Dimensions.font16,
                                color: Colors.black
                            ),
                          ),
                          Text(
                            'Manage',
                            style: TextStyle(
                                fontSize: Dimensions.font14,
                                color: AppColors.primaryColor
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height20),
                      //Shipping Address
                      GetBuilder<OrderController>(builder: (oc){
                        return oc.isAddressLoaded ? Container(
                            height: Dimensions.height20*3+Dimensions.height15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                              border: Border.all(
                                  color: AppColors.primaryColor
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width10,
                                      vertical: Dimensions.height10/5
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name:',
                                        style: TextStyle(
                                            fontSize: Dimensions.font16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        '${oc.userAddressList[0].name}',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width10,
                                      vertical: Dimensions.height10/5
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone:',
                                        style: TextStyle(
                                            fontSize: Dimensions.font16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        '${oc.userAddressList[0].phoneOne}',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width10,
                                      vertical: Dimensions.height10/5
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Address:',
                                        style: TextStyle(
                                            fontSize: Dimensions.font16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        '${oc.userAddressList[0].address}',
                                        style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ) : Container(
                          height: Dimensions.height20*3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                            border: Border.all(
                                color: AppColors.primaryColor
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Add Shipping Address',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: Dimensions.font14,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: Dimensions.height20),
                      //Apply coupon text
                      Text(
                        'Apply Coupon',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.w400
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: Dimensions.height20),
                      //Coupon
                      Container(
                        height: Dimensions.height48,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                            border: Border.all(
                                color: AppColors.primaryColor
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width-134,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    //borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width10,
                                      vertical: Dimensions.height10
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Coupon',
                                  hintMaxLines: 1,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print('coupon');
                              },
                              child: Container(
                                width: 100,
                                height: Dimensions.height48,
                                padding: EdgeInsets.only(
                                  left: Dimensions.width15,
                                  top: 1,
                                  bottom: 1,
                                  right: Dimensions.width15,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Dimensions.font16
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.height15),
                      //Order Summery
                      SizedBox(
                        height: Dimensions.height20*4,
                        child: Text(
                          'Order Summary',
                          style: TextStyle(
                              fontSize: Dimensions.font16,
                              color: Colors.black
                          ),
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: Dimensions.width15/10,
                        color: AppColors.newBorderColor,
                      ),
                      //Product Price
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Products Price',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              '৳ ${calculateTotalPrice(cartList)}',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: Dimensions.width15/10,
                        color: AppColors.newBorderColor,
                      ),
                      //Need to pay 50%
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Need to Pay 50%',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              '৳ ${(calculateTotalPrice(cartList)/2).round()}',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: Dimensions.width15/10,
                        color: AppColors.newBorderColor,
                      ),
                      //Due
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Due',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              '৳ ${(calculateTotalPrice(cartList)/2).round()}',
                              style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: Dimensions.width15/10,
                        color: AppColors.newBorderColor,
                      ),
                      //Disclaimer
                      SizedBox(height: Dimensions.height20),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width15,
                          vertical: Dimensions.height15
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            border: Border.all(
                              color: Colors.black,
                            )
                        ),
                        child: Text(
                          '** পণ্য আসার পর শিপিং মেথড অনুযায়ী বাম পাশে উল্লেখিত প্রতি কেজি হিসেবে শিপিং ও কাস্টমস চার্জ যোগ হবে',
                          style: TextStyle(
                              fontSize: Dimensions.font14,
                              color: Colors.red,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      Divider(
                        height: 1,
                        thickness: Dimensions.width10/2,
                        color: AppColors.primaryColor,
                      ),
                      //Footer
                      const Footer()
                    ],
                  ),
                ),

              ]
          ),
        ),
      );
    }

    Widget _buildBottomNav(BuildContext context,bool isUserLoggedIn){
      return GestureDetector(
        onTap: (){
          if(isUserLoggedIn){
            if(checkAll){
              Get.toNamed(RouteHelper.getPaymentPage(jsonEncode(cartList)));
            }else if(findAnyCheckedItem(cartList)){
              Get.toNamed(RouteHelper.getPaymentPage(jsonEncode(cartList)));
            }else{
              showCustomSnakebar('Please select item first!',title: 'Info',color: Colors.yellow[900]!);
            }
          }else{
            showCustomSnakebar('You are not logged in!',title: "Authentication Error!");

            //Get.toNamed(RouteHelper.getSignInPage());
          }

        },
        child: Container(
          height: Dimensions.height50,
          width: double.infinity,
          //margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(1),
                topLeft: Radius.circular(1),
                bottomRight: Radius.circular(1),
                bottomLeft: Radius.circular(1),
              )
          ),
          child: Center(
            child: Text(
              Constants.PROCEED,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: Dimensions.font18
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          body: GetBuilder<CartController>(builder: (cartController){
            return cartController.isCartListLoaded ? _oldBuildBody(cartController) : const Center(child: CircularProgressIndicator());
          }),
          bottomNavigationBar: _buildBottomNav(context,isUserLoggedIn),
        ),
        onWillPop: () async{
          Get.toNamed(RouteHelper.getInitial());
          return false;
        },
      ),
    );
  }



}


