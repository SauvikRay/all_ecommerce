// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

//test comment

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.categoryList,
    this.child,
    this.products,
  });

  CategoryList? categoryList;
  int? child;
  Products? products;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        categoryList: json["categoryList"] == null
            ? null
            : CategoryList.fromJson(json["categoryList"]),
        child: json["child"],
        products: json["products"] == null
            ? null
            : Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "categoryList": categoryList?.toJson(),
        "child": child,
        "products": products?.toJson(),
      };
}

class CategoryList {
  CategoryList({
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
    this.deletedAt,
    this.children,
  });

  int? id;
  int? serialId;
  DateTime? active;
  String? name;
  String? keyword;
  String? slug;
  String? description;
  String? parentId;
  dynamic icon;
  dynamic picture;
  String? otcId;
  dynamic providerType;
  dynamic isHidden;
  dynamic isVirtual;
  dynamic isParent;
  dynamic isInternal;
  dynamic externalId;
  dynamic metaData;
  dynamic iconImageUrl;
  dynamic isTop;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<dynamic>? children;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        serialId: json["serial_id"],
        active: json["active"] == null ? null : DateTime.parse(json["active"]),
        name: json["name"],
        keyword: json["keyword"],
        slug: json["slug"],
        description: json["description"],
        parentId: json["ParentId"],
        icon: json["icon"],
        picture: json["picture"],
        otcId: json["otc_id"],
        providerType: json["ProviderType"],
        isHidden: json["IsHidden"],
        isVirtual: json["IsVirtual"],
        isParent: json["IsParent"],
        isInternal: json["IsInternal"],
        externalId: json["ExternalId"],
        metaData: json["MetaData"],
        iconImageUrl: json["IconImageUrl"],
        isTop: json["is_top"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        children: json["children"] == null
            ? []
            : List<dynamic>.from(json["children"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serial_id": serialId,
        "active": active?.toIso8601String(),
        "name": name,
        "keyword": keyword,
        "slug": slug,
        "description": description,
        "ParentId": parentId,
        "icon": icon,
        "picture": picture,
        "otc_id": otcId,
        "ProviderType": providerType,
        "IsHidden": isHidden,
        "IsVirtual": isVirtual,
        "IsParent": isParent,
        "IsInternal": isInternal,
        "ExternalId": externalId,
        "MetaData": metaData,
        "IconImageUrl": iconImageUrl,
        "is_top": isTop,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "children":
            children == null ? [] : List<dynamic>.from(children!.map((x) => x)),
      };
}

class Products {
  Products({
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
    this.total,
  });

  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.errorCode,
    this.hasError,
    this.providerType,
    this.updatedTime,
    this.title,
    this.isTitleManuallyTranslated,
    this.originalTitle,
    this.categoryId,
    this.externalCategoryId,
    this.vendorId,
    this.vendorName,
    this.vendorDisplayName,
    this.vendorScore,
    this.taobaoItemUrl,
    this.externalItemUrl,
    this.mainPictureUrl,
    this.stuffStatus,
    this.volume,
    this.price,
    this.masterQuantity,
    this.pictures,
    this.location,
    this.featuredValues,
    this.isSellAllowed,
    this.physicalParameters,
    this.isFiltered,
    this.quantityRanges,
    this.createdTime,
    this.brandId,
    this.brandName,
    this.features,
  });

