import 'package:skybuybd/models/meta_data.dart';

import 'category/category_product_model.dart';

class CartModel {
  bool? status;
  List<Cart>? cart;

  CartModel({this.status, this.cart});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  //List<String>? actualWeightInfo;
  String? id;
  //dynamic quantityRanges;
  bool? isCart;
  String? title;
  MetaDatas? itemData;
  int? localDelivery;
  String? shippedBy;
  int? shippingRate;
  int? batchLotQuantity;
  int? nextLotQuantity;
  dynamic actualWeight;
  int? firstLotQuantity;
  bool? checked;

  Cart({
    //this.actualWeightInfo,
    this.id,
    //this.quantityRanges,
    this.isCart,
    this.title,
    this.itemData,
    this.localDelivery,
    this.shippedBy,
    this.shippingRate,
    this.batchLotQuantity,
    this.nextLotQuantity,
    this.actualWeight,
    this.firstLotQuantity,
    this.checked
  });

  Cart.fromJson(Map<String, dynamic> json) {
    /*if (json['ActualWeightInfo'] != null) {
      actualWeightInfo = <String>[];
      json['ActualWeightInfo'].forEach((v) {
        actualWeightInfo!.add(new String.fromJson(v));
      });
    }*/
    id = json['Id'];
    //quantityRanges = json['QuantityRanges'];
    isCart = json['isCart'];
    title = json['Title'];
    itemData = json['itemData'] != null ? MetaDatas.fromJson(json['itemData']) : null;
    localDelivery = json['localDelivery'];
    shippedBy = json['shipped_by'];
    shippingRate = json['shippingRate'];
    batchLotQuantity = json['BatchLotQuantity'];
    nextLotQuantity = json['NextLotQuantity'];
    actualWeight = json['ActualWeight'];
    firstLotQuantity = json['FirstLotQuantity'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    /*if (this.actualWeightInfo != null) {
      data['ActualWeightInfo'] = this.actualWeightInfo!.map((v) => v.toJson()).toList();
    }*/
    data['Id'] = this.id;
    //data['QuantityRanges'] = this.quantityRanges;
    data['isCart'] = this.isCart;
    data['Title'] = this.title;
    if (this.itemData != null) {
      data['itemData'] = this.itemData!.toJson();
    }
    data['localDelivery'] = this.localDelivery;
    data['shipped_by'] = this.shippedBy;
    data['shippingRate'] = this.shippingRate;
    data['BatchLotQuantity'] = this.batchLotQuantity;
    data['NextLotQuantity'] = this.nextLotQuantity;
    data['ActualWeight'] = this.actualWeight;
    data['FirstLotQuantity'] = this.firstLotQuantity;
    data['checked'] = this.checked;
    return data;
  }
}

