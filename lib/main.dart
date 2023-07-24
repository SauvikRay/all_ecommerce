import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skybuybd/all_model_and_repository/product/product_provider.dart';
import 'package:skybuybd/helper/dependencies.dart' as dep;
import 'package:skybuybd/route/route_helper.dart';
import 'package:skybuybd/utils/constants.dart';

import 'all_model_and_repository/wishlist/wishlist_provider.dart';
import 'new_model.dart';
import 'provider/cart_provider.dart';
import 'provider/category_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<WishlistProvider>(
          create: (context) => WishlistProvider(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.APP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: Footer(),
        initialRoute: RouteHelper.getSplashPage(),
        getPages: RouteHelper.routes,
        // home: Test(),
        //home: HomePage(),
        //home: CategoryPage(parentCatId: 1,catName: 'Baby Items'),
        //home: SingleProductPage(),
        builder: EasyLoading.init(),
      ),
    );

    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: Constants.APP_NAME,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   //home: Footer(),
    //   initialRoute: RouteHelper.getSplashPage(),
    //   getPages: RouteHelper.routes,
    //   //home: AccountPage(),
    //   //home: HomePage(),
    //   //home: CategoryPage(parentCatId: 1,catName: 'Baby Items'),
    //   //home: SingleProductPage(),
    // );
  }
}

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {


// @override
// void initState() {
// getDataFromJson();
//   super.initState();
// }
  
// List<Attribute> attribute=[];
// List<ConfiguredItem> configuredItem=[];
//  List<Configurator> configurators=[];
//     List <Attribute> color=[];
//     List <Attribute> size=[];
//   getDataFromJson()async{
//     String file =await DefaultAssetBundle.of(context).loadString("assets/all_data.json");

//     final data = json.decode(file);
//     ProductDetailsResponse response = ProductDetailsResponse.fromJson(data);
//   ProductDetails  productDetails= response.productDetails;
//   configuredItem = productDetails.configuredItems;
//     // log(productDetails.attributes.first.originalPropertyName.toString());
    
//     //filtering the total attributes based on IsConfigured
//     for(var item in productDetails.attributes){
//       if(item.isConfigurator == true){
//         attribute.add(item);
//       }
//     }
//     // //Attributes length
//     log("Attributes length: ${attribute.length}");
//     log("configuredItem length: ${configuredItem.length}");
  
  
//   for(var attItem in  attribute){
   
//       for(var confItem in configuredItem){
//           if(confItem.configurators.length>=2){
//             // log("Data ${confItem.configurators.length}");
//             if(confItem.configurators[0].vid == attItem.vid && confItem.configurators[0].pid == attItem.pid){
//               // log("${confItem.configurators[0].vid} == ${attItem.vid} && ${confItem.configurators[0].pid} == ${attItem.pid }");
//               // attribute.add(Attribute(pid: attItem.pid,vid:attItem.vid,propertyName:attItem.propertyName,value:attItem.value,originalPropertyName:attItem.originalPropertyName,originalValue:attItem.originalValue,isConfigurator: attItem.isConfigurator,imageUrl:attItem.imageUrl,miniImageUrl: attItem.miniImageUrl ));
            
//             color.add(Attribute(pid: attItem.pid,vid:attItem.vid,propertyName:attItem.propertyName,value:attItem.value,originalPropertyName:attItem.originalPropertyName,originalValue:attItem.originalValue,isConfigurator: attItem.isConfigurator,imageUrl:attItem.imageUrl,miniImageUrl: attItem.miniImageUrl));
//             // log("Color and Sized List : ")            ;
//           } if( (confItem.configurators[1].vid == attItem.vid && confItem.configurators[1].pid == attItem.pid) ){
//                 size.add(Attribute(pid: attItem.pid,vid:attItem.vid,propertyName:attItem.propertyName,value:attItem.value,originalPropertyName:attItem.originalPropertyName,originalValue:attItem.originalValue,isConfigurator: attItem.isConfigurator,imageUrl:attItem.imageUrl,miniImageUrl: attItem.miniImageUrl));
//           }
//         }
//       }
//     }
//         // log("Color and Sized Length :${colorAndSized.length}");
       

// // for(var data in color){
// //   log("All Color: ${data.value}");
// // }
// // for(var data in size){
// //   log("All Color: ${data.value}");
// // }
//       var colorData={};
//  for(var confItem in configuredItem){
//       bool colorMatch=false;
//       bool sizeMatch=false;
//       for(var colorItem in color){
//         if(confItem.configurators[0].vid == colorItem.vid && confItem.configurators[0].pid == colorItem.pid){
//          colorMatch = true;
//          colorData={'colorVid':colorItem.vid,'colorName':colorItem.value};
//           return colorMatch;
//         }
//           break;
//         }
//         log(colorData.toString());
//         for(var sizeItem in size){
//         if(confItem.configurators[1].vid == sizeItem.vid && confItem.configurators[1].pid == sizeItem.pid){
//           sizeMatch =true;
//           return sizeMatch;
//         }
//         break;
//         }
//  }
     
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("sdfsdfdsfsdsd"),),
//     );
//   }
// }

// class ColorWithSizeList{

//   String id;
//   String colorPid;
//   String colorVid;
//   String colorVarientName;
//   String sizePid;
//   String sizeVid;
//   String sizeVarientName;
//   ColorWithSizeList(this.id,this.colorPid,this.colorVid,this.colorVarientName,this.sizePid,this.sizeVid,this.sizeVarientName);

// }