  String? id;
  ErrorCode? errorCode;
  bool? hasError;
  ProviderType? providerType;
  DateTime? updatedTime;
  String? title;
  bool? isTitleManuallyTranslated;
  String? originalTitle;
  CategoryId? categoryId;
  String? externalCategoryId;
  String? vendorId;
  String? vendorName;
  String? vendorDisplayName;
  int? vendorScore;
  String? taobaoItemUrl;
  String? externalItemUrl;
  String? mainPictureUrl;
  StuffStatus? stuffStatus;
  int? volume;
  Price? price;
  int? masterQuantity;
  List<Picture>? pictures;
  Location? location;
  List<FeaturedValue>? featuredValues;
  bool? isSellAllowed;
  dynamic physicalParameters;
  bool? isFiltered;
  List<QuantityRange>? quantityRanges;
  DateTime? createdTime;
  String? brandId;
  String? brandName;
  List<String>? features;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["Id"],
        errorCode: errorCodeValues.map[json["ErrorCode"]]!,
        hasError: json["HasError"],
        providerType: providerTypeValues.map[json["ProviderType"]]!,
        updatedTime: json["UpdatedTime"] == null
            ? null
            : DateTime.parse(json["UpdatedTime"]),
        title: json["Title"],
        isTitleManuallyTranslated: json["IsTitleManuallyTranslated"],
        originalTitle: json["OriginalTitle"],
        categoryId: categoryIdValues.map[json["CategoryId"]],
        externalCategoryId: json["ExternalCategoryId"],
        vendorId: json["VendorId"],
        vendorName: json["VendorName"],
        vendorDisplayName: json["VendorDisplayName"],
        vendorScore: json["VendorScore"],
        taobaoItemUrl: json["TaobaoItemUrl"],
        externalItemUrl: json["ExternalItemUrl"],
        mainPictureUrl: json["MainPictureUrl"],
        stuffStatus: stuffStatusValues.map[json["StuffStatus"]]!,
        volume: json["Volume"],
        price: json["Price"] == null ? null : Price.fromJson(json["Price"]),
        masterQuantity: json["MasterQuantity"],
        pictures: json["Pictures"] == null
            ? []
            : List<Picture>.from(
                json["Pictures"]!.map((x) => Picture.fromJson(x))),
        // location: json["Location"] == null
        //     ? null
        //     : Location.fromJson(json["Location"]),
        featuredValues: json["FeaturedValues"] == null
            ? []
            : List<FeaturedValue>.from(
                json["FeaturedValues"]!.map((x) => FeaturedValue.fromJson(x))),
        isSellAllowed: json["IsSellAllowed"],
        physicalParameters: json["PhysicalParameters"],
        isFiltered: json["IsFiltered"],
        quantityRanges: json["QuantityRanges"] == null
            ? []
            : List<QuantityRange>.from(
                json["QuantityRanges"]!.map((x) => QuantityRange.fromJson(x))),
        createdTime: json["CreatedTime"] == null
            ? null
            : DateTime.parse(json["CreatedTime"]),
        brandId: json["BrandId"],
        brandName: json["BrandName"],
        features: json["Features"] == null
            ? []
            : List<String>.from(json["Features"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ErrorCode": errorCodeValues.reverse[errorCode],
        "HasError": hasError,
        "ProviderType": providerTypeValues.reverse[providerType],
        "UpdatedTime": updatedTime?.toIso8601String(),
        "Title": title,
        "IsTitleManuallyTranslated": isTitleManuallyTranslated,
        "OriginalTitle": originalTitle,
        "CategoryId": categoryIdValues.reverse[categoryId],
        "ExternalCategoryId": externalCategoryId,
        "VendorId": vendorId,
        "VendorName": vendorName,
        "VendorDisplayName": vendorDisplayName,
        "VendorScore": vendorScore,
        "TaobaoItemUrl": taobaoItemUrl,
        "ExternalItemUrl": externalItemUrl,
        "MainPictureUrl": mainPictureUrl,
        "StuffStatus": stuffStatusValues.reverse[stuffStatus],
        "Volume": volume,
        "Price": price?.toJson(),
        "MasterQuantity": masterQuantity,
        "Pictures": pictures == null
            ? []
            : List<dynamic>.from(pictures!.map((x) => x.toJson())),
        "Location": location?.toJson(),
        "FeaturedValues": featuredValues == null
            ? []
            : List<dynamic>.from(featuredValues!.map((x) => x.toJson())),
        "IsSellAllowed": isSellAllowed,
        "PhysicalParameters": physicalParameters,
        "IsFiltered": isFiltered,
        "QuantityRanges": quantityRanges == null
            ? []
            : List<dynamic>.from(quantityRanges!.map((x) => x.toJson())),
        "CreatedTime": createdTime?.toIso8601String(),
        "BrandId": brandId,
        "BrandName": brandName,
        "Features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
      };
}

enum CategoryId {
  ABB_123622002,
  ABB_121880003,
  ABB_201829215,
  ABB_126484005,
  ABB_125388001
}

final categoryIdValues = EnumValues({
  "abb-121880003": CategoryId.ABB_121880003,
  "abb-123622002": CategoryId.ABB_123622002,
  "abb-125388001": CategoryId.ABB_125388001,
  "abb-126484005": CategoryId.ABB_126484005,
  "abb-201829215": CategoryId.ABB_201829215
});

enum ErrorCode { OK }

final errorCodeValues = EnumValues({"Ok": ErrorCode.OK});

class FeaturedValue {
  FeaturedValue({
    this.name,
    this.value,
  });

  Name? name;
  String? value;

