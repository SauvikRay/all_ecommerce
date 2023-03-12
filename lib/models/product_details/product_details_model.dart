import 'package:skybuybd/models/category/category_product_model.dart';
import 'package:skybuybd/models/product_details/product_details.dart';
import 'package:skybuybd/models/product_details/related_product.dart';

class ProductDetailModel{

  ProductDetails? productDetails;
  bool? exitWishList;
  List<RelatedProduct>? relatedProducts;
  List<CategoryProductModel>? SellerProductLists;

  ProductDetailModel({
    this.productDetails,
    this.exitWishList,
    this.relatedProducts,
    this.SellerProductLists
  });

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    productDetails = json['item'] != null ? ProductDetails.fromJson(json["item"]) : null;
    exitWishList = json['exit_wishList'];
    if (json['relatedProducts'] != null) {
      relatedProducts = <RelatedProduct>[];
      json['relatedProducts'].forEach((v) {
        relatedProducts!.add(RelatedProduct.fromJson(v));
      });
    }
    if (json['SellerProductLists'] != null) {
      SellerProductLists = <CategoryProductModel>[];
      json['SellerProductLists'].forEach((v) {
        SellerProductLists!.add(CategoryProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.productDetails != null) {
      data['item'] = this.productDetails!.toJson();
    }
    data['exit_wishList'] = this.exitWishList;
    if (this.relatedProducts != null) {
      data['relatedProducts'] = this.relatedProducts!.map((v) => v.toJson()).toList();
    }
    if (this.SellerProductLists != null) {
      data['SellerProductLists'] = this.SellerProductLists!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

}