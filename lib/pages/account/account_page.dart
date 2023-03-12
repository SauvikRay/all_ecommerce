import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybuybd/base/footer.dart';
import 'package:skybuybd/base/show_custom_snakebar.dart';
import 'package:skybuybd/controller/home_controller.dart';
import 'package:skybuybd/controller/order_controller.dart';
import 'package:skybuybd/models/user_address_model.dart';
import 'package:skybuybd/widgets/big_text.dart';
import '../../controller/auth_controller.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/app_icon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:skybuybd/models/order_model.dart';
import 'package:skybuybd/models/invoice_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  int selectedIndex = 1;
  int selectedAccountIndex = 1;
  int orderSelectedIndex = 1;
  int deliveryMenuListIndex = 1;

  late bool isUserLoggedIn;
  late double width;

  String? avatar = 'gravatar';

  //UpdateInfo
  TextEditingController uiFirstNameController = TextEditingController();
  TextEditingController uiLastNameController = TextEditingController();
  TextEditingController uiEmailController = TextEditingController();

  //Change Password
  TextEditingController cpOldPassController = TextEditingController();
  TextEditingController cpNewPassController = TextEditingController();
  TextEditingController cpConfirmPassController = TextEditingController();

  ///Image picker
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

  @override
  void initState() {
    super.initState();

    SharedPreferences preferences = Get.find<HomeController>().getSharedPref();
    if(preferences.containsKey(Constants.USER_FIRST_NAME)){
      uiFirstNameController.text = preferences.getString(Constants.USER_FIRST_NAME)!;
    }else{
      uiFirstNameController.text = '';
    }

    if(preferences.containsKey(Constants.USER_LAST_NAME)){
      uiLastNameController.text = preferences.getString(Constants.USER_LAST_NAME)!;
    }else{
      uiLastNameController.text = '';
    }

    if(preferences.containsKey(Constants.USER_EMAIL)){
      uiEmailController.text = preferences.getString(Constants.USER_EMAIL)!;
    }else{
      uiEmailController.text = '';
    }



    //_logout();
    //Get.find<OrderController>().getCustomerOrderList();
    //Get.find<OrderController>().getCustomerOrderInvoiceList();
    //Get.find<OrderController>().getCustomerAddressList();
  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();

    final textFieldFocusNode = FocusNode();
    TextEditingController controller = TextEditingController();

    List<GridItem> gridItems = [
      GridItem(1, 'Dashboard', Icons.home_rounded),
      GridItem(2, 'Orders', Icons.shopping_bag_outlined),
      GridItem(3, 'Item Details', Icons.details_outlined),
      GridItem(4, 'My Invoice', Icons.grid_3x3_sharp),
      GridItem(5, 'My Address', Icons.location_on),
      GridItem(6, 'Account Details', Icons.person),
      //GridItem(7, 'Settings', Icons.settings),
      //GridItem(8, 'Logout', Icons.logout)
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: _buildAppBar(textFieldFocusNode,controller),
      body: isUserLoggedIn ? Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10/5),
              //Menu List
              Container(
                height: Dimensions.height200-Dimensions.height30,
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.only(top: Dimensions.height15),
                child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 4/1,
                    padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,

                    children: gridItems.map((data) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedIndex = data.id;
                          });

                          if(selectedIndex == 2){
                            Get.find<OrderController>().getCustomerOrderList();
                          }else if(selectedIndex == 3){
                            Get.find<OrderController>().getCustomerOrderInvoiceList();
                          }else if(selectedIndex == 4){
                            Get.find<OrderController>().getCustomerAddressList();
                          }

                          if(selectedIndex == 8){
                            _logout();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: data.icon != null ? AppColors.borderColor.withOpacity(0.3) : Colors.white
                              ),
                              bottom: BorderSide(
                                color: data.icon != null ? AppColors.borderColor.withOpacity(0.3) : Colors.white
                              ),
                            ),
                            color: selectedIndex == (data.id)  ? AppColors.borderColor : Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.width8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[ //SizedBox
                              data.icon == null ? Container() : Icon(data.icon!),
                              SizedBox(width: Dimensions.width15),
                              data.icon == null ? Container() : Expanded(
                                child: Text(
                                  data.menuTitle!,
                                  style: TextStyle(
                                      fontSize: Dimensions.font14,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ) //Text
                              //Checkbox
                            ], //<Widget>[]
                          ),
                        ),
                      );
                    }).toList()),
              ),
              SizedBox(height: Dimensions.height10/2),
              if(selectedIndex == 1)...[
                _buildNewDashboardContainer(context)
              ]else if(selectedIndex == 2)...[
                _buildOrderContainer()
              ]else if(selectedIndex == 3)...[
                _buildItemDetailsContainer()
              ]else if(selectedIndex == 4)...[
                _buildInvoiceContainer()
              ]else if(selectedIndex == 5)...[
                _buildAddressContainer()
              ]else if(selectedIndex == 6)...[
                _buildAccountDetailContainer()
              ]else...[
                Container()
              ],
              Divider(
                height: 1,
                thickness: Dimensions.height10,
                color: AppColors.primaryColor,
              ),
              const Footer(),
            ],
          ),
        ),
      ) : _buildBodyNonUser(width),
    );
  }

  Widget _buildAccountDetailContainer(){
    return Container(
      //Need to set dynamic height
      height: selectedAccountIndex == 1 ? Dimensions.height100*4+Dimensions.height45 : (selectedAccountIndex == 2 ? Dimensions.height100*7 : Dimensions.height100*4+Dimensions.height50+Dimensions.height10),
      color: Colors.white,
      margin: EdgeInsets.only(left: Dimensions.width15,right: Dimensions.width15,top: Dimensions.height15,bottom: Dimensions.height15*2),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: Dimensions.width15,right: Dimensions.width15,top: Dimensions.height15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Account',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.font16
                  ),
                  textAlign: TextAlign.start,
                ),
                Divider(
                  height: Dimensions.height10,
                  color: AppColors.borderColor,
                  thickness: 2,
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedAccountIndex = 1;
                          });
                        },
                        child: Container(
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              color: selectedAccountIndex == 1 ? AppColors.primaryColor : Colors.black,
                              fontSize: Dimensions.font16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedAccountIndex = 2;
                          });
                        },
                        child: Container(
                          child: Text(
                            'Update Information',
                            style: TextStyle(
                              color: selectedAccountIndex == 2 ? AppColors.primaryColor : Colors.black,
                              fontSize: Dimensions.font16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedAccountIndex = 3;
                          });
                        },
                        child: Container(
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                              color: selectedAccountIndex == 3 ? AppColors.primaryColor : Colors.black,
                              fontSize: Dimensions.font16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: Dimensions.height10,
                  color: AppColors.btnColorBlueDark,
                  thickness: 1.5,
                ),
                SizedBox(height: Dimensions.height10),
                if(selectedAccountIndex == 1)...[
                  _buildProfileContainer()
                ]else if(selectedAccountIndex == 2)...[
                  _buildUpdateInfoContainer()
                ]else if(selectedAccountIndex == 3)...[
                  _buildChangePassContainer()
                ]else...[
                  Container()
                ],

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContainer(){

    SharedPreferences preferences = Get.find<HomeController>().getSharedPref();

    return Container(
      height: Dimensions.height100*3+Dimensions.height20,
      child: Column(
        children: [
          //Avatar
          Container(
            color: const Color(0xFFF0F0F0),
            padding: EdgeInsets.only(
              left: Dimensions.width15,
              right: Dimensions.width15,
              top: Dimensions.height15,
              bottom: Dimensions.height15,
            ),
            child: Row(
              children: [
                Text(
                  'Avatar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font14,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  width: Dimensions.width30,
                ),
                CachedNetworkImage(
                  imageUrl: 'https://www.gravatar.com/avatar/c635dbfe0d08f520cb7a1d84cc1540ee.jpg?s=80&d=mm&r=g',
                  height: Dimensions.height100,
                  width: Dimensions.width50*2,
                  placeholder: (context, url) => Container(
                    color:  Colors.transparent,
                    height: Dimensions.height50,
                    width: Dimensions.width50,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),
          //Name
          Container(
            height: Dimensions.height20*2,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width : Dimensions.width20*5,
                  padding: EdgeInsets.only(left: Dimensions.width15),
                  child: Text(
                    'Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width20),
                const VerticalDivider(
                  color: Color(0xFFF0F0F0),
                  width: 2,
                  thickness: 2,
                ),
                SizedBox(width: Dimensions.width20),
                Text(
                  preferences.getString(Constants.USER_NAME) ?? '',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font14,
                  ),
                ),
              ],
            ),
          ),
          //Email
          Container(
            height: Dimensions.height20*2,
            color: const Color(0xFFF0F0F0),
            child: Row(
              children: [
                Container(
                  width : Dimensions.width20*5,
                  padding: EdgeInsets.only(left: Dimensions.width15),
                  child: Text(
                    'E-mail',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width20),
                const VerticalDivider(
                  color: Color(0xFFF0F0F0),
                  width: 2,
                  thickness: 2,
                ),
                SizedBox(width: Dimensions.width20),
                Text(
                  preferences.getString(Constants.USER_EMAIL) ?? '',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font14,
                  ),
                ),
              ],
            ),
          ),
          //Created at
          Container(
            height: Dimensions.height20*2,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: Dimensions.width20*5,
                  padding: EdgeInsets.only(left: Dimensions.width15),
                  child: Text(
                    'Created At',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width20),
                const VerticalDivider(
                  color: Color(0xFFF0F0F0),
                  width: 2,
                  thickness: 2,
                ),
                SizedBox(width: Dimensions.width20),
                Text(
                  preferences.getString(Constants.USER_CREATED_AT) ?? '',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font14,
                  ),
                ),
              ],
            ),
          ),
          //Updated at
          Container(
            height: Dimensions.height20*2,
            color: const Color(0xFFF0F0F0),
            child: Row(
              children: [
                Container(
                  width : Dimensions.width20*5,
                  padding: EdgeInsets.only(left: Dimensions.width15),
                  child: const Text(
                    'Last Updated',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width20),
                const VerticalDivider(
                  color: Color(0xFFF0F0F0),
                  width: 2,
                  thickness: 2,
                ),
                SizedBox(width: Dimensions.width20),
                Text(
                  preferences.getString(Constants.USER_LAST_UPDATED) ?? '',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateInfoContainer(){

    return Container(
      margin: EdgeInsets.only(top: Dimensions.height10),
      height: Dimensions.height100*5+Dimensions.height45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Avatar Location
          Text(
            'Avatar Location',
            style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400
            ),
          ),
          //SizedBox(height: Dimensions.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: RadioListTile(
                  title: const Text("Gravatar"),
                  value: "gravatar",
                  groupValue: avatar,
                  onChanged: (value){
                    setState(() {
                      avatar = value.toString();
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile(
                  title: const Text("Upload"),
                  value: "upload",
                  groupValue: avatar,
                  onChanged: (value){
                    setState(() {
                      avatar = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          avatar == "upload" ? SizedBox(
            width: Dimensions.width20*6,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: AppColors.btnColorBlueDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                ),
                elevation: 1.0,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10
                ),
                child: Text(
                  'Upload',
                  style: TextStyle(fontSize: Dimensions.font14,color: Colors.white),
                ),
              ),
            ),
          ) : Container(),
          SizedBox(height: Dimensions.height10/2),
          //First Name
          Text(
            'First Name',
            style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: Dimensions.height10/2),
          Container(
            height: Dimensions.height48,
            color: Colors.white,
            child: TextField(
              controller: uiFirstNameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius8/2),
                  borderSide: const BorderSide(
                      color: AppColors.primaryDarkColor,
                      width: 1.0
                  ),
                ),
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                filled: true,
                fillColor: Colors.white,
                hintText: 'First Name',
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600
                ),
                hintMaxLines: 1,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10/2),
          //Last Name
          Text(
            'Last Name',
            style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: Dimensions.height10/2),
          Container(
            height: Dimensions.height48,
            color: Colors.white,
            child: TextField(
              controller: uiLastNameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius8/2),
                  borderSide: const BorderSide(
                      color: AppColors.primaryDarkColor,
                      width: 1.0
                  ),
                ),
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Last Name',
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600
                ),
                hintMaxLines: 1,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          Container(
            alignment: Alignment.center,
            height: Dimensions.height20*3,
            padding: EdgeInsets.all(Dimensions.height10),
            decoration: BoxDecoration(
              color: const Color(0xFFe2f0fb),
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius8/2)),
              border: Border.all(
                color: const Color(0xFFd6e9f9),
                width: 1.5
              ),
            ),
            child: Text(
              'If you change your e-mail you will be logged out until you confirm your new e-mail address.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF385d7a),
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.font14
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          //Email
          Text(
            'E-mail Address',
            style: TextStyle(
                color: Color(0xFF333333),
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: Dimensions.height10/2),
          Container(
            height: Dimensions.height48,
            color: Colors.white,
            child: TextField(
              controller: uiEmailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius8/2),
                  borderSide: const BorderSide(
                      color: AppColors.primaryDarkColor,
                      width: 1.0
                  ),
                ),
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.all(Dimensions.height10),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Last Name',
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600
                ),
                hintMaxLines: 1,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          Container(
            alignment: Alignment.center,
            width: Dimensions.width20*6,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                ),
                elevation: 1.0,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10
                ),
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: Dimensions.font16,color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChangePassContainer(){
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height10),
      height: Dimensions.height100*3+Dimensions.height20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Old Password
          Text(
            'Old Password',
            style: TextStyle(
                color: Color(0xFF333333),
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: Dimensions.height10/2),
          Container(
            height: Dimensions.height48,
            color: Colors.white,
            child: TextField(
              controller: cpOldPassController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                  borderSide: const BorderSide(
                      color: AppColors.primaryDarkColor,
                      width: 1.0
                  ),
                ),
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Old Password',
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600
                ),
                hintMaxLines: 1,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10/2),
          //Password
          Text(
            'Password',
            style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: Dimensions.height10/2),
          Container(
            height: Dimensions.height48,
            color: Colors.white,
            child: TextField(
              controller: cpNewPassController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius8/2),
                  borderSide: const BorderSide(
                      color: AppColors.primaryDarkColor,
                      width: 1.0
                  ),
                ),
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600
                ),
                hintMaxLines: 1,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10/2),
          //Password Confirmation
          Text(
            'Password Confirmation',
            style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: Dimensions.height10/2),
          Container(
            height: Dimensions.height48,
            color: Colors.white,
            child: TextField(
              controller: cpConfirmPassController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius8/2),
                  borderSide: const BorderSide(
                      color: AppColors.primaryDarkColor,
                      width: 1.0
                  ),
                ),
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.all(Dimensions.height10),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password Confirmation',
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600
                ),
                hintMaxLines: 1,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          SizedBox(
            width: Dimensions.width30*6+Dimensions.width10,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                ),
                elevation: 1.0,
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10
                ),
                child: Text(
                  'Update Password',
                  style: TextStyle(fontSize: Dimensions.font16,color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
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
          preferredSize: Size.fromHeight(Dimensions.height10*4),
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


}

void _editAddress(UserAddress userAddress) {
  Alert(
      context: Get.context!,
      title: "Edit Address",
      style: const AlertStyle(
        animationType: AnimationType.fromBottom,
        overlayColor: Colors.black26,
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
        ),
      ),
      content: Column(
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
              labelText: 'Customer Name',
            ),
            //controller: ecName,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Phone 1',
            ),
            //controller: ecPhone1,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Phone2',
            ),
            //controller: ecPhone2,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            //controller: ecAddress,
          ),
        ],
      ),
      buttons: [

        DialogButton(
          onPressed: (){
            //String name = ecName.text;
            //String phone1 = ecPhone1.text;
            //String phone2 = ecPhone2.text;
            //String address = ecAddress.text;
            /*if(name.isNotEmpty){
                if(designation.isNotEmpty){
                  if(phone.isNotEmpty){
                    if(isSalesMan.isNotEmpty){
                      _updateInDb(item);
                    }else{
                      showToast('Is salesman is empty!');
                    }
                  }else{
                    showToast('Phone is empty!');
                  }
                }else{
                  showToast('Designation is empty!');
                }
              }else{
                showToast('Employee name is empty!');
              }*/
          },
          color: Colors.blue,
          child: Text(
            "Update",
            style: TextStyle(color: Colors.white, fontSize: Dimensions.font16),
          ),
        ),
      ]).show();
}

