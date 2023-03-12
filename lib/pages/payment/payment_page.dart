import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skybuybd/base/footer.dart';
import 'package:skybuybd/pages/cart/cart_page.dart';

import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';
import '../../models/cart_model.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import 'package:get/get.dart';
import '../home/widgets/dimond_bottom_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PaymentPage extends StatefulWidget {
  final String cartListJson;
  const PaymentPage({Key? key,required this.cartListJson}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  late bool isUserLoggedIn;
  String? gateway;
  bool terms = false;

  //Image picker
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;

  _imageFromCamera() async {
    _image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (_image != null) {
      setState(() {
        file = File(_image!.path);
      });
      //saveInStorage(file!);
      if(file != null){
        //showCustomSnakebar("Image picked successfully",isError: false,title: "Image",color: AppColors.primaryColor);
        //Get.find<ProductController>().uploadImage(file!);
        Get.toNamed(RouteHelper.getSearchPage("","image",file!.path));
      }else{
        print("File is null");
      }
    }
  }

  _imageFromGallery() async {
    _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        file = File(_image!.path);
      });
      //saveInStorage(file!);
      if(file != null){
        //showCustomSnakebar("Image picked successfully",isError: false,title: "Image",color: AppColors.primaryColor);
        //Get.find<ProductController>().uploadImage(file!);
        Get.toNamed(RouteHelper.getSearchPage("","image",file!.path));
      }else{
        print("File is null");
      }

    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Choose from camera'),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

  List<Cart> cartList = [];

  @override
  void initState() {
    super.initState();
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    cartList = (jsonDecode(widget.cartListJson) as List<dynamic>).map((dynamic el) => Cart.fromJson(el as Map<String, dynamic>)).toList();

  }

  AppBar _buildAppBar(FocusNode textFieldFocusNode,TextEditingController controller) {
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
          preferredSize: Size.fromHeight(Dimensions.height20*2),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10,
                vertical: Dimensions.height10
            ),
            child: SizedBox(
              height: Dimensions.height45,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(Dimensions.radius20/2),
                  prefixIcon: GestureDetector(
                    onTap: (){
                      _showPicker(context);
                    },
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.btnColorBlueDark,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      //Text Search
                      textFieldFocusNode.unfocus();
                      textFieldFocusNode.canRequestFocus = false;

                      String keyword = controller.text;
                      if(keyword.isEmpty){
                        showCustomSnakebar("Search keyword is empty!",isError: false,title: "Search Error");
                      }else{
                        Get.toNamed(RouteHelper.getSearchPage(keyword,"keyword",""));
                      }

                      //Enable the text field's focus node request after some delay
                      Future.delayed(Duration(milliseconds: 100), () {
                        textFieldFocusNode.canRequestFocus = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius8),
                          bottomRight: Radius.circular(Dimensions.radius8),
                        ),
                        color: AppColors.btnColorBlueDark,
                      ),
                      child: const Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
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
                Get.toNamed(RouteHelper.getInitial());
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
                isUserLoggedIn ? Get.toNamed(RouteHelper.getAccountPage()) : Get.toNamed(RouteHelper.getLoginPage());
              },
            ),
          ],
        ),
      ],
    );
  }

  int calculateTotalPrice(List<Cart> cartList1){
    int result = 0;
    for(final item in cartList1){
      result += item.itemData!.subTotal!;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width-32;
    // Focus nodes are necessary
    final textFieldFocusNode = FocusNode();
    TextEditingController controller = TextEditingController();

    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.pageBg,
          appBar: _buildAppBar(textFieldFocusNode,controller),
          body: _buildBody(width),
        ),
        onWillPop: ()async {
          Navigator.pop(Get.context!);
          return false;
        },
      )
    );
  }

  Widget _buildBody(double width){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Dimensions.height100*10+cartList.length*(Dimensions.height30*6)-Dimensions.height50,
            width: double.maxFinite,
            padding: EdgeInsets.only(
                top: Dimensions.height8,
                bottom: 0,
                left: Dimensions.width15,
                right: Dimensions.width15
            ),
            child: Container(
              height: Dimensions.height100*10+cartList.length*(Dimensions.height30*6)-Dimensions.height50,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Cart Item Table
                  Container(
                    height: Dimensions.height100*2+cartList.length*(Dimensions.height30*6),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Row1
                        Container(
                          height: Dimensions.height50,
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: BigText(
                                    text: 'Product',
                                    size: Dimensions.font16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: BigText(
                                    text: 'Total',
                                    size: Dimensions.font16,
                                  ),
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
                        //Row2
                        Container(
                          height: cartList.length*(Dimensions.height30*6),
                          width: width,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return Divider(height: Dimensions.height10,thickness: 2);
                              },
                              itemCount: cartList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.zero,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            //Product Image
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Image.network(
                                                  cartList[index].itemData!.image!,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.width10/2),
                                            //Product Details
                                            Expanded(
                                                flex: 4,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      cartList[index].title!,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: Dimensions.font14,
                                                          fontWeight: FontWeight.w400
                                                      ),
                                                      textAlign: TextAlign.start,
                                                      maxLines: 5,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: Dimensions.height10),
                                                    //Product color
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Color: ',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        Text(
                                                          'Green',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.normal
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: Dimensions.height10/2),
                                                    //Product size
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Size: ',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        Text(
                                                          '43',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.normal
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: Dimensions.height10/2),
                                                    //Product price
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Price: ',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        Text(
                                                          "৳ ${ cartList[index].itemData!.price}",
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.normal
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: Dimensions.height10/2),
                                                    //Product quantity
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Quantity: ',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        Text(
                                                          '${cartList[index].itemData!.quantity!}',
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.normal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                      //3:1  -->1
                                      //Product Price
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: BigText(
                                            text: '৳ ${cartList[index].itemData!.price!*cartList[index].itemData!.quantity!}',
                                            size: Dimensions.font16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.newBorderColor,
                        ),
                        //Row3
                        //Total price
                        Container(
                          height: Dimensions.height20*2,
                          padding: EdgeInsets.zero,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: Dimensions.width50),
                                  child: Text(
                                    'Total',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: Dimensions.font14,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(right: Dimensions.width15),
                                  alignment: Alignment.centerRight,
                                  child: BigText(
                                    text: '৳ ${calculateTotalPrice(cartList)}',
                                    size: Dimensions.font16,
                                  ),
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
                        //Row4
                        //China Shipping Cost
                        Container(
                          height: Dimensions.height20*2,
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: Dimensions.width50),
                                  child: Text(
                                    'China Local Shipping',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: Dimensions.font14,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: Dimensions.width15),
                                  child: BigText(
                                    text: '৳ 0.0',
                                    size: Dimensions.font16,
                                  ),
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
                      ],
                    ),
                  ),
                  //Order Summery + Payment Summery
                  Container(
                    height: Dimensions.height100*7+Dimensions.height8*4,
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.height10),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width8,
                            vertical: Dimensions.height8
                          ),
                          child: Text(
                            'Order Summery',
                            style: TextStyle(
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),
                        ),
                        const Divider(
                          color: AppColors.newBorderColor,
                          thickness: 1,
                        ),
                        //Order Summery Table
                        Container(
                          height: Dimensions.height20*8,
                          width: width,
                          child: Center(child: _OrderSummeryTable(cartList)),
                        ),
                        //Payment Summary
                        Container(
                          height: Dimensions.height100*5,
                          //color: Colors.green,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width15,
                            vertical: Dimensions.height15
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Summary',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.font18
                                ),
                              ),
                              SizedBox(height: Dimensions.height10),
                              Text(
                                'পণ্য আসার পর পণ্য মূল্যের বকেয়ার সাথে উপরে উল্লেখিত প্রতি কেজি রেট হিসেবে শিপিং চার্জ ও ডেলিভেরী চার্জ (প্রযোজ্য ক্ষেত্রে) যোগ হবে',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: Dimensions.font14,
                                    fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: Dimensions.height20),
                              //Radio buttons
                              Container(
                                padding: EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      title: Image.network(
                                        'https://www.skybuybd.com/img/frontend/payment/bkash.png',
                                        height: Dimensions.height20*2,
                                      ),
                                      value: "bkash",
                                      groupValue: gateway,
                                      onChanged: (value){
                                        setState(() {
                                          gateway = value.toString();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Image.network(
                                        'https://www.skybuybd.com/img/frontend/payment/nagad.png',
                                        height: Dimensions.height20*2,
                                      ),
                                      value: "nogod",
                                      groupValue: gateway,
                                      onChanged: (value){
                                        setState(() {
                                          gateway = value.toString();
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              //Info
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our ",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: Dimensions.font14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "privacy policy ",
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => print("Privacy Policy"),
                                    ),

                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: Dimensions.height20),
                              //Terms
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: SizedBox(
                                        height: Dimensions.height20,
                                        width: Dimensions.width20,
                                        child: Checkbox(
                                          value: terms,
                                          activeColor: Colors.green,
                                          checkColor: Colors.white,
                                          fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              terms = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " I have read and agree to the website ",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: Dimensions.font14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Terms and Conditions ",
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: Dimensions.font14,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => print("Privacy Policy"),
                                    ),
                                    TextSpan(
                                      text: ", ",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: Dimensions.font14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Prohibited Items",
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: Dimensions.font14,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => print("Prohibited Items"),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: Dimensions.font14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Return & Refund Policy",
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: Dimensions.font14,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => print("Return & Refund Polic"),
                                    ),

                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: Dimensions.height20),
                              //Pay now button
                              Container(
                                height: Dimensions.height50,
                                width: width,
                                padding: EdgeInsets.zero,
                                child: TextButton(
                                    onPressed: (){
                                      print("Gateway : $gateway");
                                      print("Terms : $terms");
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height8)),
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                            //side: BorderSide(color: Colors.red)
                                          ),
                                        )
                                    ),
                                    child: Text(
                                      'Pay Now',
                                      style: TextStyle(
                                          fontSize: Dimensions.font16,
                                          letterSpacing: 0,
                                          color: Colors.white
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Footer()
        ],
      ),
    );
  }

  Widget _OrderSummeryTable(List<Cart> cartList){
    return DataTable(
      sortAscending: false,
      dataRowHeight: Dimensions.height20*2,
      headingRowHeight: Dimensions.height20*2,
      headingRowColor: MaterialStateProperty.all(AppColors.primaryColor),
      columnSpacing: 0,
      horizontalMargin: 0,
      showBottomBorder: true,
      border: const TableBorder(
        right:  BorderSide(width: 1.0, color: AppColors.newBorderColor),
        left:  BorderSide(width: 1.0, color: AppColors.newBorderColor),
      ),
      columns: <DataColumn>[
        DataColumn(
          label: SizedBox(
            width: MediaQuery.of(context).size.width/2-50,
            child: const Text(
              'Quantity',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.normal,color: Colors.white),
            ),
          ),
        ),
        DataColumn(
          label:  SizedBox(
            width: MediaQuery.of(context).size.width/2-50,
            child: const Text(
              'Total',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.normal,color: Colors.white),
            ),
          ),
        ),
      ],
      rows:  <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width/2-50,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: const Text(
                  'Product Price',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      //color: Colors.black
                  ),
                ),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width/2-50,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width8),
                child: Text(
                  '৳ ${calculateTotalPrice(cartList)}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      //color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width/2-50,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width8),
                child: const Text(
                  'Need to Pay 50%',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width/2-50,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width8),
                child: Text(
                  '৳ ${(calculateTotalPrice(cartList)/2).round()}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width/2-50,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width8),
                child: const Text(
                  'Due(only for products)',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width/2-50,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width8),
                child: Text(
                  '৳ ${(calculateTotalPrice(cartList)/2).round()}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget table123(){
    //Table Header + Table
    return Container(
        height: 325,
        padding: EdgeInsets.only(top: 16,left: 8,right: 8),
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: Column(
          children: [
            //1st row
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                //padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                padding: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.newBorderColor
                    )
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            //width: width/8*4.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Text(
                                    'Product',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: AppColors.newBorderColor,
                                  height: 20,
                                  thickness: 1,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.network(
                                          'https://cbu01.alicdn.com/img/ibank/O1CN01iiLtKl1ygVwOYYQ0u_!!2208993426608-0-cib.jpg',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          children: [
                                            Text(
                                                'New men\'s shoes】Korean version of boys breathable casual sports running shoes one generation'
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  'Color: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                Text(
                                                  'Green',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  'Size: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                Text(
                                                  '43',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  'Price: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                Text(
                                                  '৳ 283',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  'Quantity: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                Text(
                                                  '3',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: AppColors.newBorderColor,
                                  height: 20,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0,bottom: 3),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Divider(
                                  color: AppColors.newBorderColor,
                                  height: 20,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0,bottom: 3),
                                  child: Text(
                                    'Chaina Local Shipping',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: VerticalDivider(
                            width: 1,
                            color: AppColors.newBorderColor,
                            thickness: 1,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            //padding: EdgeInsets.only(left: 8,right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14
                                  ),
                                ),
                                Divider(
                                  color: AppColors.newBorderColor,
                                  height: 20,
                                  thickness: 1,
                                ),
                                SizedBox(height: 73),
                                Text(
                                  '৳ 2283',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14
                                  ),
                                ),
                                SizedBox(height: 73),
                                Divider(
                                  color: AppColors.newBorderColor,
                                  height: 20,
                                  thickness: 1,
                                ),
                                Text(
                                  '৳ 2283',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                Divider(
                                  color: AppColors.newBorderColor,
                                  height: 20,
                                  thickness: 1,
                                ),
                                Text(
                                  '৳ 0',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ),
            ),
          ],
        ),
      );
  }

}
