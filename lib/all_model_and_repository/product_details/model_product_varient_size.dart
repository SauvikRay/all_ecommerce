import 'package:skybuybd/models/product/color_image.dart';

import '../../models/product/product_size.dart';

class FormatedColorAndVarient{
  int id;
  ColorImage colorImage;
  List<ProductSize> colorVarient;
  int totalCountedbyIndex;
  FormatedColorAndVarient(this.id,this.colorImage,this.colorVarient,this.totalCountedbyIndex);
}


// var data =[
//   {
//     'mainId':1,
//     'totalCounted': 0,
//     'colorImage':{
//               'colorId': 11,
//               'currentQuantity': 10,
//               'colorName':'Red',
//               'colorImage':'Red Image',
//               'vid': 'RedVid',
//               'selected': false,
//             },
//     'colorVarient':[
//        {
//         'varientId':111,
//         'size': 'A',
//         'color':'Red A',
//         'availableQty': 10,
//         'currentQty':0,
//         'price': 100,
//         'selected':false,
//        },  
//         {
//         'varientId':112,
//         'size': 'B',
//         'color':'Red B',
//         'availableQty': 10,
//         'currentQty':0,
//         'price': 100,
//         'selected':false,
//        },
//        {
//         'varientId':113,
//         'size': 'C',
//         'color':'Red C',
//         'availableQty': 10,
//         'currentQty':0,
//         'price': 100,
//         'selected':false,
//        },
//     ],
      
//   },
//   {
//     'mainId':2,
//     'totalCounted': 0,
//     'colorImage':{
//               'colorId': 22,
//               'currentQuantity': 10,
//               'colorName':'Black',
//               'colorImage':'Black Image',
//               'vid': 'BlackVid',
//               'selected': false,
//             },
//     'colorVarient':[
//        {
//         'varientId':222,
//         'size': 'A',
//         'color':'Black A',
//         'availableQty': 10,
//         'currentQty':0,
//         'price': 100,
//         'selected':false,
//        },  
//         {
//         'varientId':112,
//         'size': 'B',
//         'color':'Black B',
//         'availableQty': 10,
//         'currentQty':0,
//         'price': 100,
//         'selected':false,
//        },
//        {
//         'varientId':113,
//         'size': 'C',
//         'color':'Black C',
//         'availableQty': 10,
//         'currentQty':0,
//         'price': 100,
//         'selected':false,
//        },
//     ],
      
//   }


// ];