Widget _buildBodyNonUser(double width){
  return Container(
    width: width,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: width,
            height: 330,
            color: Colors.white,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                Lottie.asset(
                    'assets/lotti/logout.json',
                  height: 200,
                  width: width
                ),
                const Text(
                  'Oops! You are not sign in',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'times new roman'
                  ),
                ),
                Container(
                  height: 48,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        Get.offNamed(RouteHelper.getLoginPage());
                      },
                      child: const Text(
                        'Sign In Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          Footer()
        ],
      ),
    ),
  );
}


Widget _buildNewDashboardContainer(BuildContext context){
  return Container(
      color: Colors.white,
      width: double.maxFinite,
      height: Dimensions.height20*6,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(
                left: Dimensions.width15,
                right: Dimensions.width15,
                top: Dimensions.height15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.font16
                  ),
                  textAlign: TextAlign.start,
                ),
                Divider(
                  height: Dimensions.height10,
                  color: AppColors.borderColor,
                  thickness: 2,
                ),
                const Text(
                    'From your account dashboard. you can easily check & view your recent orders, manage your shipping and billing addresses and edit your password and account details.'
                ),
              ],
            ),
          ),
        ],
      )
  );
}

Widget _buildOrderContainer(){

  return GetBuilder<OrderController>(builder: (orderController){
    return orderController.isOrderListLoaded ? Container(
      //Need to set dynamic height
      height: Dimensions.height100+(Dimensions.height20*4*orderController.orderList.length),
      color: Colors.white,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    top: Dimensions.height15
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Orders',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font16
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Divider(
                      height: Dimensions.height10,
                      color: AppColors.borderColor,
                      thickness: 2,
                    ),
                    SizedBox(height: Dimensions.height10),
                    //Search Field
                    Container(
                      height: Dimensions.height48,
                      color: Colors.white,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.primaryDarkColor,
                                width: 1.0
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search...',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600
                          ),
                          hintMaxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    _buildOrderTable(orderController.orderList),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ) : const Center(child: CircularProgressIndicator());
  });
}