  factory FeaturedValue.fromJson(Map<String, dynamic> json) => FeaturedValue(
        name: nameValues.map[json["Name"]],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Name": nameValues.reverse[name],
        "Value": value,
      };
}

enum Name {
  UNIT,
  IS_SKU_OFFER,
  SALES_IN_LAST30_DAYS,
  TOTAL_SALES,
  DESCRIPTION_TOKEN,
  SALE_NUM,
  USER_ID,
  PAY_ORDER30_DAY,
  NORMALIZED_RATING,
  NET_WEIGHT,
  RATING
}

final nameValues = EnumValues({
  "DescriptionToken": Name.DESCRIPTION_TOKEN,
  "IsSkuOffer": Name.IS_SKU_OFFER,
  "netWeight": Name.NET_WEIGHT,
  "normalizedRating": Name.NORMALIZED_RATING,
  "payOrder30Day": Name.PAY_ORDER30_DAY,
  "rating": Name.RATING,
  "SalesInLast30Days": Name.SALES_IN_LAST30_DAYS,
  "saleNum": Name.SALE_NUM,
  "TotalSales": Name.TOTAL_SALES,
  "unit": Name.UNIT,
  "userId": Name.USER_ID
});

class Location {
  Location({
    this.city,
    this.state,
  });

  String? city;
  String? state;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        city: json["City"],
        state: json["State"],
      );

  Map<String, dynamic> toJson() => {
        "City": city,
        "State": state,
      };
}

class PhysicalParametersClass {
  PhysicalParametersClass({
    this.weight,
    this.width,
    this.length,
    this.height,
  });

  double? weight;
  double? width;
  int? length;
  int? height;

  factory PhysicalParametersClass.fromJson(Map<String, dynamic> json) =>
      PhysicalParametersClass(
        weight: json["Weight"]?.toDouble(),
        width: json["Width"]?.toDouble(),
        length: json["Length"],
        height: json["Height"],
      );

  Map<String, dynamic> toJson() => {
        "Weight": weight,
        "Width": width,
        "Length": length,
        "Height": height,
      };
}

class Picture {
  Picture({
    this.url,
    this.small,
    this.medium,
    this.large,
    this.isMain,
  });

  String? url;
  Large? small;
  Large? medium;
  Large? large;
  bool? isMain;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        url: json["Url"],
        small: json["Small"] == null ? null : Large.fromJson(json["Small"]),
        medium: json["Medium"] == null ? null : Large.fromJson(json["Medium"]),
        large: json["Large"] == null ? null : Large.fromJson(json["Large"]),
        isMain: json["IsMain"],
      );

  Map<String, dynamic> toJson() => {
        "Url": url,
        "Small": small?.toJson(),
        "Medium": medium?.toJson(),
        "Large": large?.toJson(),
        "IsMain": isMain,
      };
}

class Large {
  Large({
    this.url,
    this.width,
    this.height,
  });

  String? url;
  int? width;
  int? height;

  factory Large.fromJson(Map<String, dynamic> json) => Large(
        url: json["Url"],
        width: json["Width"],
        height: json["Height"],
      );

  Map<String, dynamic> toJson() => {
        "Url": url,
        "Width": width,
        "Height": height,
      };
}

class Price {
  Price({
    this.originalPrice,
    this.marginPrice,
    this.originalCurrencyCode,
    this.convertedPriceList,
    this.convertedPrice,
    this.convertedPriceWithoutSign,
    this.currencySign,
    this.currencyName,
    this.isDeliverable,
    this.deliveryPrice,
    this.oneItemDeliveryPrice,
    this.priceWithoutDelivery,
    this.oneItemPriceWithoutDelivery,
  });

  dynamic originalPrice;
  dynamic marginPrice;
  CurrencyName? originalCurrencyCode;
  ConvertedPriceList? convertedPriceList;
  String? convertedPrice;
  String? convertedPriceWithoutSign;
  Sign? currencySign;
  CurrencyName? currencyName;
  bool? isDeliverable;
  DeliveryPrice? deliveryPrice;
  DeliveryPrice? oneItemDeliveryPrice;
  DeliveryPrice? priceWithoutDelivery;
  DeliveryPrice? oneItemPriceWithoutDelivery;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        originalPrice: json["OriginalPrice"],
        marginPrice: json["MarginPrice"],
        originalCurrencyCode:
            currencyNameValues.map[json["OriginalCurrencyCode"]]!,
        convertedPriceList: json["ConvertedPriceList"] == null
            ? null
            : ConvertedPriceList.fromJson(json["ConvertedPriceList"]),
        convertedPrice: json["ConvertedPrice"],
        convertedPriceWithoutSign: json["ConvertedPriceWithoutSign"],
        currencySign: signValues.map[json["CurrencySign"]]!,
        currencyName: currencyNameValues.map[json["CurrencyName"]]!,
        isDeliverable: json["IsDeliverable"],
        deliveryPrice: json["DeliveryPrice"] == null
            ? null
            : DeliveryPrice.fromJson(json["DeliveryPrice"]),
        oneItemDeliveryPrice: json["OneItemDeliveryPrice"] == null
            ? null
            : DeliveryPrice.fromJson(json["OneItemDeliveryPrice"]),
        priceWithoutDelivery: json["PriceWithoutDelivery"] == null
            ? null
            : DeliveryPrice.fromJson(json["PriceWithoutDelivery"]),
        oneItemPriceWithoutDelivery: json["OneItemPriceWithoutDelivery"] == null
            ? null
            : DeliveryPrice.fromJson(json["OneItemPriceWithoutDelivery"]),
      );

  Map<String, dynamic> toJson() => {
        "OriginalPrice": originalPrice,
        "MarginPrice": marginPrice,
        "OriginalCurrencyCode":
            currencyNameValues.reverse[originalCurrencyCode],
        "ConvertedPriceList": convertedPriceList?.toJson(),
        "ConvertedPrice": convertedPrice,
        "ConvertedPriceWithoutSign": convertedPriceWithoutSign,
        "CurrencySign": signValues.reverse[currencySign],
        "CurrencyName": currencyNameValues.reverse[currencyName],
        "IsDeliverable": isDeliverable,
        "DeliveryPrice": deliveryPrice?.toJson(),
        "OneItemDeliveryPrice": oneItemDeliveryPrice?.toJson(),
        "PriceWithoutDelivery": priceWithoutDelivery?.toJson(),
        "OneItemPriceWithoutDelivery": oneItemPriceWithoutDelivery?.toJson(),
      };
}

