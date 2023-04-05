// To parse this JSON data, do
//
//     final wishlistResponse = wishlistResponseFromJson(jsonString);

import 'dart:convert';

WishlistResponse wishlistResponseFromJson(String str) =>
    WishlistResponse.fromJson(json.decode(str));

String wishlistResponseToJson(WishlistResponse data) =>
    json.encode(data.toJson());

class WishlistResponse {
  WishlistResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  dynamic message;
  List<Datum>? data;

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      WishlistResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.itemId,
    this.title,
    this.mainPictureUrl,
    this.originalPrice,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? itemId;
  String? title;
  String? mainPictureUrl;
  int? originalPrice;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        itemId: json["ItemId"],
        title: json["Title"],
        mainPictureUrl: json["MainPictureUrl"],
        originalPrice: json["OriginalPrice"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ItemId": itemId,
        "Title": title,
        "MainPictureUrl": mainPictureUrl,
        "OriginalPrice": originalPrice,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