Widget _buildItemDetailsContainer() {
  return GetBuilder<OrderController>(builder: (orderController){
    return orderController.isOrderListLoaded ? Container(
      //Need to set dynamic height
      height: Dimensions.height100+(Dimensions.height20*4*orderController.totalOrderItems.length),
      color: Colors.white,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: Dimensions.width15,right: Dimensions.width15,top: Dimensions.height15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Order Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font16
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Divider(
                      height: Dimensions.height10,
                      color: AppColors.borderColor,
                      thickness: 2,
                    ),
                    SizedBox(height: Dimensions.height10),
                    //Search Field
                    Container(
                      height: Dimensions.height48,
                      color: Colors.white,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                            borderSide: const BorderSide(
                                color: AppColors.primaryDarkColor,
                                width: 1.0
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10,
                            vertical: Dimensions.height10
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search...',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600
                          ),
                          hintMaxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    _buildOrderDetailsTable(orderController.totalOrderItems),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ) : const Center(child: CircularProgressIndicator());
  });
}

Widget _buildInvoiceContainer(){
  return GetBuilder<OrderController>(builder: (orderController){
    return orderController.isInvoiceListLoaded ? Container(
      //Need to set dynamic height
      height: Dimensions.height100+((Dimensions.height100+Dimensions.height20)*orderController.invoiceList.length),
      color: Colors.white,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: Dimensions.width15,right: Dimensions.width15,top: Dimensions.height15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Invoice',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font16
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Divider(
                      height: Dimensions.height10,
                      color: AppColors.borderColor,
                      thickness: 2,
                    ),
                    SizedBox(height: Dimensions.height10),
                    //Search Field
                    Container(
                      height: Dimensions.height48,
                      color: Colors.white,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                            borderSide: const BorderSide(
                                color: AppColors.primaryDarkColor,
                                width: 1.0
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10,
                            vertical: Dimensions.height10
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search...',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600
                          ),
                          hintMaxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    _buildInvoiceTable(orderController.invoiceList),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ) : const Center(child: CircularProgressIndicator());
  });
}

Widget _buildAddressContainer(){

  ///Update Address
  TextEditingController ecName = TextEditingController();
  TextEditingController ecPhone1 = TextEditingController();
  TextEditingController ecPhone2 = TextEditingController();
  TextEditingController ecAddress = TextEditingController();

  return GetBuilder<OrderController>(builder: (orderController){
    return orderController.isAddressLoaded ? Container(
      //Need to set dynamic height
      height: (Dimensions.height200+Dimensions.height20)*orderController.userAddressList.length,
      color: Colors.white,
      margin: EdgeInsets.only(
          left: Dimensions.width15,
          right: Dimensions.width15,
          top: Dimensions.height15,
          bottom: Dimensions.height15*2
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: orderController.userAddressList.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(
                left: Dimensions.width15,
                right: Dimensions.width15,
                top: Dimensions.height15
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address #${index+1}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.font16
                  ),
                  textAlign: TextAlign.start,
                ),
                Divider(
                  height: Dimensions.height10,
                  color: AppColors.borderColor,
                  thickness: Dimensions.width10/5,
                ),
                SizedBox(height: Dimensions.height10),
                RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                  //textDirection: TextDirection.rtl,
                  softWrap: true,
                  maxLines: 1,
                  textScaleFactor: 1,
                  text: TextSpan(
                      text: 'Name :  ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font14
                      ),
                      children: [
                        TextSpan(
                            text: orderController.userAddressList[index].name,
                            style: const TextStyle(fontWeight: FontWeight.normal)
                        ),
                      ]
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                  //textDirection: TextDirection.rtl,
                  softWrap: true,
                  maxLines: 1,
                  textScaleFactor: 1,
                  text: TextSpan(
                      text: 'Phone :  ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font14
                      ),
                      children: [
                        TextSpan(
                            text: orderController.userAddressList[index].phoneOne!,
                            style: TextStyle(fontWeight: FontWeight.normal)
                        ),
                      ]
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                  //textDirection: TextDirection.rtl,
                  softWrap: true,
                  maxLines: 1,
                  textScaleFactor: 1,
                  text: TextSpan(
                      text: 'Phone : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font14
                      ),
                      children: [
                        TextSpan(
                            text: orderController.userAddressList[index].phoneTwo ?? '',
                            style: const TextStyle(fontWeight: FontWeight.normal)
                        ),
                      ]
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                  //textDirection: TextDirection.rtl,
                  softWrap: true,
                  maxLines: 1,
                  textScaleFactor: 1,
                  text: TextSpan(
                      text: 'Address : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font14
                      ),
                      children: [
                        TextSpan(
                            text: orderController.userAddressList[index].address ?? '',
                            style: const TextStyle(fontWeight: FontWeight.normal)
                        ),
                      ]
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          _editAddress(orderController.userAddressList[index]);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF3490dc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                          ),
                          elevation: 1.0,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10,
                              vertical: Dimensions.height10
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(fontSize: Dimensions.font20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.width20),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFe3342f),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                          ),
                          elevation: 1.0,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10,
                              vertical: Dimensions.height10
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(fontSize: Dimensions.font20),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    ) : const Center(child: CircularProgressIndicator());
  });
}

