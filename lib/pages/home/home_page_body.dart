import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:skybuybd/base/footer.dart';
import 'package:skybuybd/base/show_custom_snakebar.dart';
import 'package:skybuybd/controller/auth_controller.dart';
import 'package:skybuybd/controller/category_controller.dart';
import 'package:skybuybd/controller/category_product_controller.dart';
import 'package:skybuybd/controller/home_controller.dart';
import 'package:skybuybd/models/category/category_product_model.dart';
import 'package:skybuybd/utils/constants.dart';
import 'package:skybuybd/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/category/category_model.dart';
import '../../route/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_icon.dart';
import 'package:get/get.dart';

class HomePageBody extends StatefulWidget {
  HomePageBody({Key? key}) : super(key: key);

  //Grid Item Icons
  Items item1 = Items(1, 'আমাদের সম্পর্কে জানুন', 'https://www.skybuybd.com/img/frontend/priorities/who-we-are.png','https://www.skybuybd.com/about-us');
  Items item2 = Items(2, 'নিরাপদ পেমেন্ট।', 'https://www.skybuybd.com/img/frontend/priorities/secure-payment.png','https://www.skybuybd.com/secured-payment');
  Items item3 = Items(3, 'পণ্যের ডেলিভারী সময়।', 'https://www.skybuybd.com/img/frontend/priorities/deliveryTime.png','https://www.skybuybd.com/shipping-and-delivery');
  Items item4 = Items(4, 'কিভাবে অর্ডার করবেন।', 'https://www.skybuybd.com/img/frontend/priorities/how-to-order.png','https://www.skybuybd.com/how-to-buy');
  Items item5 = Items(5, 'নিষিদ্ধ পণ্য সমূহ।', 'https://www.skybuybd.com/img/frontend/priorities/ban-or-nisido.png','https://www.skybuybd.com/prohibited-items');
  Items item6 = Items(6, 'রিটার্ন ও রিফান্ড পলিসি।', 'https://www.skybuybd.com/img/frontend/priorities/return.png','https://www.skybuybd.com/return-and-refund-policy');
  Items item7 = Items(7, 'কাস্টমস ও শিপিং চার্জ।', 'https://www.skybuybd.com/img/frontend/priorities/delivery.png','https://www.skybuybd.com/custom-and-shipping-charge');
  Items item8 = Items(8, 'স্বছতা নীতিমালা।', 'https://www.skybuybd.com/img/frontend/priorities/teransparency.png','https://www.skybuybd.com/transparency');
  Items item9 = Items(9, 'আমাদের শর্তাবলী।', 'https://www.skybuybd.com/img/frontend/priorities/sortaboli.png','https://www.skybuybd.com/terms-conditions');

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {

  final CarouselController _controller = CarouselController();
  var color = 0xffffffff;

  double priceFactor = 1.0;

  Future<void> _loadResources() async {
    await Get.find<CategoryController>().getParentCategoryList();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        //priceFactor = Get.find<HomeController>().isConversionPriceLoaded ? Get.find<HomeController>().conversionPrice : 20.0;
        if( Get.find<HomeController>().getSharedPref().containsKey(Constants.CONVERSION_RATE)){
          priceFactor = Get.find<HomeController>().getSharedPref().getDouble(Constants.CONVERSION_RATE)!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Items> myList = [
      widget.item1,
      widget.item2,
      widget.item3,
      widget.item4,
      widget.item5,
      widget.item6,
      widget.item7,
      widget.item8,
      widget.item9,
      //widget.item1,
    ];

    return RefreshIndicator(
      onRefresh: _loadResources,
      child: GetBuilder<HomeController>(builder: (homeController){
        return GetBuilder<CategoryProductController>(builder: (categoryProductController){
          return homeController.isLoaded ? Container(
            color: AppColors.pageBg,
            child: SingleChildScrollView(
              //scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  homeController.bannerList.isNotEmpty ? _buildSlider(homeController) : const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),),
                  _buildInfoGridView(myList),
                  SizedBox(height: Dimensions.height10),
                  GetBuilder<CategoryController>(builder: (catController){
                    catController.parentCategoryList.isEmpty ? catController.getParentCategoryList() : 1;
                    //print("Category Length : ${catController.parentCategoryList.length}");
                    return  catController.parentCategoryList.isNotEmpty ?  _buildCategoryCardSlider(catController) : catController.isLoaded ? _buildCategoryCardSlider(catController) : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }),
                  SizedBox(height: Dimensions.height15),
                  _buildProductGridShoe(categoryProductController),
                  SizedBox(height: Dimensions.height15),
                  _buildProductGridBag(categoryProductController),
                  SizedBox(height: Dimensions.height15),
                  _buildProductGridJewelry(categoryProductController),
                  SizedBox(height: Dimensions.height15),
                  _buildProductGridBaby(categoryProductController),
                  SizedBox(height: Dimensions.height15),
                  _buildProductGridWatch(categoryProductController),
                  SizedBox(height: Dimensions.height15*1.5),
                  const Footer()
                ],
              ),
            ),
          ) : const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        });

      }),
    );
  }

