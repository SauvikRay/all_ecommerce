class PriceModel {
  int? originalPrice;
  int? marginPrice;
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

  PriceModel({
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

  PriceModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
      data['OneItemPriceWithoutDelivery'] = this.oneItemPriceWithoutDelivery!.toJson();
    }
    return data;
  }
}

class ConvertedPriceList {
  Internal? internal;
  List<DisplayedMoneys>? displayedMoneys;

  ConvertedPriceList({this.internal, this.displayedMoneys});

  ConvertedPriceList.fromJson(Map<String, dynamic> json) {
    internal = json['Internal'] != null ? new Internal.fromJson(json['Internal']) : null;
    if (json['DisplayedMoneys'] != null) {
      displayedMoneys = <DisplayedMoneys>[];
      json['DisplayedMoneys'].forEach((v) {
        displayedMoneys!.add(DisplayedMoneys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.internal != null) {
      data['Internal'] = this.internal!.toJson();
    }
    if (this.displayedMoneys != null) {
      data['DisplayedMoneys'] = this.displayedMoneys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Internal {
  int? price;
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
}

class DisplayedMoneys {
  dynamic price;
  String? sign;
  String? code;

  DisplayedMoneys({this.price, this.sign, this.code});

  DisplayedMoneys.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OriginalPrice'] = this.originalPrice;
    data['MarginPrice'] = this.marginPrice;
    data['OriginalCurrencyCode'] = this.originalCurrencyCode;
    if (this.convertedPriceList != null) {
      data['ConvertedPriceList'] = this.convertedPriceList!.toJson();
    }
    return data;
  }
}
