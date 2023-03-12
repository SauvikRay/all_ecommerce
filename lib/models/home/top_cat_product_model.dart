class TopCategoryProductModel {
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
  int? masterQuantity;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  TopCategoryProductModel({
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
    this.masterQuantity,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });

  TopCategoryProductModel.fromJson(Map<String, dynamic> json) {
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