String convertDate(String remoteDate){

  DateTime dateTime = DateTime.parse(remoteDate);
  const String pattern = 'dd-MM-yyyy';
  final String formatted = DateFormat(pattern).format(dateTime);

  return formatted;
}

///Get Total Due
int getTotalDue(List<InvoiceItems> list){
  int tempDueTotal = 0;

  for(final item in list){
    tempDueTotal += item.duePayment!;
  }

  return tempDueTotal;
}

/// Get date as a string for display.
String getFormattedDate(String date) {
  /// Convert into local date format.
  var localDate = DateTime.parse(date).toLocal();

  /// inputFormat - format getting from api or other func.
  /// e.g If 2021-05-27 9:34:12.781341 then format must be yyyy-MM-dd HH:mm
  /// If 27/05/2021 9:34:12.781341 then format must be dd/MM/yyyy HH:mm
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
  var inputDate = inputFormat.parse(localDate.toString());

  /// outputFormat - convert into format you want to show.
  var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
  var outputDate = outputFormat.format(inputDate);

  return outputDate.toString();
}

void _logout(){
  if(Get.find<AuthController>().isUserLoggedIn()){
    Get.find<AuthController>().clearSharedData();
    //Get.find<CartController>().clear();
    //Get.find<CartController>().clearCartHistory();
    Get.offNamed(RouteHelper.getInitial());
    showCustomSnakebar("You are logged out!",title: "Success",color: Colors.green);
  }else{
    print('You are already logged out!');
  }
}

