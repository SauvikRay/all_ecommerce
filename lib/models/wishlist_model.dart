class WishListModel {
  dynamic status;
  String? message;
  List<Wishlist>? data;

  WishListModel({this.status, this.message, this.data});

  WishListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['wishlist'] != null) {
      data = <Wishlist>[];
      json['wishlist'].forEach((v) {
        data!.add(Wishlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['wishlist'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class Wishlist {
  int? id;
  String? itemId;
  String? title;
  String? mainPictureUrl;
  int? originalPrice;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Wishlist({
    this.id,
    this.itemId,
    this.title,
    this.mainPictureUrl,
    this.originalPrice,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['ItemId'];
    title = json['Title'];
    mainPictureUrl = json['MainPictureUrl'];
    originalPrice = json['OriginalPrice'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['ItemId'] = this.itemId;
    data['Title'] = this.title;
    data['MainPictureUrl'] = this.mainPictureUrl;
    data['OriginalPrice'] = this.originalPrice;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}