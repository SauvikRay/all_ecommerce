import 'dart:convert';

List<CategoryModel> categoryFromJson(String str) =>
    List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  int? id;
  int? serialId;
  String? active;
  String? name;
  String? keyword;
  String? slug;
  String? description;
  String? parentId;
  String? icon;
  String? picture;
  String? otcId;
  String? providerType;
  int? isHidden;
  int? isVirtual;
  int? isParent;
  int? isInternal;
  String? externalId;
  String? metaData;
  String? iconImageUrl;
  String? isTop;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CategoryModel({
    this.id,
    this.serialId,
    this.active,
    this.name,
    this.keyword,
    this.slug,
    this.description,
    this.parentId,
    this.icon,
    this.picture,
    this.otcId,
    this.providerType,
    this.isHidden,
    this.isVirtual,
    this.isParent,
    this.isInternal,
    this.externalId,
    this.metaData,
    this.iconImageUrl,
    this.isTop,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialId = json['serial_id'];
    active = json['active'];
    name = json['name'];
    keyword = json['keyword'];
    slug = json['slug'];
    description = json['description'];
    parentId = json['ParentId'];
    icon = json['icon'];
    picture = json['picture'];
    otcId = json['otc_id'];
    providerType = json['ProviderType'];
    isHidden = json['IsHidden'];
    isVirtual = json['IsVirtual'];
    isParent = json['IsParent'];
    isInternal = json['IsInternal'];
    externalId = json['ExternalId'];
    metaData = json['MetaData'];
    iconImageUrl = json['IconImageUrl'];
    isTop = json['is_top'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_id'] = this.serialId;
    data['active'] = this.active;
    data['name'] = this.name;
    data['keyword'] = this.keyword;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['ParentId'] = this.parentId;
    data['icon'] = this.icon;
    data['picture'] = this.picture;
    data['otc_id'] = this.otcId;
    data['ProviderType'] = this.providerType;
    data['IsHidden'] = this.isHidden;
    data['IsVirtual'] = this.isVirtual;
    data['IsParent'] = this.isParent;
    data['IsInternal'] = this.isInternal;
    data['ExternalId'] = this.externalId;
    data['MetaData'] = this.metaData;
    data['IconImageUrl'] = this.iconImageUrl;
    data['is_top'] = this.isTop;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  @override
  String toString() => toJson().toString();
}