Widget _agentTable(double width){
   return DataTable(
    sortAscending: false,
    dataTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    headingRowColor: MaterialStateProperty.all(AppColors.newBorderColor),
    headingTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w600
    ),
    columnSpacing: 25,
    horizontalMargin: 10,
    showBottomBorder: true,
    border: const TableBorder(
      right:  BorderSide(width: 1.0, color: AppColors.newBorderColor),
      left:  BorderSide(width: 1.0, color: AppColors.newBorderColor),
    ),
    columns: const <DataColumn>[
      DataColumn(
        label: Text(
          'ক্যাটাগরী\nলেভেল',
          style: TextStyle(fontStyle: FontStyle.normal),
        ),
      ),
      DataColumn(
        label: Text(
          'সেলস\n রেঞ্জ',
          style: TextStyle(fontStyle: FontStyle.normal),
        ),
      ),
      DataColumn(
        label: Text(
          'মাসিক\nকমিশন',
          style: TextStyle(fontStyle: FontStyle.normal),
        ),
      ),
      DataColumn(
        label: Text(
          'বাৎসরিক\nকমিশন',
          style: TextStyle(fontStyle: FontStyle.normal),
        ),
      ),
      DataColumn(
        label: Text(
          'সর্বমোট\nকমিশন',
          style: TextStyle(fontStyle: FontStyle.normal),
        ),
      ),
    ],
    rows: const <DataRow>[
      DataRow(
        cells: <DataCell>[
          DataCell(Text('রেগুলার')),
          DataCell(Text('যেকোনো')),
          DataCell(Text('৫%')),
          DataCell(Text('০%')),
          DataCell(Text('৫%')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('স্ট্যান্ডার্ড')),
          DataCell(Text('১০ লক্ষ + ')),
          DataCell(Text('৫%')),
          DataCell(Text('১%')),
          DataCell(Text('৬%',textAlign: TextAlign.center,)),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('প্রায়োরিটি')),
          DataCell(Text('২০ লক্ষ + ')),
          DataCell(Text('৫%')),
          DataCell(Text('১.৫%')),
          DataCell(Text('৬.৫%')),
        ],
      ),
    ],
  );
}

