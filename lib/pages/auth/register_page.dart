import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybuybd/base/footer.dart';
import 'package:skybuybd/controller/auth_controller.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snakebar.dart';
import '../../models/registration/signup_body_model.dart';
import '../home/widgets/dimond_bottom_bar.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  late bool isUserLoggedIn;
  int selectedIndex = -1;

  //Controller
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _buildAppBar(),
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading ? _buildBody(width,authController) : const CustomLoader();
      }),
      bottomNavigationBar: _buildBottomNavigation(selectedIndex),
    );
  }

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
          preferredSize: Size.fromHeight(40),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10,
                vertical: Dimensions.height10
            ),
            child: SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(Dimensions.radius20/2),
                  prefixIcon: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.btnColorBlueDark,
                  ),
                  suffixIcon: Container(
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
                isUserLoggedIn ? Get.toNamed(RouteHelper.getAccountPage()) : Get.toNamed(RouteHelper.getLoginPage());
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(int selectedIndex){
    return DiamondBottomNavigation(
      itemIcons: const [
        CupertinoIcons.home,
        CupertinoIcons.line_horizontal_3,
        CupertinoIcons.cart,
        CupertinoIcons.chat_bubble,
      ],
      itemName: const [
        'Home','Category','','Cart','Chat'
      ],
      centerIcon: Icons.place,
      selectedIndex: selectedIndex,
      onItemPressed: onPressed,
      selectedColor: AppColors.btnColorBlueDark,
      unselectedColor: Colors.black,
    );
  }

  void onPressed(index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        setState(() {
          selectedIndex = 0;
        });
        Get.offNamed(RouteHelper.getInitial());
      }else if (index == 1) {
        setState(() {
          selectedIndex = 1;
        });
        Get.offNamed(RouteHelper.getInitial());
      }else if (index == 2) {
        //Refresh home page
        setState(() {
          selectedIndex = 2;
        });
        Get.offNamed(RouteHelper.getInitial());
      }else if (index == 3) {
        //Cart Page
        setState(() {
          selectedIndex = 3;
        });
        Get.offNamed(RouteHelper.getInitial());
      }else if (index == 4) {
        //Chat Page
        setState(() {
          selectedIndex = 4;
        });
        Get.offNamed(RouteHelper.getInitial());
      }else{
        setState(() {
          selectedIndex = index;
        });
        Get.offNamed(RouteHelper.getInitial());
      }
    });
  }

  Widget _buildBody(double width, AuthController authController){
    return Container(
      width: width,
      height: 550+740,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Form
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.5
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 28,
                          color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "to continue to ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "Skybuybd",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          ),

                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  //Facebook
                  Container(
                    height: 48,
                    padding: EdgeInsets.only(top: 5,bottom: 5,left: 16,right: 16),
                    margin: EdgeInsets.only(top: 0,bottom: 0,left: 16,right: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                            color: AppColors.borderColor,
                            width: 0.0,
                            style: BorderStyle.solid
                        ),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(4, 5),
                              blurRadius: 5,
                              spreadRadius: 2,
                              color: AppColors.borderColor
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/social/facebook.png',
                          height: 28,
                          width: 28,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                        const Text(
                          'Continue with Facebook',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.btnColorBlueDark
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  //Or
                  const Center(
                    child: Text(
                      'OR',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  //First Name
                  const Text(
                    'First Name',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFE3E8F0),
                            width: 1.5
                        )
                    ),
                    child: TextField(
                      textAlign: TextAlign.start ,
                      textInputAction: TextInputAction.next,
                      controller: firstNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(Dimensions.radius8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: Dimensions.radius20/2,
                          top: Dimensions.radius20/2,
                          bottom: Dimensions.radius20/2,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'First Name',
                        hintMaxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Last Name
                  const Text(
                    'Last Name',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFE3E8F0),
                            width: 1.5
                        )
                    ),
                    child: TextField(
                      textAlign: TextAlign.start ,
                      textInputAction: TextInputAction.next,
                      controller: lastNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(Dimensions.radius8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: Dimensions.radius20/2,
                          top: Dimensions.radius20/2,
                          bottom: Dimensions.radius20/2,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Last Name',
                        hintMaxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Email Name
                  const Text(
                    'E-mail Address',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFE3E8F0),
                            width: 1.5
                        )
                    ),
                    child: TextField(
                      textAlign: TextAlign.start ,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(Dimensions.radius8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: Dimensions.radius20/2,
                          top: Dimensions.radius20/2,
                          bottom: Dimensions.radius20/2,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'E-mail Address',
                        hintMaxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Password
                  const Text(
                    'Password',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFE3E8F0),
                            width: 1.5
                        )
                    ),
                    child: TextField(
                      textAlign: TextAlign.start ,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(Dimensions.radius8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: Dimensions.radius20/2,
                          top: Dimensions.radius20/2,
                          bottom: Dimensions.radius20/2,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        hintMaxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Confirm Password
                  const Text(
                    'Confirm Password',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFE3E8F0),
                            width: 1.5
                        )
                    ),
                    child: TextField(
                      textAlign: TextAlign.start ,
                      textInputAction: TextInputAction.go,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(Dimensions.radius8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: Dimensions.radius20/2,
                          top: Dimensions.radius20/2,
                          bottom: Dimensions.radius20/2,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Confirm Password',
                        hintMaxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  //Register btn
                  GestureDetector(
                    onTap: (){
                        registration(authController);
                    },
                    child: Container(
                      height: 40,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(3)
                      ),
                      child: const Center(
                        child: Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Have an account? ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "Login",
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed(RouteHelper.getLoginPage());
                              },
                          ),

                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              thickness: 20,
              color: Colors.grey,
            ),
            Footer()
          ],
        ),
      ),
    );
  }

  void registration(AuthController authController){

    //var authController = Get.find<AuthController>();

    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if(firstName.isEmpty){
      showCustomSnakebar(
          'Type in your first name',
          title: "First Name"
      );
    }else if(email.isEmpty){
      showCustomSnakebar(
          'Type in your email',
          title: "Email"
      );
    }else if(!GetUtils.isEmail(email)){
      showCustomSnakebar(
          'Type a valid email address',
          title: "Invalid Email"
      );
    }else if(password.isEmpty){
      showCustomSnakebar(
          'Type in your password',
          title: "Password"
      );
    }else if(password.length<6){
      showCustomSnakebar(
          'Password can\'t be less than six characters',
          title: "Password"
      );
    }else if(confirmPassword.isEmpty){
      showCustomSnakebar(
          'Type in your confirm password',
          title: "Password"
      );
    }else if(confirmPassword.length<6){
      showCustomSnakebar(
          'Password can\'t be less than six characters',
          title: "Password"
      );
    }else if(confirmPassword != password){
      showCustomSnakebar(
          'Password does not match',
          title: "Password not matched"
      );
    }else{

      SignUpBody body = SignUpBody(
          first_name: firstName,
          last_name: lastName ?? '',
          email: email,
          password: password
      );

      authController.registration(body).then((status){
        if(status.isSuccess){
          Get.offNamed(RouteHelper.getInitial());
        }else{
          showCustomSnakebar(status.message);
        }
      });

    }
  }

}