  String setTotalSold(CategoryProductModel item){
    String totalSoldQuantity = "0";
    if(item.featuredValues != null){
      for(final item in item.featuredValues!){
        if(item.name == "TotalSales"){
          totalSoldQuantity = item.value!;
        }
      }
    }
    return totalSoldQuantity;
  }

  Widget _buildSlider(HomeController controller) {
    return Container(
      height: Dimensions.height50*3+Dimensions.height20,
      color: Colors.transparent,
      child: ImageSlideshow(
        indicatorColor: Colors.blue,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        autoPlayInterval: 3000,
        isLoop: true,
        children: [
          for(int x = 0; x < controller.bannerList.length; x++)...[
            Image.network(
              "${Constants.BASE_URL}/${controller.bannerList[x].postThumb!}",
              fit: BoxFit.cover,
            ),

            // you can add widget here as well
          ],
        ],
      ),
    );
  }

  Widget _buildInfoGridView(List<Items> myList) {
    return Container(
      height: Dimensions.height50*3,
        width: double.maxFinite,
        color: Colors.white,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 1.0,
            enlargeCenterPage: false,
            viewportFraction: 1,
            autoPlay: true,
          ),
          itemCount: (myList.length / 3).round(),
          itemBuilder: (context, index, realIdx) {
            final int first = index * 2;
            final int second = first + 1;
            final int third = second + 1;
            return Row(
              children: [first, second,third].map((idx) {
                return Expanded(
                  flex: 1,
                  child: Container(
                    /*decoration: BoxDecoration(
                        color: Color(color),
                        borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                      ],
                    ),*/
                    margin: EdgeInsets.only(
                        top: Dimensions.height10,
                        bottom: Dimensions.height10,
                        right: Dimensions.width10,
                        left: Dimensions.width10
                    ),
                    child: Column(
                      children: [
                        /*Image.network(
                          myList[idx].icon,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),*/
                        SizedBox(height: Dimensions.height10),
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.width15,right: Dimensions.width15),
                          child: CachedNetworkImage(
                            imageUrl: myList[idx].icon,
                            height: Dimensions.height50,
                            width: Dimensions.width50,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        SizedBox(height: Dimensions.height10),
                        Text(
                          myList[idx].title,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }

  Widget _buildCategoryCardSlider(CategoryController catController){

    List<CategoryModel> catList = catController.parentCategoryList;

    return Container(
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Top categories container
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Categories'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: AppIcon(
                          icon: Icons.chevron_left,
                          backgroundColor: AppColors.btnColorBlueDark,
                          iconColor: Colors.white,
                          iconSize: 20,
                          size: 30,
                        ),
                        onTap: (){
                          _controller.previousPage();
                        },
                      ),
                      SizedBox(width: Dimensions.width10),
                      GestureDetector(
                        child: AppIcon(
                          icon: Icons.chevron_right,
                          backgroundColor: AppColors.btnColorBlueDark,
                          iconColor: Colors.white,
                          iconSize: 20,
                          size: 30,
                        ),
                        onTap: (){
                          _controller.nextPage();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.height15),
          Container(
              height: Dimensions.height20*6,
              width: double.maxFinite,
              color: Colors.white,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  aspectRatio: 1.0,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  autoPlay: true,
                ),
                carouselController: _controller,
                itemCount: (catList.length / 3).round(),
                itemBuilder: (context, index, realIdx) {
                  final int first = index * 2;
                  final int second = first + 1;
                  final int third = second + 1;
                  return Row(
                    children: [first, second,third].map((idx) {
                      return Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            CategoryModel data = catList[idx];
                            //Get.toNamed(RouteHelper.getSubCategoryPage(data.name!,data.slug!));
                            showCustomSnakebar("Please wait...",isError:false,title:"Category",color: Colors.green);
                            Get.find<CategoryController>().getSubCategoryList(data.slug!).then((response) {
                              if(response.isSuccess){
                                if(response.message == "child"){
                                  if (kDebugMode) {
                                    print("Going to subcategory page");
                                  }
                                  //Child exist
                                  Get.toNamed(RouteHelper.getSubCategoryPage(data.name!,data.slug!));
                                }else if(response.message == "product"){
                                  if (kDebugMode) {
                                    print("Going to product page");
                                  }
                                  //Product exist
                                  Get.toNamed(RouteHelper.getCategoryProductPage(data.name!, "", "", data.slug!));
                                }
                              }else{
                                if (kDebugMode) {
                                  print("Error homepage category item click;");
                                }
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            margin: const EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  child: Image.network(
                                    "https://www.skybuybd.com/${catList[idx].picture!}",
                                    height: 50,
                                    width: 60,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    catList[idx].name!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              )),
        ],
      ),
    );
  }

  Widget _buildProductGridShoe(CategoryProductController categoryProductController) {
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.only(
          top: Dimensions.height10,
          bottom: 0,
          left: Dimensions.width10/2,
          right: Dimensions.width10/2
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Header
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SHOE'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.font18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: (){
                            Get.toNamed(RouteHelper.getCategoryProductPage("Shoe", "", "", "shoes"));
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: Dimensions.width15,vertical: Dimensions.height10/5)),
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
                            'View More',
                            style: TextStyle(
                                fontSize: Dimensions.font12,
                                letterSpacing: 0,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.center,

                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.height15),
          //Body
          Container(
            height: (Dimensions.height200*6+Dimensions.height100)-Dimensions.height10/5,
            padding: EdgeInsets.only(bottom: Dimensions.height10),
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                childAspectRatio: 1/1.18,
                padding: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    top: 0,
                    bottom: 0
                ),
                crossAxisCount: 2,
                crossAxisSpacing: Dimensions.width15,
                mainAxisSpacing: Dimensions.width15,
                children: categoryProductController.shoesList.map((data) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getSingleProductPage(data.id!));
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border:  Border(
                            right: BorderSide(
                              color: AppColors.productGridBorderColor,
                              width: 2,
                              style: BorderStyle.solid
                            ),
                            top: BorderSide(
                              color: AppColors.productGridBorderColor,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              color: AppColors.productGridBorderColor,
                              width: 1.0,
                            ),
                            left: BorderSide(
                              color: AppColors.productGridBorderColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //Product Image
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10,
                                vertical: Dimensions.height10
                              ),
                              child: Image.network(
                                data.mainPictureUrl!,
                                height: Dimensions.height20*6,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            //Product Name
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10,
                                vertical: Dimensions.height10/2
                              ),
                              child: Text(
                                data.title!.toUpperCase(),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  color: AppColors.productNameColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            //Product Price
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width15,
                                vertical: Dimensions.height10/2
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '৳ ${data.quantityRanges != null ? (data.quantityRanges![0].price!.originalPrice*priceFactor).round() :(data.price?.originalPrice*priceFactor).round()}',
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: Dimensions.font12,
                                        color: AppColors.productPriceColor,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  Text(
                                    'SOLD: ${setTotalSold(data)}',
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: Dimensions.font12,
                                        color: Colors.grey
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  );
                }).toList()
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGridBag(CategoryProductController categoryProductController){
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.only(
          top: Dimensions.height10,
          bottom: 0,
          left: Dimensions.width10/2,
          right: Dimensions.width10/2
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BAGS'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.font18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: (){
                            Get.toNamed(RouteHelper.getCategoryProductPage("Bag", "", "", "bags"));
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: Dimensions.width15,vertical: Dimensions.height10/2)),
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
                            'View More',
                            style: TextStyle(
                                fontSize: Dimensions.font12,
                                letterSpacing: 0,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.center,

                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.height15),
          Container(
            padding: EdgeInsets.zero,
            height: (Dimensions.height200*6+Dimensions.height100)-Dimensions.height10/5,
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                childAspectRatio: 1/1.18,
                padding: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    top: 0,
                    bottom: 0
                ),
                crossAxisCount: 2,
                crossAxisSpacing: Dimensions.width15,
                mainAxisSpacing: Dimensions.width15,
                children: categoryProductController.bagsList.map((data) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getSingleProductPage(data.id!));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border:  Border(
                          right: BorderSide(
                              color: AppColors.productGridBorderColor,
                              width: 2,
                              style: BorderStyle.solid
                          ),
                          top: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                          bottom: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                          left: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Product Image
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10,
                              vertical: Dimensions.height10
                            ),
                            child: Image.network(
                              data.mainPictureUrl!,
                              height: Dimensions.width20*6,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          //Product Name
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width15,
                                vertical: Dimensions.height10/2
                            ),
                            child: Text(
                              data.title!.toUpperCase(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font14,
                                color: AppColors.productNameColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          //Product Price
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width15,
                                vertical: Dimensions.height10/2
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '৳ ${data.quantityRanges != null ? (data.quantityRanges![0].price!.originalPrice*priceFactor).round() :(data.price?.originalPrice*priceFactor).round()}',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: AppColors.productPriceColor,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'SOLD: ${setTotalSold(data)}',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGridJewelry(CategoryProductController categoryProductController){
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.only(
          top: Dimensions.height10,
          bottom: 0,
          left: Dimensions.width10/2,
          right: Dimensions.width10/2
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.zero,
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'JEWELRY'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.font18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: (){
                            Get.toNamed(RouteHelper.getCategoryProductPage("Jewelry", "", "", "jewelry"));
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: Dimensions.width15,vertical: Dimensions.height10/2)),
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
                            'View More',
                            style: TextStyle(
                                fontSize: Dimensions.font12,
                                letterSpacing: 0,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.center,

                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.height15),
          Container(
            padding: EdgeInsets.zero,
            height: (Dimensions.height200*6+Dimensions.height100)-Dimensions.height10/5,
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                childAspectRatio: 1/1.18,
                padding: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    top: 0,
                    bottom: 0
                ),
                crossAxisCount: 2,
                crossAxisSpacing: Dimensions.width15,
                mainAxisSpacing: Dimensions.width15,
                children: categoryProductController.jewelryList.map((data) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getSingleProductPage(data.id!));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border:  Border(
                          right: BorderSide(
                              color: AppColors.productGridBorderColor,
                              width: 2,
                              style: BorderStyle.solid
                          ),
                          top: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                          bottom: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                          left: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Product Image
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10,
                              vertical: Dimensions.height10
                            ),
                            child: Image.network(
                              data.mainPictureUrl!,
                              height: Dimensions.width20*6,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          //Product Name
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width15,
                                vertical: Dimensions.height10/2
                            ),
                            child: Text(
                              data.title!.toUpperCase(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font14,
                                color: AppColors.productNameColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          //Product Price
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width15,
                                vertical: Dimensions.height10/2
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '৳ ${data.quantityRanges != null ? (data.quantityRanges![0].price!.originalPrice*priceFactor).round() :(data.price?.originalPrice*priceFactor).round()}',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: AppColors.productPriceColor,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'SOLD: ${setTotalSold(data)}',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGridWatch(CategoryProductController categoryProductController){
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.only(
          top: Dimensions.height10,
          bottom: 0,
          left: Dimensions.width10/2,
          right: Dimensions.width10/2
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.zero,
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'WATCH'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.font18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: (){
                            Get.toNamed(RouteHelper.getCategoryProductPage("Watch", "", "", "watches"));
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: Dimensions.width15,vertical: Dimensions.height10/2)),
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
                            'View More',
                            style: TextStyle(
                                fontSize: Dimensions.font12,
                                letterSpacing: 0,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.center,

                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.height15),
          Container(
            padding: EdgeInsets.zero,
            height: (Dimensions.height200*6+Dimensions.height100)-Dimensions.height10/5,
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                childAspectRatio: 1/1.18,
                padding: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    top: 0,
                    bottom: 0
                ),
                crossAxisCount: 2,
                crossAxisSpacing: Dimensions.width15,
                mainAxisSpacing: Dimensions.width15,
                children: categoryProductController.watchList.map((data) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getSingleProductPage(data.id!));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border:  Border(
                          right: BorderSide(
                              color: AppColors.productGridBorderColor,
                              width: 2,
                              style: BorderStyle.solid
                          ),
                          top: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                          bottom: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                          left: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Product Image
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10,
                              vertical: Dimensions.height10
                            ),
                            child: Image.network(
                              data.mainPictureUrl!,
                              height: Dimensions.width20*6,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          //Product Name
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width15,
                                vertical: Dimensions.height10/2
                            ),
                            child: Text(
                              data.title!.toUpperCase(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font14,
                                color: AppColors.productNameColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          //Product Price
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width15,
                                vertical: Dimensions.height10/2
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '৳ ${data.quantityRanges != null ? (data.quantityRanges![0].price!.originalPrice*priceFactor).round() :(data.price?.originalPrice*priceFactor).round()}',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: AppColors.productPriceColor,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'SOLD: ${setTotalSold(data)}',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGridBaby(CategoryProductController categoryProductController){
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.only(
          top: Dimensions.height10,
          bottom: 0,
          left: Dimensions.width10/2,
          right: Dimensions.width10/2
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.zero,
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Baby items'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.font18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: (){
                            Get.toNamed(RouteHelper.getCategoryProductPage("Baby Items", "", "", "baby-items"));
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: Dimensions.width15,vertical: Dimensions.height10/2)),
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
                            'View More',
                            style: TextStyle(
                                fontSize: Dimensions.font12,
                                letterSpacing: 0,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.center,

                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.height15),
          Container(
            padding: EdgeInsets.zero,
            height: (Dimensions.height200*6+Dimensions.height100)-Dimensions.height10/5,
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                childAspectRatio: 1/1.18,
                padding: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    top: 0,
                    bottom: 0
                ),
                crossAxisCount: 2,
                crossAxisSpacing: Dimensions.width15,
                mainAxisSpacing: Dimensions.width15,
                children: categoryProductController.babyList.map((data) {
                  return GestureDetector(
                    onTap: (){
                      if (kDebugMode) {
                        print("Baby Product ID : ${data.id!}");
                      }
                      Get.toNamed(RouteHelper.getSingleProductPage(data.id!));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border:  Border(
                          right: BorderSide(
                              color: AppColors.productGridBorderColor,
                              width: 2,
                              style: BorderStyle.solid
                          ),
                          top: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                          bottom: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                          left: BorderSide(
                            color: AppColors.productGridBorderColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Product Image
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10,
                              vertical: Dimensions.height10
                            ),
                            child: Image.network(
                              data.mainPictureUrl!,
                              height: Dimensions.width20*6,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          //Product Name
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width15,vertical: Dimensions.height10/2),
                            child: Text(
                              data.title!.toUpperCase(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font14,
                                color: AppColors.productNameColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          //Product Price
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width15,vertical: Dimensions.height10/2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '৳ ${data.quantityRanges != null ? (data.quantityRanges![0].price!.originalPrice*priceFactor).round() :(data.price?.originalPrice*priceFactor).round()}',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: AppColors.productPriceColor,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'SOLD: ${setTotalSold(data)}',
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}

//Grid Item
class Items{
  int id;
  String title;
  String icon;
  String btnName;

  Items(this.id,this.title, this.icon,this.btnName);
}