SingleChildScrollView _buildOrderTable(List<Order> orderList) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: const TableBorder(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          left: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
          verticalInside: BorderSide(color: Colors.grey, width: 0.5),
        ),
        showCheckboxColumn: false,
        columnSpacing: Dimensions.width30,
        dataRowHeight: Dimensions.height20*2,
        headingRowHeight: Dimensions.height20*2,
        columns: const [
          DataColumn(
            label: Text('Date'),
          ),
          DataColumn(
            label: Text('Order Number'),
          ),
          DataColumn(
            label: Text('Total Payable'),
          ),
          DataColumn(
            label: Text('1st Payment'),
          ),
          DataColumn(
            label: Text('Due'),
          ),
          DataColumn(
            label: Text('Status'),
          ),
          DataColumn(
            label: Text('Action'),
          )
        ],
        rows: orderList
            .map(
              (item) => DataRow(
              cells: [
                DataCell(
                  Text(
                    convertDate(item.createdAt!),
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                      //item.order_number.toString().length > 8 ?'${item.category_name.toString().substring(0, 8)}...' : item.category_name.toString()
                    item.orderNumber!
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.amount.toString(),
                      //item.description.toString().length > 8 ?'${item.description.toString().substring(0, 8)}...' : item.description.toString()
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.needToPay!.toString(),
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.dueForProducts!.toString(),
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.status.toString(),
                    //item.description.toString().length > 8 ?'${item.description.toString().substring(0, 8)}...' : item.description.toString()
                  ),
                  onTap: () {},
                ),
                DataCell(
                  TextButton(
                        onPressed: (){

                        },
                        child: Container(
                          color: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10/2,
                            vertical: Dimensions.height10/2
                          ),
                          child: const Text(
                            'Pay Now',
                            style: TextStyle(
                                color: Colors.white,
                                //fontSize: 16,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        )
                    ),
                ),
              ]
          ),
        )
            .toList(),
      ),
    ),
  );
}

