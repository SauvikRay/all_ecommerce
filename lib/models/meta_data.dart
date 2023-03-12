import 'package:skybuybd/models/product_details/product_details.dart';

class MetaDatas {
  String? itemCode;
  int? maxQuantity;
  int? quantity;
  int? price;
  int? subTotal;
  String? image;
  List<Attribute>? attributes;
  bool? isChecked;

  MetaDatas({
    required this.itemCode,
    required this.maxQuantity,
    required this.quantity,
    required this.price,
    required this.subTotal,
    required this.image,
    required this.attributes,
    required this.isChecked
  });

  MetaDatas.fromJson(Map<String, dynamic> json) {
    itemCode = json['itemCode'];
    maxQuantity = json['maxQuantity'];
    quantity = json['quantity'];
    price = json['price'];
    subTotal = json['subTotal'];
    image = json['image'];
    if (json['attributes'] != null) {
      attributes = <Attribute>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attribute.fromJson(v));
      });
    }
    isChecked = json['isChecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['itemCode'] = this.itemCode;
    data['maxQuantity'] = this.maxQuantity;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['subTotal'] = this.subTotal;
    data['image'] = this.image;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['isChecked'] = this.isChecked;
    return data;
  }
}