class ConvertedPriceList {
  ConvertedPriceList({
    this.internal,
    this.displayedMoneys,
  });

  Internal? internal;
  List<Internal>? displayedMoneys;

  factory ConvertedPriceList.fromJson(Map<String, dynamic> json) =>
      ConvertedPriceList(
        internal: json["Internal"] == null
            ? null
            : Internal.fromJson(json["Internal"]),
        displayedMoneys: json["DisplayedMoneys"] == null
            ? []
            : List<Internal>.from(
                json["DisplayedMoneys"]!.map((x) => Internal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Internal": internal?.toJson(),
        "DisplayedMoneys": displayedMoneys == null
            ? []
            : List<dynamic>.from(displayedMoneys!.map((x) => x.toJson())),
      };
}

class Internal {
  Internal({
    this.price,
    this.sign,
    this.code,
  });

  dynamic price;
  Sign? sign;
  CurrencyName? code;

  factory Internal.fromJson(Map<String, dynamic> json) => Internal(
        price: json["Price"],
        sign: signValues.map[json["Sign"]]!,
        code: currencyNameValues.map[json["Code"]]!,
      );

  Map<String, dynamic> toJson() => {
        "Price": price,
        "Sign": signValues.reverse[sign],
        "Code": currencyNameValues.reverse[code],
      };
}

enum CurrencyName { CNY }

final currencyNameValues = EnumValues({"CNY": CurrencyName.CNY});

enum Sign { EMPTY }

final signValues = EnumValues({"元": Sign.EMPTY});

class DeliveryPrice {
  DeliveryPrice({
    this.originalPrice,
    this.marginPrice,
    this.originalCurrencyCode,
    this.convertedPriceList,
  });

  dynamic originalPrice;
  dynamic marginPrice;
  CurrencyName? originalCurrencyCode;
  ConvertedPriceList? convertedPriceList;

  factory DeliveryPrice.fromJson(Map<String, dynamic> json) => DeliveryPrice(
        originalPrice: json["OriginalPrice"],
        marginPrice: json["MarginPrice"],
        originalCurrencyCode:
            currencyNameValues.map[json["OriginalCurrencyCode"]]!,
        convertedPriceList: json["ConvertedPriceList"] == null
            ? null
            : ConvertedPriceList.fromJson(json["ConvertedPriceList"]),
      );

  Map<String, dynamic> toJson() => {
        "OriginalPrice": originalPrice,
        "MarginPrice": marginPrice,
        "OriginalCurrencyCode":
            currencyNameValues.reverse[originalCurrencyCode],
        "ConvertedPriceList": convertedPriceList?.toJson(),
      };
}

enum ProviderType { ALIBABA1688 }

final providerTypeValues =
    EnumValues({"Alibaba1688": ProviderType.ALIBABA1688});

class QuantityRange {
  QuantityRange({
    this.minQuantity,
    this.price,
  });

  int? minQuantity;
  Price? price;

  factory QuantityRange.fromJson(Map<String, dynamic> json) => QuantityRange(
        minQuantity: json["MinQuantity"],
        price: json["Price"] == null ? null : Price.fromJson(json["Price"]),
      );

  Map<String, dynamic> toJson() => {
        "MinQuantity": minQuantity,
        "Price": price?.toJson(),
      };
}

enum StuffStatus { NEW }

final stuffStatusValues = EnumValues({"New": StuffStatus.NEW});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