SingleChildScrollView _buildOrderDetailsTable(List<OrderItems> orderDetailList) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: const TableBorder(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          left: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
          verticalInside: BorderSide(color: Colors.grey, width: 0.5),
        ),
        showCheckboxColumn: true,
        columnSpacing: Dimensions.width30,
        dataRowHeight: Dimensions.height20*2,
        headingRowHeight: Dimensions.height20*2,
        columns: const [
          DataColumn(
            label: Text('Action'),
          ),
          DataColumn(
            label: Text('Date'),
          ),
          DataColumn(
            label: Text('Order ID'),
          ),
          DataColumn(
            label: Text('Item No'),
          ),
          DataColumn(
            label: Text('Quantity'),
          ),
          DataColumn(
            label: Text('Product Value'),
          ),
          DataColumn(
            label: Text('Due'),
          ),
          DataColumn(
            label: Text('Status'),
          )
        ],
        rows: orderDetailList
            .map(
              (item) => DataRow(
              onSelectChanged: (bool? selected) {
                if(selected!){
                  //print('row-selected: ${item}');
                }
              },
              cells: [
                DataCell(
                  TextButton(
                      onPressed: (){

                      },
                      child: Container(
                        color: AppColors.primaryColor,
                        padding: EdgeInsets.all(4),
                        child: const Text(
                          'View',
                          style: TextStyle(
                              color: Colors.white,
                              //fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      )
                  ),
                ),
                DataCell(
                  Text(convertDate(item.createdAt!)),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.orderId!.toString(),
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.orderItemNumber!.toString(),
                    //item.description.toString().length > 8 ?'${item.description.toString().substring(0, 8)}...' : item.description.toString()
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.quantity.toString(),
                    //item.description.toString().length > 8 ?'${item.description.toString().substring(0, 8)}...' : item.description.toString()
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.productValue!.toString(),
                    //item.description.toString().length > 8 ?'${item.description.toString().substring(0, 8)}...' : item.description.toString()
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.duePayment!.toString(),
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.status.toString(),
                  ),
                  onTap: () {},
                ),
              ]
          ),
        )
            .toList(),
      ),
    ),
  );
}

