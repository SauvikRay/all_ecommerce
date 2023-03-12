import 'package:skybuybd/models/home/picture_model.dart';
import 'package:skybuybd/models/home/price_model.dart';

import 'featured_value_model.dart';

class   RecentProductModel {
  int? currentPage;
  List<RecentProd>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  RecentProductModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total
  });

  RecentProductModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <RecentProd>[];
      json['data'].forEach((v) {
        data!.add(RecentProd.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class RecentProd {
  int? id;
  String? active;
  String? itemId;
  String? providerType;
  String? title;
  String? categoryId;
  String? externalCategoryId;
  String? vendorId;
  String? vendorName;
  int? vendorScore;
  String? brandId;
  String? brandName;
  String? taobaoItemUrl;
  String? externalItemUrl;
  String? mainPictureUrl;
  PriceModel? price;
  List<PictureModel>? pictures;
  List<FeaturedValueModel>? featuredValues;
  int? masterQuantity;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  RecentProd({
    this.id,
    this.active,
    this.itemId,
    this.providerType,
    this.title,
    this.categoryId,
    this.externalCategoryId,
    this.vendorId,
    this.vendorName,
    this.vendorScore,
    this.brandId,
    this.brandName,
    this.taobaoItemUrl,
    this.externalItemUrl,
    this.mainPictureUrl,
    this.price,
    this.pictures,
    this.featuredValues,
    this.masterQuantity,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });

  RecentProd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    itemId = json['ItemId'];
    providerType = json['ProviderType'];
    title = json['Title'];
    categoryId = json['CategoryId'];
    externalCategoryId = json['ExternalCategoryId'];
    vendorId = json['VendorId'];
    vendorName = json['VendorName'];
    vendorScore = json['VendorScore'];
    brandId = json['BrandId'];
    brandName = json['BrandName'];
    taobaoItemUrl = json['TaobaoItemUrl'];
    externalItemUrl = json['ExternalItemUrl'];
    mainPictureUrl = json['MainPictureUrl'];
    price = json['Price'] != null ? PriceModel.fromJson(json['Price']) : null;
    if (json['Pictures'] != null) {
      pictures = <PictureModel>[];
      json['Pictures'].forEach((v) {
        pictures!.add(PictureModel.fromJson(v));
      });
    }
    if (json['FeaturedValues'] != null) {
      featuredValues = <FeaturedValueModel>[];
      json['FeaturedValues'].forEach((v) {
        featuredValues!.add(FeaturedValueModel.fromJson(v));
      });
    }
    masterQuantity = json['MasterQuantity'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['ItemId'] = this.itemId;
    data['ProviderType'] = this.providerType;
    data['Title'] = this.title;
    data['CategoryId'] = this.categoryId;
    data['ExternalCategoryId'] = this.externalCategoryId;
    data['VendorId'] = this.vendorId;
    data['VendorName'] = this.vendorName;
    data['VendorScore'] = this.vendorScore;
    data['BrandId'] = this.brandId;
    data['BrandName'] = this.brandName;
    data['TaobaoItemUrl'] = this.taobaoItemUrl;
    data['ExternalItemUrl'] = this.externalItemUrl;
    data['MainPictureUrl'] = this.mainPictureUrl;
    if (this.price != null) {
      data['Price'] = this.price!.toJson();
    }
    if (this.pictures != null) {
      data['Pictures'] = this.pictures!.map((v) => v.toJson()).toList();
    }
    if (this.featuredValues != null) {
      data['FeaturedValues'] = this.featuredValues!.map((v) => v.toJson()).toList();
    }
    data['MasterQuantity'] = this.masterQuantity;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

}
