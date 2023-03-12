import 'package:skybuybd/models/home/picture_model.dart';

import '../home/price_model.dart';

class CategoryProductModel {
  List<QuantityRange>? quantityRanges;
  String? id;
  String? errorCode;
  bool? hasError;
  String? providerType;
  String? updatedTime;
  String? title;
  String? originalTitle;
  String? categoryId;
  String? externalCategoryId;
  String? vendorId;
  String? vendorName;
  String? vendorDisplayName;
  int? vendorScore;
  String? taobaoItemUrl;
  String? externalItemUrl;
  String? mainPictureUrl;
  String? stuffStatus;
  int? volume;
  Price? price;
  int? masterQuantity;
  List<Pictures>? pictures;
  Location? location;
  List<FeaturedValues>? featuredValues;
  bool? isSellAllowed;
  PhysicalParameters? physicalParameters;
  bool? isFiltered;

  CategoryProductModel({
    this.quantityRanges,
    this.id,
    this.errorCode,
    this.hasError,
    this.providerType,
    this.updatedTime,
    this.title,
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
    this.isFiltered
  });

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    if (json['QuantityRanges'] != null) {
      quantityRanges = <QuantityRange>[];
      json['QuantityRanges'].forEach((v) {
        quantityRanges!.add(QuantityRange.fromJson(v));
      });
    }
    id = json['Id'];
    errorCode = json['ErrorCode'];
    hasError = json['HasError'];
    providerType = json['ProviderType'];
    updatedTime = json['UpdatedTime'];
    title = json['Title'];
    originalTitle = json['OriginalTitle'];
    categoryId = json['CategoryId'];
    externalCategoryId = json['ExternalCategoryId'];
    vendorId = json['VendorId'];
    vendorName = json['VendorName'];
    vendorDisplayName = json['VendorDisplayName'];
    vendorScore = json['VendorScore'];
    taobaoItemUrl = json['TaobaoItemUrl'];
    externalItemUrl = json['ExternalItemUrl'];
    mainPictureUrl = json['MainPictureUrl'];
    stuffStatus = json['StuffStatus'];
    volume = json['Volume'];
    price = json['Price'] != null ? Price.fromJson(json['Price']) : null;
    masterQuantity = json['MasterQuantity'];
    if (json['Pictures'] != null) {
      pictures = <Pictures>[];
      json['Pictures'].forEach((v) {
        pictures!.add(Pictures.fromJson(v));
      });
    }
    //location = json['Location'] != null ? Location.fromJson(json['Location']) : null;
    if (json['FeaturedValues'] != null) {
      featuredValues = <FeaturedValues>[];
      json['FeaturedValues'].forEach((v) {
        featuredValues!.add(FeaturedValues.fromJson(v));
      });
    }
    isSellAllowed = json['IsSellAllowed'];
    //physicalParameters = json['PhysicalParameters'] != null ? PhysicalParameters.fromJson(json['PhysicalParameters']) : null;
    isFiltered = json['IsFiltered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.quantityRanges != null) {
      data['QuantityRanges'] = this.quantityRanges!.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['ErrorCode'] = this.errorCode;
    data['HasError'] = this.hasError;
    data['ProviderType'] = this.providerType;
    data['UpdatedTime'] = this.updatedTime;
    data['Title'] = this.title;
    data['OriginalTitle'] = this.originalTitle;
    data['CategoryId'] = this.categoryId;
    data['ExternalCategoryId'] = this.externalCategoryId;
    data['VendorId'] = this.vendorId;
    data['VendorName'] = this.vendorName;
    data['VendorDisplayName'] = this.vendorDisplayName;
    data['VendorScore'] = this.vendorScore;
    data['TaobaoItemUrl'] = this.taobaoItemUrl;
    data['ExternalItemUrl'] = this.externalItemUrl;
    data['MainPictureUrl'] = this.mainPictureUrl;
    data['StuffStatus'] = this.stuffStatus;
    data['Volume'] = this.volume;
    if (this.price != null) {
      data['Price'] = this.price!.toJson();
    }
    data['MasterQuantity'] = this.masterQuantity;
    if (this.pictures != null) {
      data['Pictures'] = this.pictures!.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['Location'] = this.location!.toJson();
    }
    if (this.featuredValues != null) {
      data['FeaturedValues'] = this.featuredValues!.map((v) => v.toJson()).toList();
    }
    data['IsSellAllowed'] = this.isSellAllowed;
    if (this.physicalParameters != null) {
      //data['PhysicalParameters'] = this.physicalParameters!.toJson();
    }
    data['IsFiltered'] = this.isFiltered;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

}

class Price {
  dynamic originalPrice;
  dynamic marginPrice;
  String? originalCurrencyCode;
  ConvertedPriceList? convertedPriceList;
  String? convertedPrice;
  String? convertedPriceWithoutSign;
  String? currencySign;
  String? currencyName;
  bool? isDeliverable;
  DeliveryPrice? deliveryPrice;
  DeliveryPrice? oneItemDeliveryPrice;
  DeliveryPrice? priceWithoutDelivery;
  DeliveryPrice? oneItemPriceWithoutDelivery;

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
    this.oneItemPriceWithoutDelivery
  });

  Price.fromJson(Map<String, dynamic> json) {
    originalPrice = json['OriginalPrice'];
    marginPrice = json['MarginPrice'];
    originalCurrencyCode = json['OriginalCurrencyCode'];
    convertedPriceList = json['ConvertedPriceList'] != null ? ConvertedPriceList.fromJson(json['ConvertedPriceList']) : null;
    convertedPrice = json['ConvertedPrice'];
    convertedPriceWithoutSign = json['ConvertedPriceWithoutSign'];
    currencySign = json['CurrencySign'];
    currencyName = json['CurrencyName'];
    isDeliverable = json['IsDeliverable'];
    deliveryPrice = json['DeliveryPrice'] != null ? DeliveryPrice.fromJson(json['DeliveryPrice']) : null;
    oneItemDeliveryPrice = json['OneItemDeliveryPrice'] != null ? DeliveryPrice.fromJson(json['OneItemDeliveryPrice']) : null;
    priceWithoutDelivery = json['PriceWithoutDelivery'] != null ? DeliveryPrice.fromJson(json['PriceWithoutDelivery']) : null;
    oneItemPriceWithoutDelivery = json['OneItemPriceWithoutDelivery'] != null ? DeliveryPrice.fromJson(json['OneItemPriceWithoutDelivery']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OriginalPrice'] = this.originalPrice;
    data['MarginPrice'] = this.marginPrice;
    data['OriginalCurrencyCode'] = this.originalCurrencyCode;
    if (this.convertedPriceList != null) {
      data['ConvertedPriceList'] = this.convertedPriceList!.toJson();
    }
    data['ConvertedPrice'] = this.convertedPrice;
    data['ConvertedPriceWithoutSign'] = this.convertedPriceWithoutSign;
    data['CurrencySign'] = this.currencySign;
    data['CurrencyName'] = this.currencyName;
    data['IsDeliverable'] = this.isDeliverable;
    if (this.deliveryPrice != null) {
      data['DeliveryPrice'] = this.deliveryPrice!.toJson();
    }
    if (this.oneItemDeliveryPrice != null) {
      data['OneItemDeliveryPrice'] = this.oneItemDeliveryPrice!.toJson();
    }
    if (this.priceWithoutDelivery != null) {
      data['PriceWithoutDelivery'] = this.priceWithoutDelivery!.toJson();
    }
    if (this.oneItemPriceWithoutDelivery != null) {
      data['OneItemPriceWithoutDelivery'] =
          this.oneItemPriceWithoutDelivery!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

}

class ConvertedPriceList {
  Internal? internal;
  List<DisplayedMoneys>? displayedMoneys;

  ConvertedPriceList({this.internal, this.displayedMoneys});

  ConvertedPriceList.fromJson(Map<String, dynamic> json) {
    internal = json['Internal'] != null ? Internal.fromJson(json['Internal']) : null;
    if (json['DisplayedMoneys'] != null) {
      displayedMoneys = <DisplayedMoneys>[];
      json['DisplayedMoneys'].forEach((v) {
        displayedMoneys!.add(DisplayedMoneys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.internal != null) {
      data['Internal'] = this.internal!.toJson();
    }
    if (this.displayedMoneys != null) {
      data['DisplayedMoneys'] = this.displayedMoneys!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

}

class Internal {
  dynamic price;
  String? sign;
  String? code;

  Internal({this.price, this.sign, this.code});

  Internal.fromJson(Map<String, dynamic> json) {
    price = json['Price'];
    sign = json['Sign'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Price'] = this.price;
    data['Sign'] = this.sign;
    data['Code'] = this.code;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

}

class DeliveryPrice {
  dynamic originalPrice;
  dynamic marginPrice;
  String? originalCurrencyCode;
  ConvertedPriceList? convertedPriceList;

  DeliveryPrice({
    this.originalPrice,
    this.marginPrice,
    this.originalCurrencyCode,
    this.convertedPriceList
  });

  DeliveryPrice.fromJson(Map<String, dynamic> json) {
    originalPrice = json['OriginalPrice'];
    marginPrice = json['MarginPrice'];
    originalCurrencyCode = json['OriginalCurrencyCode'];
    convertedPriceList = json['ConvertedPriceList'] != null ? ConvertedPriceList.fromJson(json['ConvertedPriceList']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['OriginalPrice'] = this.originalPrice;
    data['MarginPrice'] = this.marginPrice;
    data['OriginalCurrencyCode'] = this.originalCurrencyCode;
    if (this.convertedPriceList != null) {
      data['ConvertedPriceList'] = this.convertedPriceList!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Pictures {
  String? url;
  PictureSize? small;
  PictureSize? medium;
  PictureSize? large;
  bool? isMain;

  Pictures({this.url, this.small, this.medium, this.large, this.isMain});

  Pictures.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    small = json['Small'] != null ? PictureSize.fromJson(json['Small']) : null;
    medium = json['Medium'] != null ? PictureSize.fromJson(json['Medium']) : null;
    large = json['Large'] != null ? PictureSize.fromJson(json['Large']) : null;
    isMain = json['IsMain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Url'] = this.url;
    if (this.small != null) {
      data['Small'] = this.small!.toJson();
    }
    if (this.medium != null) {
      data['Medium'] = this.medium!.toJson();
    }
    if (this.large != null) {
      data['Large'] = this.large!.toJson();
    }
    data['IsMain'] = this.isMain;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

}

class Location {
  String? city;
  String? state;

  Location({this.city, this.state});

  Location.fromJson(Map<String, dynamic> json) {
    city = json['City'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['City'] = this.city;
    data['State'] = this.state;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

}

class FeaturedValues {
  String? name;
  String? value;

  FeaturedValues({this.name, this.value});

  FeaturedValues.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Name'] = this.name;
    data['Value'] = this.value;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class PhysicalParameters {
  dynamic weight;
  dynamic length;
  dynamic width;
  dynamic height;


  PhysicalParameters({required this.weight, required this.length, required this.width, required this.height});

  PhysicalParameters.fromJson(Map<String, dynamic> json) {
    weight = json['Weight'];
    length = json['Length'];
    width = json['Width'];
    width = json['Height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Weight'] = this.weight;
    data['Length'] = this.length;
    data['Width'] = this.width;
    data['Height'] = this.height;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class QuantityRange {
  int? minQuantity;
  Price? price;

  QuantityRange({this.minQuantity, this.price});

  QuantityRange.fromJson(Map<String, dynamic> json) {
    minQuantity = json['MinQuantity'];
    price = json['Price'] != null ? Price.fromJson(json['Price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['MinQuantity'] = this.minQuantity;
    if (this.price != null) {
      data['Price'] = this.price!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