SingleChildScrollView _buildInvoiceTable(List<Invoice> invoiceList) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: const TableBorder(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          left: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5),
          horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
          verticalInside: BorderSide(color: Colors.grey, width: 0.5),
        ),
        showCheckboxColumn: false,
        columnSpacing: Dimensions.width30 ,
        dataRowHeight: Dimensions.height20*2,
        headingRowHeight: Dimensions.height20*2,
        columns: const [
          DataColumn(
            label: Text('Date'),
          ),
          DataColumn(
            label: Text('Invoice ID'),
          ),
          DataColumn(
            label: Text('Courier Bill'),
          ),
          DataColumn(
            label: Text('Total Due'),
          ),
          DataColumn(
            label: Text('Payment Method'),
          ),
          DataColumn(
            label: Text('Status'),
          ),
          DataColumn(
            label: Text('Action'),
          )
        ],
        rows: invoiceList
            .map(
              (item) => DataRow(
              cells: [
                DataCell(
                  Text(convertDate(item.createdAt!)),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    //item.order_number.toString().length > 8 ?'${item.category_name.toString().substring(0, 8)}...' : item.category_name.toString()
                    item.invoiceNo!.toString(),
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.totalCourier!.toString(),
                    //item.description.toString().length > 8 ?'${item.description.toString().substring(0, 8)}...' : item.description.toString()
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    getTotalDue(item.invoiceItems!).toString(),
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.paymentMethod!.toString(),
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text(
                    item.status.toString(),
                  ),
                  onTap: () {},
                ),
                DataCell(
                  TextButton(
                      onPressed: (){

                      },
                      child: Container(
                        color: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width10/2,
                          vertical: Dimensions.height10/2
                        ),
                        child: const Text(
                          'View',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      )
                  ),
                ),
              ]
          ),
        )
            .toList(),
      ),
    ),
  );
}

//Dashboard Item
class GridItem{
  int id;
  String? menuTitle;
  IconData? icon;

  GridItem(this.id,this.menuTitle, this.icon);

}

//Delivery Menu
class DeliveryMenu{
  int id;
  String? menuTitle;

  DeliveryMenu(this.id,this.menuTitle);

}
