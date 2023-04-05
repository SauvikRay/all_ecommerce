import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skybuybd/controller/cart_controller.dart';
import 'package:skybuybd/controller/product_controller.dart';
import 'package:skybuybd/models/category/category_product_model.dart';
import 'package:skybuybd/models/product_details/product_details.dart';
import 'package:skybuybd/models/product_details/product_details_model.dart';
import 'package:skybuybd/route/route_helper.dart';

import '../../all_model_and_repository/product_details/model_product_varient_size.dart';
import '../../all_model_and_repository/wishlist/wishlist_provider.dart';
import '../../base/show_custom_snakebar.dart';
import '../../controller/auth_controller.dart';
import '../../controller/home_controller.dart';
import '../../models/meta_data.dart';
import '../../models/product/color_image.dart';
import '../../models/product/extra_info.dart';
import '../../models/product/product_size.dart';
import '../../models/product/small_image.dart';
import '../../models/shipping_text.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class SingleProductPage extends StatefulWidget {
  final String slug;
  const SingleProductPage({Key? key, required this.slug}) : super(key: key);

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  late bool isUserLoggedIn;
  late WishlistProvider wishlistProvider;

  List<String> dropdownItems = [
    'Shipping Method: By Air (15-25) Days',
    'Shipping Method: By Sea (45-90) Days',
  ];
  String? dropdownSelectedValue;

  List<ExtraInfo> extraInfoList = [
    ExtraInfo(1, 'SELLER PRODUCT'),
    ExtraInfo(2, 'ADDITIONAL INFO'),
    ExtraInfo(3, 'DESCRIPTION'),
    ExtraInfo(4, 'SELLER INFO'),
    ExtraInfo(5, 'SHIPPING & DELIVERY'),
  ];

  int extraInfoSelectedIndex = 0;

  String largeImage = '';
  ValueNotifier<String> _myUrl = ValueNotifier<String>('');
  List<SmallImage> smallImageList = [];
  bool quantityRangeExist = false;
  List<QuantityRange> quantityRangeList = [];
  List<ColorImage> colorImgList = [];
  String colorName = '';
  List<ProductSize> productSizeList = [];

  ProductDetailModel _productDetailModel = ProductDetailModel();

  double priceFactor = 1.0;

  //Image picker
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;


  @override
  void initState() {
    super.initState();
    print("slug --> " + widget.slug);
    wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        //priceFactor = Get.find<HomeController>().isConversionPriceLoaded ? Get.find<HomeController>().conversionRate() : 20.0;
        if (Get.find<HomeController>()
            .getSharedPref()
            .containsKey(Constants.CONVERSION_RATE)) {
          priceFactor = Get.find<HomeController>()
              .getSharedPref()
              .getDouble(Constants.CONVERSION_RATE)!;
        } else {
          priceFactor = 20.0;
        }
      });
    });

    getProductDetails();
    isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();

    _myUrl.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // do something
        setState(() {
          largeImage = _myUrl.value;
        });
      });
    });
  }

  _imageFromCamera() async {
    _image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (_image != null) {
      setState(() {
        file = File(_image!.path);
      });
      //saveInStorage(file!);
      if (file != null) {
        //showCustomSnakebar("Image picked successfully",isError: false,title: "Image",color: AppColors.primaryColor);
        //Get.find<ProductController>().uploadImage(file!);
        Get.toNamed(RouteHelper.getSearchPage("", "image", file!.path));
      } else {
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
      if (file != null) {
        //showCustomSnakebar("Image picked successfully",isError: false,title: "Image",color: AppColors.primaryColor);
        //Get.find<ProductController>().uploadImage(file!);
        Get.toNamed(RouteHelper.getSearchPage("", "image", file!.path));
      } else {
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

  void getProductDetails() async {
    await Get.find<ProductController>().getProductDetails(widget.slug);
  }

  onButtonPressed(String value, int index, String property) {
    setState(() {
      if (property == "small") {
        largeImage = value;
        for (final item in smallImageList) {
          item.selected = false;
        }
        smallImageList[index].selected = true;
      } else if (property == "color") {
        largeImage = value;
        for (final item in colorImgList) {
          item.selected = false;
        }
        colorImgList[index].selected = true;
      } else if (property == "color1") {
        for (final item in colorImgList) {
          item.selected = false;
        }
        colorImgList[index].selected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Focus nodes are necessary
    final textFieldFocusNode = FocusNode();
    TextEditingController controller = TextEditingController();

    String getSelectedColorName(List<ColorImage> colorImageList1) {
      String res = '';
      for (final item in colorImageList1) {
        if (item.selected) {
          res = item.colorName;
        }
      }
      return res;
    }

    double getVariationPrice(List<QuantityRange> list, int currentQty) {
      double res = 0.0;

      for (final item in list) {
        if (item.minQuantity! >= currentQty) {
          res = double.parse(
              (item.price!.originalPrice * priceFactor).round().toString());
        }
      }

      return res;
    }

    CachedNetworkImage cachedNetworkImage = CachedNetworkImage(
      imageUrl: largeImage,
      height: Dimensions.height50 * 7,
      width: double.maxFinite,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.transparent,
        height: Dimensions.height50,
        width: Dimensions.width50,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );

    AppBar _buildAppBar(
        FocusNode textFieldFocusNode, TextEditingController controller) {
      return AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        toolbarHeight: Dimensions.height10 * 10,
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
            preferredSize: Size.fromHeight(Dimensions.height10 * 4),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10,
                  vertical: Dimensions.height10),
              child: SizedBox(
                height: Dimensions.height45,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(Dimensions.radius20 / 2),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.btnColorBlueDark,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        //Text Search
                        textFieldFocusNode.unfocus();
                        textFieldFocusNode.canRequestFocus = false;

                        String keyword = controller.text;
                        if (keyword.isEmpty) {
                          showCustomSnakebar("Search keyword is empty!",
                              isError: false, title: "Search Error");
                        } else {
                          Get.toNamed(RouteHelper.getSearchPage(
                              keyword, "keyword", ""));
                        }

                        //Enable the text field's focus node request after some delay
                        Future.delayed(const Duration(milliseconds: 100), () {
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
            )),
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
                      right: 8,
                      top: 5,
                      child: BigText(
                        text: '0',
                        size: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                onTap: () {
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
                      right: 8,
                      top: 5,
                      child: BigText(
                        text: '0',
                        size: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                onTap: () {
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
                  isUserLoggedIn
                      ? Get.toNamed(RouteHelper.getAccountPage())
                      : Get.toNamed(RouteHelper.getLoginPage());
                },
              ),
            ],
          ),
        ],
      );
    }

    List<Attribute> getSelectedAttribute(ProductController controller) {
      List<Attribute> temp = [];

      if (colorImgList.isNotEmpty) {
        for (final i in colorImgList) {
          if (i.selected) {
            for (final j in controller.attributeList) {
              if (j.vid! == i.vid) {
                temp.add(j);
              }
            }
          }
        }
      }

      if (productSizeList.isNotEmpty) {
        for (final x in productSizeList) {
          if (x.selected) {
            for (final y in controller.attributeList) {
              if (y.vid! == x.vid) {
                temp.add(y);
              }
            }
          }
        }
      }

      return temp;
    }

    MetaDatas buildCartMetaData(ProductController controller, String itemCode,
        int quantity, int price) {
      MetaDatas data = MetaDatas(
          itemCode: itemCode,
          maxQuantity:
              controller.productDetailModel.productDetails!.masterQuantity!,
          quantity: quantity,
          price: price,
          subTotal: price * quantity,
          image: controller.largeImage,
          attributes: getSelectedAttribute(controller),
          isChecked: false);
      return data;
    }

    int findPriceWithoutQtyRange(
        ProductController controller, String configuredItemsId) {
      dynamic val = 0.0;
      List<ConfiguredItems> _configuredItems = controller.configuredItems;
      for (final item in _configuredItems) {
        if (item.id! == configuredItemsId) {
          val = item.price!.originalPrice!;
        }
      }
      return (val * priceFactor).round();
    }

    int findMiniPriceTableAvailableQty(
        ProductController controller, String vid) {
      int result = 0;
      for (final i in controller.configuredItems) {
        for (final j in i.configurators!) {
          if (vid == j.vid!) {
            result = i.quantity!;
          }
        }
      }

      return result;
    }

    String miniPriceVid() {
      String vid = '';

      for (final item in colorImgList) {
        if (item.selected) {
          vid = item.vid;
        }
      }

      return vid;
    }

    ColorImage getSelectedColorImage() {
      ColorImage colorImage = ColorImage(0, 0, '', '', '', false);

      for (final item in colorImgList) {
        if (item.selected) {
          colorImage = item;
          print("Hello : ${colorImage.colorName}");
        }
      }

      return colorImage;
    }

    String findConfiguratorID(String vid, ProductController controller) {
      String id = '';
      for (final i in controller.configuredItems) {
        for (final j in i.configurators!) {
          if (j.vid! == vid) {
            id = i.id!;
          }
        }
      }
      return id;
    }

    Widget priceTableNew(ProductController controller) {
      if (productSizeList.isNotEmpty) {
        return DataTable(
          sortAscending: false,
          dataRowHeight: Dimensions.height20 * 4,
          headingRowColor: MaterialStateProperty.all(AppColors.newBorderColor),
          columnSpacing: 0,
          horizontalMargin: 0,
          showBottomBorder: true,
          border: const TableBorder(
            right: BorderSide(width: 1.0, color: AppColors.newBorderColor),
            left: BorderSide(width: 1.0, color: AppColors.newBorderColor),
          ),
          columns: <DataColumn>[
            DataColumn(
              label: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: const Text(
                  'Size',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: const Text(
                  'Price (৳)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: const Text(
                  'Quantity',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
          ],
          rows: List.generate(
            productSizeList.length,
            (index) {
              return DataRow(cells: [
                DataCell(
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Text(productSizeList[index].size,
                        textAlign: TextAlign.center),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Text(
                        "৳${quantityRangeList.isNotEmpty ? (quantityRangeList[0].price!.originalPrice * priceFactor).round() : findPriceWithoutQtyRange(controller, productSizeList[index].configuredItemsId)}",
                        textAlign: TextAlign.center),
                  ),
                ),
                DataCell(productSizeList[index].currentQty == 0
                    ? GestureDetector(
                        onTap: () {
                          // updateSelected( productSizeList[index]);
                          log("size id :${productSizeList[index].id} ");
                          setState(() {
                            productSizeList[index].currentQty =
                                productSizeList[index].currentQty + 1;
                          });
                        },
                        child: Container(
                          height: Dimensions.height20 * 2,
                          width: MediaQuery.of(context).size.width / 3,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius15 / 3),
                              color: AppColors.btnColorBlueDark),
                          child: Text(
                            'Add',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    : Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.5, color: Color(0xFF14395c)),
                                    top: BorderSide(
                                        width: 1.5, color: Color(0xFF14395c)),
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
                                          productSizeList[index].currentQty =
                                              productSizeList[index]
                                                      .currentQty -
                                                  1;
                                        });

                                        // if (isUserLoggedIn) {
                                        //   if ( productSizeList[index].availableQty <= 0) {
                                        //     showCustomSnakebar("Out of stock!");
                                        //   } else if ( productSizeList[index].currentQty <= 1) {
                                        //     showCustomSnakebar(
                                        //         "Quantity Can't be less than 1");
                                        //   } else {
                                        //     print('Minus clicked');
                                        //     setState(() {
                                        //        productSizeList[index].currentQty--;
                                        //     });
                                        //     ProductDetails prodDetail =
                                        //         _productDetailModel
                                        //             .productDetails!;

                                        //     String data = jsonEncode(buildCartMetaData(
                                        //             controller,
                                        //              productSizeList[index].configuredItemsId,
                                        //              productSizeList[index].currentQty,
                                        //             quantityRangeList.isNotEmpty
                                        //                 ? (quantityRangeList[0]
                                        //                             .price!
                                        //                             .originalPrice *
                                        //                         priceFactor)
                                        //                     .round()
                                        //                 : findPriceWithoutQtyRange(
                                        //                     controller,
                                        //                      productSizeList[index].configuredItemsId))
                                        //         .toJson());

                                        //     //Cart Post
                                        //     Get.find<CartController>().cartPost(
                                        //         prodDetail
                                        //             .id!, //id ->Product detail id
                                        //         0, //checked
                                        //         0, //QuantityRanges
                                        //         prodDetail.title!, //Title
                                        //         data, //ItemData
                                        //         0, //minQuantity
                                        //         0, //localDelivery
                                        //         0, //shippingRate
                                        //         0, //BatchLotQuantity
                                        //         prodDetail
                                        //             .nextLotQuantity!, //NextLotQuantity
                                        //         prodDetail.actualWeightInfo!
                                        //             .weight, // ActualWeight
                                        //         prodDetail
                                        //             .firstLotQuantity! //FirstLotQuantity
                                        //         );
                                        //   }
                                        // } else {
                                        //   showCustomSnakebar(
                                        //       'You are not logged in!',
                                        //       title: "Authentication Error!");
                                        // }
                                      },
                                      child: Container(
                                        width: Dimensions.width30,
                                        height: Dimensions.height30,
                                        color: AppColors.btnColorBlueDark,
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
                                          productSizeList[index]
                                              .currentQty
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    //Add Button
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          productSizeList[index].currentQty =
                                              productSizeList[index]
                                                      .currentQty +
                                                  1;
                                        });
                                        // if (isUserLoggedIn) {
                                        //   if ( productSizeList[index].availableQty <= 0) {
                                        //     showCustomSnakebar("Out of stock!");
                                        //   } else {
                                        //     print('Plus clicked');
                                        //     setState(() {
                                        //        productSizeList[index].currentQty++;
                                        //     });

                                        //     ProductDetails prodDetail =
                                        //         _productDetailModel
                                        //             .productDetails!;

                                        //     String data = jsonEncode(buildCartMetaData(
                                        //             controller,
                                        //              productSizeList[index].configuredItemsId,
                                        //              productSizeList[index].currentQty,
                                        //             quantityRangeList.isNotEmpty
                                        //                 ? (quantityRangeList[0]
                                        //                             .price!
                                        //                             .originalPrice *
                                        //                         priceFactor)
                                        //                     .round()
                                        //                 : findPriceWithoutQtyRange(
                                        //                     controller,
                                        //                      productSizeList[index].configuredItemsId))
                                        //         .toJson());

                                        //     print("Data : ${data}");

                                        //     //Cart Post
                                        //     Get.find<CartController>().cartPost(
                                        //         prodDetail
                                        //             .id!, //id ->Product detail id
                                        //         0, //checked
                                        //         0, //QuantityRanges
                                        //         prodDetail.title!, //Title
                                        //         data, //ItemData
                                        //         0, //minQuantity
                                        //         0, //localDelivery
                                        //         0, //shippingRate
                                        //         0, //BatchLotQuantity
                                        //         prodDetail
                                        //             .nextLotQuantity!, //NextLotQuantity
                                        //         prodDetail.actualWeightInfo!
                                        //             .weight, // ActualWeight
                                        //         prodDetail
                                        //             .firstLotQuantity! //FirstLotQuantity
                                        //         );
                                        //   }
                                        // } else {
                                        //   showCustomSnakebar(
                                        //       'You are not logged in!',
                                        //       title: "Authentication Error!");
                                        // }
                                      },
                                      child: Container(
                                        width: Dimensions.width30,
                                        height: Dimensions.height30,
                                        color: AppColors.btnColorBlueDark,
                                        child: const Icon(Icons.add,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: Dimensions.height30,
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    productSizeList[index]
                                        .availableQty
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
              ]);
            },
          ),

          //  productSizeList
          //     .map(
          //       (item) => DataRow(cells: [
          //         DataCell(
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width / 4,
          //             child: Text(item.size, textAlign: TextAlign.center),
          //           ),
          //         ),
          //         DataCell(
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width / 4,
          //             child: Text(
          //                 "৳${quantityRangeList.isNotEmpty ? (quantityRangeList[0].price!.originalPrice * priceFactor).round() : findPriceWithoutQtyRange(controller, item.configuredItemsId)}",
          //                 textAlign: TextAlign.center),
          //           ),
          //         ),
          //         DataCell(
          //           item.selected
          //               ? Center(
          //                   child: SingleChildScrollView(
          //                     scrollDirection: Axis.horizontal,
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: [
          //                         Container(
          //                           width: MediaQuery.of(context).size.width / 4,
          //                           decoration: const BoxDecoration(
          //                             border: Border(
          //                               bottom: BorderSide(
          //                                   width: 1.5, color: Color(0xFF14395c)),
          //                               top: BorderSide(
          //                                   width: 1.5, color: Color(0xFF14395c)),
          //                             ),
          //                             color: Colors.white,
          //                           ),
          //                           child: Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               //Remove Button
          //                               GestureDetector(
          //                                 onTap: () {
          //                                   if (isUserLoggedIn) {
          //                                     if (item.availableQty <= 0) {
          //                                       showCustomSnakebar(
          //                                           "Out of stock!");
          //                                     } else if (item.currentQty <= 1) {
          //                                       showCustomSnakebar(
          //                                           "Quantity Can't be less than 1");
          //                                     } else {
          //                                       print('Minus clicked');
          //                                       setState(() {
          //                                         item.currentQty--;
          //                                       });
          //                                       ProductDetails prodDetail =
          //                                           _productDetailModel
          //                                               .productDetails!;

          //                                       String data = jsonEncode(buildCartMetaData(
          //                                               controller,
          //                                               item.configuredItemsId,
          //                                               item.currentQty,
          //                                               quantityRangeList
          //                                                       .isNotEmpty
          //                                                   ? (quantityRangeList[
          //                                                                   0]
          //                                                               .price!
          //                                                               .originalPrice *
          //                                                           priceFactor)
          //                                                       .round()
          //                                                   : findPriceWithoutQtyRange(
          //                                                       controller,
          //                                                       item.configuredItemsId))
          //                                           .toJson());

          //                                       //Cart Post
          //                                       Get.find<CartController>()
          //                                           .cartPost(
          //                                               prodDetail
          //                                                   .id!, //id ->Product detail id
          //                                               0, //checked
          //                                               0, //QuantityRanges
          //                                               prodDetail.title!, //Title
          //                                               data, //ItemData
          //                                               0, //minQuantity
          //                                               0, //localDelivery
          //                                               0, //shippingRate
          //                                               0, //BatchLotQuantity
          //                                               prodDetail
          //                                                   .nextLotQuantity!, //NextLotQuantity
          //                                               prodDetail
          //                                                   .actualWeightInfo!
          //                                                   .weight, // ActualWeight
          //                                               prodDetail
          //                                                   .firstLotQuantity! //FirstLotQuantity
          //                                               );
          //                                     }
          //                                   } else {
          //                                     showCustomSnakebar(
          //                                         'You are not logged in!',
          //                                         title: "Authentication Error!");
          //                                   }
          //                                 },
          //                                 child: Container(
          //                                   width: Dimensions.width30,
          //                                   height: Dimensions.height30,
          //                                   color: AppColors.btnColorBlueDark,
          //                                   child: const Icon(Icons.remove,
          //                                       color: Colors.white),
          //                                 ),
          //                               ),
          //                               //Quantity
          //                               Container(
          //                                 width: Dimensions.width30,
          //                                 height: Dimensions.height30,
          //                                 color: Colors.white,
          //                                 child: Center(
          //                                   child: Text(
          //                                     item.currentQty.toString(),
          //                                     textAlign: TextAlign.center,
          //                                     style: const TextStyle(
          //                                         color: Colors.black),
          //                                   ),
          //                                 ),
          //                               ),
          //                               //Add Button
          //                               GestureDetector(
          //                                 onTap: () {
          //                                   if (isUserLoggedIn) {
          //                                     if (item.availableQty <= 0) {
          //                                       showCustomSnakebar(
          //                                           "Out of stock!");
          //                                     } else {
          //                                       print('Plus clicked');
          //                                       setState(() {
          //                                         item.currentQty++;
          //                                       });

          //                                       ProductDetails prodDetail =
          //                                           _productDetailModel
          //                                               .productDetails!;

          //                                       String data = jsonEncode(buildCartMetaData(
          //                                               controller,
          //                                               item.configuredItemsId,
          //                                               item.currentQty,
          //                                               quantityRangeList
          //                                                       .isNotEmpty
          //                                                   ? (quantityRangeList[
          //                                                                   0]
          //                                                               .price!
          //                                                               .originalPrice *
          //                                                           priceFactor)
          //                                                       .round()
          //                                                   : findPriceWithoutQtyRange(
          //                                                       controller,
          //                                                       item.configuredItemsId))
          //                                           .toJson());

          //                                       print("Data : ${data}");

          //                                       //Cart Post
          //                                       Get.find<CartController>()
          //                                           .cartPost(
          //                                               prodDetail
          //                                                   .id!, //id ->Product detail id
          //                                               0, //checked
          //                                               0, //QuantityRanges
          //                                               prodDetail.title!, //Title
          //                                               data, //ItemData
          //                                               0, //minQuantity
          //                                               0, //localDelivery
          //                                               0, //shippingRate
          //                                               0, //BatchLotQuantity
          //                                               prodDetail
          //                                                   .nextLotQuantity!, //NextLotQuantity
          //                                               prodDetail
          //                                                   .actualWeightInfo!
          //                                                   .weight, // ActualWeight
          //                                               prodDetail
          //                                                   .firstLotQuantity! //FirstLotQuantity
          //                                               );
          //                                     }
          //                                   } else {
          //                                     showCustomSnakebar(
          //                                         'You are not logged in!',
          //                                         title: "Authentication Error!");
          //                                   }
          //                                 },
          //                                 child: Container(
          //                                   width: Dimensions.width30,
          //                                   height: Dimensions.height30,
          //                                   color: AppColors.btnColorBlueDark,
          //                                   child: const Icon(Icons.add,
          //                                       color: Colors.white),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         Container(
          //                           width: MediaQuery.of(context).size.width / 3,
          //                           height: Dimensions.height30,
          //                           color: Colors.white,
          //                           child: Center(
          //                             child: Text(
          //                               item.availableQty.toString(),
          //                               textAlign: TextAlign.center,
          //                               style:
          //                                   const TextStyle(color: Colors.black),
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 )
          //               : GestureDetector(
          //                   onTap: () {
          //                     updateSelected(item);
          //                   },
          //                   child: Container(
          //                     height: Dimensions.height20 * 2,
          //                     width: MediaQuery.of(context).size.width / 3,
          //                     alignment: Alignment.center,
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(
          //                             Dimensions.radius15 / 3),
          //                         color: AppColors.btnColorBlueDark),
          //                     child: Text(
          //                       'Add',
          //                       style: TextStyle(
          //                           color: Colors.white,
          //                           fontSize: Dimensions.font16,
          //                           fontWeight: FontWeight.w500),
          //                     ),
          //                   ),
          //                 ),
          //         ),
          //       ]),
          //     )
          //     .toList(),
        );
      }
      return CircularProgressIndicator(
        color: Colors.red,
      );
    }

    Widget _miniPriceTable(
        ProductController controller, dynamic price, int available_quantity) {
      return DataTable(
          sortAscending: false,
          dataRowHeight: Dimensions.height20 * 4,
          headingRowColor: MaterialStateProperty.all(AppColors.newBorderColor),
          columnSpacing: 0,
          horizontalMargin: 0,
          showBottomBorder: true,
          border: const TableBorder(
            horizontalInside:
                BorderSide(color: AppColors.newBorderColor, width: 0.7),
            verticalInside:
                BorderSide(color: AppColors.newBorderColor, width: 0.7),
            right: BorderSide(width: 1.0, color: AppColors.newBorderColor),
            left: BorderSide(width: 1.0, color: AppColors.newBorderColor),
          ),
          columns: <DataColumn>[
            DataColumn(
              label: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  'Price (৳)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  'Quantity',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text("৳${(price * priceFactor).round()}",
                        textAlign: TextAlign.center),
                  ),
                ),
                DataCell(
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.5, color: Color(0xFF14395c)),
                                top: BorderSide(
                                    width: 1.5, color: Color(0xFF14395c)),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (isUserLoggedIn) {
                                      if (available_quantity <= 0) {
                                        showCustomSnakebar("Out of stock!");
                                      } else if (getSelectedColorImage()
                                              .currentQuantity <=
                                          1) {
                                        showCustomSnakebar(
                                            "Item quantity can not be less than one!");
                                      } else {
                                        print('Mini Minus clicked');
                                        setState(() {
                                          getSelectedColorImage()
                                              .currentQuantity--;
                                        });

                                        ProductDetails prodDetail =
                                            _productDetailModel.productDetails!;

                                        String data = jsonEncode(buildCartMetaData(
                                                controller,
                                                findConfiguratorID(
                                                    getSelectedColorImage().vid,
                                                    controller),
                                                getSelectedColorImage()
                                                    .currentQuantity,
                                                quantityRangeList.isNotEmpty
                                                    ? (quantityRangeList[0]
                                                                .price!
                                                                .originalPrice *
                                                            priceFactor)
                                                        .round()
                                                    : findPriceWithoutQtyRange(
                                                        controller,
                                                        findConfiguratorID(
                                                            getSelectedColorImage()
                                                                .vid,
                                                            controller)))
                                            .toJson());

                                        //Cart Post
                                        Get.find<CartController>().cartPost(
                                            prodDetail
                                                .id!, //id ->Product detail id
                                            0, //checked
                                            0, //QuantityRanges
                                            prodDetail.title!, //Title
                                            data, //ItemData
                                            0, //minQuantity
                                            0, //localDelivery
                                            0, //shippingRate
                                            0, //BatchLotQuantity
                                            prodDetail
                                                .nextLotQuantity!, //NextLotQuantity
                                            prodDetail.actualWeightInfo!
                                                .weight, // ActualWeight
                                            prodDetail
                                                .firstLotQuantity! //FirstLotQuantity
                                            );
                                      }
                                    } else {
                                      showCustomSnakebar(
                                          'You are not logged in!',
                                          title: "Authentication Error!");
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.width30,
                                    height: Dimensions.height30,
                                    color: const Color(0xFF14395c),
                                    child: const Icon(Icons.remove,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  width: Dimensions.width30,
                                  height: Dimensions.height30,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Text(
                                      getSelectedColorImage()
                                          .currentQuantity
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    width: Dimensions.width30,
                                    height: Dimensions.height30,
                                    color: const Color(0xFF14395c),
                                    child: const Icon(Icons.add,
                                        color: Colors.white),
                                  ),
                                  onTap: () {
                                    if (isUserLoggedIn) {
                                      if (available_quantity <= 0) {
                                        showCustomSnakebar("Out of stock!");
                                      } else {
                                        print('Mini Plus clicked');
                                        setState(() {
                                          getSelectedColorImage()
                                              .currentQuantity++;
                                        });

                                        ProductDetails prodDetail =
                                            _productDetailModel.productDetails!;

                                        String data = jsonEncode(buildCartMetaData(
                                                controller,
                                                findConfiguratorID(
                                                    getSelectedColorImage().vid,
                                                    controller),
                                                getSelectedColorImage()
                                                    .currentQuantity,
                                                quantityRangeList.isNotEmpty
                                                    ? (quantityRangeList[0]
                                                                .price!
                                                                .originalPrice *
                                                            priceFactor)
                                                        .round()
                                                    : findPriceWithoutQtyRange(
                                                        controller,
                                                        findConfiguratorID(
                                                            getSelectedColorImage()
                                                                .vid,
                                                            controller)))
                                            .toJson());

                                        //Cart Post
                                        Get.find<CartController>().cartPost(
                                            prodDetail
                                                .id!, //id ->Product detail id
                                            0, //checked
                                            0, //QuantityRanges
                                            prodDetail.title!, //Title
                                            data, //ItemData
                                            0, //minQuantity
                                            0, //localDelivery
                                            0, //shippingRate
                                            0, //BatchLotQuantity
                                            prodDetail
                                                .nextLotQuantity!, //NextLotQuantity
                                            prodDetail.actualWeightInfo!
                                                .weight, // ActualWeight
                                            prodDetail
                                                .firstLotQuantity! //FirstLotQuantity
                                            );
                                      }
                                    } else {
                                      showCustomSnakebar(
                                          'You are not logged in!',
                                          title: "Authentication Error!");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: Dimensions.height30,
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                available_quantity.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]);
    }

    Widget _buildBody(ProductController productController) {
      ProductDetailModel productDetailModel =
          productController.productDetailModel;
      ProductDetails productDetails = productDetailModel.productDetails!;

      _productDetailModel = productController.productDetailModel;
      largeImage = productController.largeImage;
      smallImageList = productController.smallImageList;
      quantityRangeExist = productController.isQuantityRangeExist;
      quantityRangeList = productController.quantityRangeList;
      colorImgList = productController.colorImageList;
      log("colorImgList : ${colorImgList.first.vid}");
      _myUrl.value = largeImage;
      productSizeList = productController.productSizeList;
      // productSizeList.addAll(productController.productSizeList);

      //print("isSizeExist" +productController.isSizeExist.toString());
      //productSizeList = productController.getSizeListForSpecificColor(colorImgList != null ? colorImgList[0].vid : "");

      return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15,
                    vertical: Dimensions.height15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: Colors.white),
                child: Column(
                  children: [
                    //Product name
                    Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.height15),
                      child: Text(
                        productDetails.title!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.newBorderColor,
                    ),
                    //Product Image Large + small image + Color
                    productController.isSizeQueryFinished
                        ? Column(
                            children: [
                              //Large image
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    border: Border.all(
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                  child: largeImage != ''
                                      ? cachedNetworkImage
                                      : CachedNetworkImage(
                                          imageUrl:
                                              productController.largeImage,
                                          key: ValueKey(largeImage),
                                          height: Dimensions.height50 * 7,
                                          width: double.maxFinite,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Colors.transparent,
                                            height: Dimensions.height50,
                                            width: Dimensions.width50,
                                            child: const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )),
                              SizedBox(height: Dimensions.height20),
                              //Small image
                              smallImageList.isNotEmpty
                                  ? Container(
                                      height: Dimensions.height20 * 4,
                                      color: Colors.white,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              productController.images.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                onButtonPressed(
                                                    smallImageList[index].img!,
                                                    index,
                                                    'small');
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.width10 / 2,
                                                    vertical:
                                                        Dimensions.height10 /
                                                            2),
                                                margin: EdgeInsets.only(
                                                    right: Dimensions.width8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 /
                                                                3),
                                                    border: Border.all(
                                                      color: smallImageList[
                                                                  index]
                                                              .selected
                                                          ? AppColors
                                                              .primaryDark
                                                          : AppColors
                                                              .newBorderColor,
                                                    )),
                                                child: /*Image.network(
                                    smallImageList[index].img!,
                                    fit: BoxFit.cover,
                                    height: Dimensions.height50+Dimensions.height20,
                                    width: Dimensions.width50+Dimensions.width20,
                                  ),*/
                                                    CachedNetworkImage(
                                                  imageUrl:
                                                      smallImageList[index]
                                                          .img!,
                                                  fit: BoxFit.cover,
                                                  height: Dimensions.height50 +
                                                      Dimensions.height20,
                                                  width: Dimensions.width50 +
                                                      Dimensions.width20,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    color: Colors.transparent,
                                                    height: Dimensions.height50,
                                                    width: Dimensions.width50,
                                                    child: const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  : Container(),
                              quantityRangeExist
                                  ? SizedBox(height: Dimensions.height20)
                                  : Container(),
                              //Quantity Range
                              quantityRangeExist
                                  ? Container(
                                      height: Dimensions.height20 * 4,
                                      color: Colors.white,
                                      alignment: Alignment.center,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: quantityRangeList.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  margin: EdgeInsets.only(
                                                      right: Dimensions.width8),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius15 /
                                                              3),
                                                      color: AppColors
                                                          .btnColorBlueDark),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "৳${(quantityRangeList[index].price!.originalPrice * priceFactor).round()}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        "${quantityRangeList[index].minQuantity} or more",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .font14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )
                                  : Container(),
                              SizedBox(height: Dimensions.height20),
                              //Product color
                              productController.attributeList[0].imageUrl !=
                                      null
                                  ? Container(
                                      height: Dimensions.height20 * 6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: Dimensions.width8),
                                            child: Text(
                                              "Color : ${colorName}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: Dimensions.font14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            height: Dimensions.height20 * 4,
                                            color: Colors.white,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                // itemCount: colorImgList.length,
                                                itemCount: colorImgList.length,
                                                itemBuilder: (context, index) {
                                                  // Product size selection table.
                                                  return GestureDetector(
                                                    onTap: () {
                                                      productController
                                                          .getSizeListForSpecificColor(
                                                              colorImgList[
                                                                      index]
                                                                  .vid);
                                                      onButtonPressed(
                                                          colorImgList[index]
                                                              .colorImage,
                                                          index,
                                                          'color');
                                                      setState(() {
                                                        colorName =
                                                            colorImgList[index]
                                                                .colorName;
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      margin: EdgeInsets.only(
                                                          right: Dimensions
                                                              .width10),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                      .radius15 /
                                                                  3),
                                                          border: Border.all(
                                                            color: colorImgList[
                                                                        index]
                                                                    .selected
                                                                ? AppColors
                                                                    .primaryDark
                                                                : AppColors
                                                                    .newBorderColor,
                                                          )),
                                                      child: Image.network(
                                                        colorImgList[index]
                                                            .colorImage,
                                                        fit: BoxFit.cover,
                                                        height: 70,
                                                        width: 70,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : (colorImgList.isNotEmpty
                                      ? Container(
                                          height: Dimensions.height20 * 6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        Dimensions.width8),
                                                child: Text(
                                                  "Color : ${colorName}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          Dimensions.font14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                height: Dimensions.height20 * 4,
                                                color: Colors.white,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        colorImgList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          //productController.getSizeListForSpecificColor(colorImgList[index].vid);
                                                          onButtonPressed(
                                                              colorImgList[
                                                                      index]
                                                                  .colorImage,
                                                              index,
                                                              'color1');
                                                          setState(() {
                                                            colorName =
                                                                colorImgList[
                                                                        index]
                                                                    .colorName;
                                                          });
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions
                                                                      .width10 /
                                                                  2,
                                                              vertical: Dimensions
                                                                      .height10 /
                                                                  2),
                                                          margin: EdgeInsets.only(
                                                              right: Dimensions
                                                                  .width10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions.radius15 /
                                                                              3),
                                                                  border: Border
                                                                      .all(
                                                                    color: colorImgList[
                                                                                index]
                                                                            .selected
                                                                        ? AppColors
                                                                            .primaryDark
                                                                        : AppColors
                                                                            .newBorderColor,
                                                                  )),
                                                          child: Container(
                                                            height: 70,
                                                            width: 70,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              colorImgList[
                                                                      index]
                                                                  .colorName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container()),
                              SizedBox(height: Dimensions.height20),
                              //Product price list
                              productController.isSizeExist
                                  ? Container(
                                      height: productController
                                                  .productSizeList.length *
                                              (Dimensions.height20 * 4) +
                                          Dimensions.height50,
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: priceTableNew(productController),
                                    )
                                  : Container(
                                      height: Dimensions.height100 +
                                          Dimensions.height50 -
                                          Dimensions.height10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0F0F0),
                                      ),
                                      child: _miniPriceTable(
                                          productController,
                                          productDetails.price?.originalPrice,
                                          findMiniPriceTableAvailableQty(
                                              productController,
                                              miniPriceVid()))),
                              productController.isSizeExist
                                  ? SizedBox(height: Dimensions.height20)
                                  : Container(),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.newBorderColor,
                              ),
                              SizedBox(height: Dimensions.height20),
                              //Approximate weight table
                              /*Container(
                          height: Dimensions.height100+Dimensions.height10,
                          width: double.infinity,
                          color: Colors.white,
                          child: _ApproxWeightTable(),
                        ),
                        SizedBox(height: Dimensions.height20),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.newBorderColor,
                        ),
                        SizedBox(height: Dimensions.height20),*/
                              //Shipping Method Dropdown
                              Container(
                                height: Dimensions.height20 * 3,
                                color: Colors.white,
                                child: DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    //Add isDense true and zero Padding.
                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: Text(
                                    dropdownItems[1].toString(),
                                    style:
                                        TextStyle(fontSize: Dimensions.font14),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 60,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: dropdownItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select shipping type';
                                    }
                                  },
                                  onChanged: (value) {
                                    //Do something when changing the item if you want.
                                  },
                                  onSaved: (value) {
                                    dropdownSelectedValue = value.toString();
                                  },
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              GetBuilder<HomeController>(
                                  builder: (homeController) {
                                ShippingText shippingText =
                                    homeController.shippingText;

                                return homeController.isShippingTextLoaded
                                    ? Container(
                                        height: Dimensions.height100 * 4 +
                                            Dimensions.height100 * 7 +
                                            Dimensions.height20 * 8,
                                        width: double.infinity,
                                        padding: EdgeInsets.zero,
                                        child: Column(
                                          children: [
                                            //china_to_bd_bottom_message
                                            Container(
                                              height: Dimensions.height100 +
                                                  Dimensions.height45,
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15 /
                                                            3),
                                                color: const Color(0xFF14395c),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width15,
                                                  vertical:
                                                      Dimensions.height15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    shippingText
                                                        .chinaToBdBottomMessage!,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            Dimensions.font14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: Dimensions.height20),
                                            //china_to_bd_bottom_message_2nd
                                            Container(
                                              height: Dimensions.height20 * 7,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15 /
                                                            3),
                                                color: const Color(0xFF14395c),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width15,
                                                  vertical:
                                                      Dimensions.height15),
                                              child: Text(
                                                shippingText
                                                    .chinaToBdBottomMessage2nd!,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions.font14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            SizedBox(
                                                height: Dimensions.height20),
                                            //approx_weight_message
                                            Container(
                                              height: Dimensions.height20 * 4,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFF14395c),
                                                    width: 1.5,
                                                  )),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width15,
                                                  vertical:
                                                      Dimensions.height15),
                                              child: Text(
                                                shippingText
                                                    .approxWeightMessage!,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: Dimensions.font14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                                height: Dimensions.height20),
                                            //Shipping Table
                                            Container(
                                              height: Dimensions.height100 * 6,
                                              width: double.infinity,
                                              color: Colors.white,
                                              child: _shippingTable(),
                                            ),
                                            SizedBox(
                                                height:
                                                    Dimensions.height20 * 4),
                                            //alertshow0
                                            Container(
                                              height: Dimensions.height20 * 5,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius15 /
                                                              3),
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  border: Border.all(
                                                    color: AppColors
                                                        .btnColorBlueDark,
                                                    width:
                                                        Dimensions.width15 / 10,
                                                  )),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width15,
                                                  vertical:
                                                      Dimensions.height15),
                                              child: Text(
                                                shippingText.alertshow0!,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: Dimensions.font14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      );
                              }),
                              //Shipping Charge Text

                              //SizedBox(height: Dimensions.height20),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.newBorderColor,
                              ),
                              SizedBox(height: Dimensions.height20),
                              //Product Code
                              Container(
                                height: Dimensions.height20 * 8 +
                                    Dimensions.height10,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productDetails.vendorName!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Dimensions.font16,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                    Row(
                                      children: [
                                        Text(
                                          'Product Code : ',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: Dimensions.font14),
                                        ),
                                        Text(
                                          productDetails.id!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Dimensions.font14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                    Row(
                                      children: [
                                        Text(
                                          'Total Sold : ',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: Dimensions.font14),
                                        ),
                                        Text(
                                          productDetails
                                              .featureValues![1].value!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Dimensions.font14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                    Row(
                                      children: [
                                        Text(
                                          'Seller Score : ',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: Dimensions.font14),
                                        ),
                                        Text(
                                          '${productDetails.vendorScore}/20',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Dimensions.font14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.font14),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getSellerStorePage(
                                                productDetails.vendorName!));
                                      },
                                      child: Container(
                                        height: Dimensions.height45,
                                        width: Dimensions.width50 * 3 -
                                            Dimensions.width10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 3),
                                            color: AppColors.primaryColor),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              CupertinoIcons.square_grid_2x2,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                                width: Dimensions.width10 / 2),
                                            Text(
                                              'View Store',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Dimensions.font14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.newBorderColor,
                              ),
                              SizedBox(height: Dimensions.height20),
                              //Social buttons
                              Container(
                                height: Dimensions.height50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: Dimensions.height50,
                                      width: Dimensions.width50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15 / 3),
                                        color: AppColors.shippingTextBg,
                                      ),
                                      child: const Icon(
                                        FontAwesomeIcons.facebookF,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width15),
                                    Container(
                                      height: Dimensions.height50,
                                      width: Dimensions.width50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15 / 3),
                                        color: AppColors.shippingTextBg,
                                      ),
                                      child: const Icon(
                                        FontAwesomeIcons.facebookMessenger,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width15),
                                    Container(
                                      height: Dimensions.height50,
                                      width: Dimensions.width50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15 / 3),
                                        color: CupertinoColors.systemGreen,
                                      ),
                                      child: const Icon(
                                        FontAwesomeIcons.whatsapp,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10 / 2),
              //Extra info
              // Container(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: Dimensions.width15,
              //       vertical: Dimensions.height15),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.only(
              //         topRight: Radius.circular(Dimensions.radius15),
              //         topLeft: Radius.circular(Dimensions.radius15),
              //       ),
              //       color: Colors.white),
              //   child: Column(
              //     children: [
              //       //List
              //       Container(
              //         height: Dimensions.height30 * 7 + Dimensions.height10,
              //         child: Column(
              //           children: [
              //             Container(
              //               height: Dimensions.height200,
              //               color: Colors.white,
              //               child: ListView.builder(
              //                   physics: const NeverScrollableScrollPhysics(),
              //                   itemCount: extraInfoList.length,
              //                   itemBuilder: (context, index) {
              //                     return GestureDetector(
              //                       onTap: () {
              //                         //ExtraInfo data = extraInfoList[index];
              //                         setState(() {
              //                           extraInfoSelectedIndex = index;
              //                         });
              //                       },
              //                       child: Container(
              //                         width: double.infinity,
              //                         child: Column(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             Padding(
              //                               padding: EdgeInsets.only(
              //                                   bottom: Dimensions.width15),
              //                               child: Text(
              //                                 extraInfoList[index].menuName,
              //                                 style: TextStyle(
              //                                   fontSize: Dimensions.font16,
              //                                   fontWeight: FontWeight.w500,
              //                                   color: index ==
              //                                           extraInfoSelectedIndex
              //                                       ? AppColors.primaryColor
              //                                       : Colors.black,
              //                                 ),
              //                               ),
              //                             ),
              //                             Divider(
              //                               height: 1,
              //                               thickness: 2,
              //                               color:
              //                                   index == extraInfoSelectedIndex
              //                                       ? AppColors.primaryColor
              //                                       : Colors.white,
              //                             ),
              //                             SizedBox(
              //                                 height: Dimensions.height10 / 2)
              //                           ],
              //                         ),
              //                       ),
              //                     );
              //                   }),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // if (extraInfoSelectedIndex == 0)
              //   productController.isProductDetailsLoaded
              //       ? _buildSellerProduct(productController)
              //       : CircularProgressIndicator()
              // else if (extraInfoSelectedIndex == 1)
              //   _buildAdditionalInfoContainer(productController)
              // else if (extraInfoSelectedIndex == 3)
              //   _buildSellerInfoContainer(productController)
            ],
          ),
        ),
      );
    }

    Widget _buildBottomNav() {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width15, vertical: Dimensions.height15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Wishlist btn
            GestureDetector(
              onTap: () {
                if (isUserLoggedIn) {
                  wishlistProvider.addToWishlist(
                    _productDetailModel.productDetails!.id!,
                    _productDetailModel.productDetails!.title!,
                    _productDetailModel.productDetails!.mainPictureUrl!,
                    ((_productDetailModel.productDetails!.price!.originalPrice *
                            priceFactor)
                        .round()),
                  );
                } else {
                  showCustomSnakebar('You need to login first!',
                      title: 'Authentication error');
                }
              },
              child: Container(
                height: Dimensions.height20 * 3,
                //width: Dimensions.width30*4,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius15 / 3),
                    color: AppColors.addToCart),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: Dimensions.width10),
                    Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            //cart btn
            GestureDetector(
              onTap: () {
                //Add item to the cart
              },
              child: Container(
                height: Dimensions.height20 * 3,
                //width: Dimensions.width30*4,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius15 / 3),
                    color: AppColors.addToCart),
                child: Center(
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            //buy now btn
            Container(
              height: Dimensions.height20 * 3,
              //width: Dimensions.width30*4,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                  color: AppColors.btnColorBlueDark),
              child: Center(
                child: Text(
                  'Buy Now',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.font16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.pageBg,
          appBar: _buildAppBar(textFieldFocusNode, controller),
          body: GetBuilder<ProductController>(builder: (productController) {
            return productController.isProductDetailsLoaded
                ? _buildBody(productController)
                : const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor));
          }),
          bottomNavigationBar: _buildBottomNav(),
        ),
        onWillPop: () async {
          Get.toNamed(RouteHelper.getInitial());
          return false;
        },
      ),
    );
  }

  updateSelected(ProductSize item) {
    if (productSizeList.isNotEmpty) {
      for (final it in productSizeList) {
        if (item.id == it.id) {
          setState(() {
            it.selected = true;
          });
        } else {
          setState(() {
            it.selected = false;
          });
        }
      }
    }
  }

  Widget _shippingTable() {
    return DataTable(
      sortAscending: false,
      dataRowHeight: Dimensions.height20 * 4,
      headingRowColor: MaterialStateProperty.all(const Color(0xFF14395c)),
      columnSpacing: 0,
      horizontalMargin: 0,
      showBottomBorder: true,
      headingRowHeight: Dimensions.height20 * 4,
      border: const TableBorder(
        right: BorderSide(width: 1.0, color: AppColors.newBorderColor),
        left: BorderSide(width: 1.0, color: AppColors.newBorderColor),
      ),
      columns: <DataColumn>[
        DataColumn(
          label: Container(
            padding: EdgeInsets.only(left: Dimensions.width10),
            width: MediaQuery.of(context).size.width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'From China',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.normal, color: Colors.white),
                ),
                SizedBox(width: Dimensions.width10),
                CachedNetworkImage(
                  imageUrl:
                      "https://media.istockphoto.com/id/586161356/vector/flag-of-the-peoples-republic-of-china.jpg?b=1&s=612x612&w=0&k=20&c=qh98VRiw-sSb-Z1DWpbAaNQ43AV-Dimn3sosglDcYSc=",
                  height: Dimensions.height30,
                  width: Dimensions.width50,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.transparent,
                    height: Dimensions.height20,
                    width: Dimensions.width20,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              ],
            ),
          ),
        ),
        DataColumn(
          label: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'From China',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.normal, color: Colors.white),
                ),
                SizedBox(width: Dimensions.width10),
                CachedNetworkImage(
                  imageUrl:
                      "https://cdn.britannica.com/67/6267-004-10A21DF0/Flag-Bangladesh.jpg",
                  height: Dimensions.height30,
                  width: Dimensions.width50,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.transparent,
                    height: Dimensions.height20,
                    width: Dimensions.width20,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              ],
            ),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                //color: const Color(0xFFfafafa),
                padding: EdgeInsets.only(left: Dimensions.width10),
                width: MediaQuery.of(context).size.width / 2.5,
                child:
                    const Text('Product Quantity', textAlign: TextAlign.start),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text('0.00', textAlign: TextAlign.end),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                padding: EdgeInsets.only(left: Dimensions.width10),
                width: MediaQuery.of(context).size.width / 2.5,
                child: const Text('Product Price', textAlign: TextAlign.start),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text('0.00', textAlign: TextAlign.end),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                padding: EdgeInsets.only(left: Dimensions.width10),
                width: MediaQuery.of(context).size.width / 2.5,
                child: const Text('Approximate Weight',
                    textAlign: TextAlign.start),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text('0.00 KG', textAlign: TextAlign.end),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                padding: EdgeInsets.only(left: Dimensions.width10),
                width: MediaQuery.of(context).size.width / 2.5,
                child:
                    const Text('Shipping Charge', textAlign: TextAlign.start),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text('৳ 630/780 Per kg', textAlign: TextAlign.end),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                padding: EdgeInsets.only(left: Dimensions.width10),
                child: const Text('Total Price', textAlign: TextAlign.start),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text('৳ 0.00 + চায়না লোকাল কুরিয়ার বিল + শিপিং চার্জ',
                    textAlign: TextAlign.end),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                padding: EdgeInsets.only(left: Dimensions.width10),
                width: MediaQuery.of(context).size.width / 2.5,
                child: const Text('Pay Now 50%', textAlign: TextAlign.start),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text('৳ 0.00', textAlign: TextAlign.end),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                padding: EdgeInsets.only(left: Dimensions.width10),
                width: MediaQuery.of(context).size.width / 2.5,
                child:
                    const Text('Pay on Delivery', textAlign: TextAlign.start),
              ),
            ),
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text('৳ 0.00 + শিপিং ', textAlign: TextAlign.end),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _attributeTable(List<Attribute> attributeList) {
    return DataTable(
      sortAscending: false,
      dataRowHeight: Dimensions.height20 * 3,
      headingRowHeight: 0,
      headingRowColor: MaterialStateProperty.all(AppColors.newBorderColor),
      columnSpacing: 0,
      horizontalMargin: 0,
      showBottomBorder: true,
      border: const TableBorder(
        horizontalInside:
            BorderSide(color: AppColors.newBorderColor, width: 0.7),
        verticalInside: BorderSide(color: AppColors.newBorderColor, width: 0.7),
        right: BorderSide(width: 1.0, color: AppColors.newBorderColor),
        left: BorderSide(width: 1.0, color: AppColors.newBorderColor),
      ),
      columns: <DataColumn>[
        DataColumn(
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: const Text(
              '',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: const Text(
              '',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        ),
      ],
      rows: attributeList
          .map(
            (item) => DataRow(
                //color: MaterialStateProperty.all(Colors.green),
                cells: [
                  DataCell(
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      child: Text(
                        item.propertyName!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        item.value!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ]),
          )
          .toList(),
    );
  }

  Widget _buildAdditionalInfoContainer(ProductController controller) {
    return Container(
      height: controller.attributeList.length * (Dimensions.height20 * 3),
      width: double.infinity,
      color: Colors.white,
      child: _attributeTable(controller.attributeList),
    );
  }

  Widget _buildSellerInfoContainer(ProductController controller) {
    return Container(
      height: 8 * (Dimensions.height20 * 3),
      width: double.infinity,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
      child: _sellerInfoTable(
        controller.productDetailModel.productDetails!.vendorName!,
        controller.productDetailModel.productDetails!.vendorId!,
        controller.productDetailModel.productDetails!.vendorDisplayName!,
        controller.productDetailModel.productDetails!.vendorScore!.toString(),
      ),
    );
  }

  Widget _sellerInfoTable(String sellerName, String sellerCode, String shopName,
      String deliveryScore) {
    return DataTable(
      sortAscending: false,
      dataRowHeight: Dimensions.height20 * 4,
      headingRowColor: MaterialStateProperty.all(const Color(0xFF14395c)),
      columnSpacing: 0,
      horizontalMargin: 0,
      showBottomBorder: true,
      headingRowHeight: 0,
      decoration: const BoxDecoration(color: Colors.white),
      border: const TableBorder(
        horizontalInside:
            BorderSide(color: AppColors.newBorderColor, width: 0.7),
        verticalInside: BorderSide(color: AppColors.newBorderColor, width: 0.7),
        right: BorderSide(width: 1.0, color: AppColors.newBorderColor),
        left: BorderSide(width: 1.0, color: AppColors.newBorderColor),
      ),
      columns: const <DataColumn>[
        DataColumn(
          label: Text(''),
        ),
        DataColumn(
          label: Text(''),
        ),
      ],
      rows: <DataRow>[
        //Seller Name
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: const Text('Seller Name'),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Text(sellerName),
              ),
            ),
          ],
        ),
        //Seller ID
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: const Text('Seller ID'),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Text(sellerCode),
              ),
            ),
          ],
        ),
        //Shop Name
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: const Text('Shop Name'),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Text(shopName),
              ),
            ),
          ],
        ),
        //Delivery Score
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: const Text('Delivery Score'),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Text(deliveryScore),
              ),
            ),
          ],
        ),
        //Item Score
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: const Text('Item Score'),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Text('0'),
              ),
            ),
          ],
        ),
        //Service Score
        DataRow(
          cells: <DataCell>[
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: const Text('Service Score', textAlign: TextAlign.start),
              ),
            ),
            DataCell(
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Text('0'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSellerProduct(ProductController productController) {
    return Container(
      height: ((productController.sellerProductList.length / 2) *
              Dimensions.height200) +
          Dimensions.height100,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
      child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          childAspectRatio: 1 / 1.1,
          padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: productController.sellerProductList.map((data) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getSingleProductPage(data.id!));
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(
                      color: AppColors.borderColor,
                      width: 1.0,
                    ),
                    top: BorderSide(
                      color: AppColors.borderColor,
                      width: 1.0,
                    ),
                    left: BorderSide(
                      color: AppColors.borderColor,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10,
                        vertical: Dimensions.height10,
                      ),
                      child: Image.network(
                        data.mainPictureUrl!,
                        height: Dimensions.height20 * 6,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width15,
                          vertical: Dimensions.height10 / 2),
                      child: Text(
                        data.title!,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '৳ ${(data.price?.originalPrice * priceFactor).round()}',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'SOLD: 3242',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }

  Widget _priceTable() {
    return DataTable(
      sortAscending: false,
      /*dataTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),*/
      /*headingTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w600
      ),*/
      dataRowHeight: 80,
      headingRowColor: MaterialStateProperty.all(AppColors.newBorderColor),
      columnSpacing: 0,
      horizontalMargin: 0,
      showBottomBorder: true,
      border: const TableBorder(
        right: BorderSide(width: 1.0, color: AppColors.newBorderColor),
        left: BorderSide(width: 1.0, color: AppColors.newBorderColor),
      ),
      columns: <DataColumn>[
        DataColumn(
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: const Text(
              'Size',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: const Text(
              'Price (৳)',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: const Text(
              'Quantity',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('39', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('609', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                            top: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 30,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            '999',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('40', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('609', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                            top: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 30,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            '999',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('41', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('609', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                            top: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 30,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            '999',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('42', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('609', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                            top: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 30,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            '999',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('43', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('609', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                            top: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 30,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            '999',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('44', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('609', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                            top: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 30,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            '999',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('45', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text('609', textAlign: TextAlign.center),
              ),
            ),
            DataCell(
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                            top: BorderSide(
                                width: 1.5, color: AppColors.primaryColor),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: AppColors.primaryColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 30,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            '999',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _ApproxWeightTable() {
    return DataTable(
      sortAscending: false,
      /*dataTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),*/
      /*headingTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w600
      ),*/
      dataRowHeight: 50,
      headingRowHeight: 60,
      headingRowColor: MaterialStateProperty.all(AppColors.primaryColor),
      columnSpacing: 0,
      horizontalMargin: 0,
      showBottomBorder: true,
      border: const TableBorder(
        right: BorderSide(width: 1.0, color: AppColors.newBorderColor),
        left: BorderSide(width: 1.0, color: AppColors.newBorderColor),
      ),
      columns: <DataColumn>[
        DataColumn(
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
              'Quantity',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontStyle: FontStyle.normal, color: Colors.white),
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
              'Total',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontStyle: FontStyle.normal, color: Colors.white),
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Text(
              'Approx\nWeight',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontStyle: FontStyle.normal, color: Colors.white),
            ),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  '0',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  '৳ 0.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  '0.00 KG',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.normal, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
