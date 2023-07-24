// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProductDetailsResponse welcomeFromJson(String str) => ProductDetailsResponse.fromJson(json.decode(str));

String welcomeToJson(ProductDetailsResponse data) => json.encode(data.toJson());

class ProductDetailsResponse {
    ProductDetailsResponse({
        required this.productDetails,
    });

    ProductDetails productDetails;

    factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) => ProductDetailsResponse(
        productDetails: ProductDetails.fromJson(json["productDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "productDetails": productDetails.toJson(),
    };
}

class ProductDetails {
    ProductDetails({
        required this.attributes,
        required this.configuredItems,
    });

    List<Attribute> attributes;
    List<ConfiguredItem> configuredItems;

    factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        attributes: List<Attribute>.from(json["Attributes"].map((x) => Attribute.fromJson(x))),
        configuredItems: List<ConfiguredItem>.from(json["ConfiguredItems"].map((x) => ConfiguredItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
        "ConfiguredItems": List<dynamic>.from(configuredItems.map((x) => x.toJson())),
    };
}

class Attribute {
    Attribute({
        required this.pid,
        required this.vid,
        required this.propertyName,
        required this.value,
        required this.originalPropertyName,
        required this.originalValue,
        required this.isConfigurator,
        this.imageUrl,
        this.miniImageUrl,
    });

    String pid;
    String vid;
    String propertyName;
    String value;
    String originalPropertyName;
    String originalValue;
    bool isConfigurator;
    String? imageUrl;
    String? miniImageUrl;

    factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        pid: json["Pid"],
        vid: json["Vid"],
        propertyName: json["PropertyName"],
        value: json["Value"],
        originalPropertyName: json["OriginalPropertyName"],
        originalValue: json["OriginalValue"],
        isConfigurator: json["IsConfigurator"],
        imageUrl: json["ImageUrl"],
        miniImageUrl: json["MiniImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "Pid": pid,
        "Vid": vid,
        "PropertyName": propertyName,
        "Value": value,
        "OriginalPropertyName": originalPropertyName,
        "OriginalValue": originalValue,
        "IsConfigurator": isConfigurator,
        "ImageUrl": imageUrl,
        "MiniImageUrl": miniImageUrl,
    };
}

class ConfiguredItem {
    ConfiguredItem({
        required this.id,
        required this.quantity,
        required this.salesCount,
        required this.configurators,
        required this.price,
    });

    String id;
    int quantity;
    int salesCount;
    List<Configurator> configurators;
    Price price;

    factory ConfiguredItem.fromJson(Map<String, dynamic> json) => ConfiguredItem(
        id: json["Id"],
        quantity: json["Quantity"],
        salesCount: json["SalesCount"],
        configurators: List<Configurator>.from(json["Configurators"].map((x) => Configurator.fromJson(x))),
        price: Price.fromJson(json["Price"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Quantity": quantity,
        "SalesCount": salesCount,
        "Configurators": List<dynamic>.from(configurators.map((x) => x.toJson())),
        "Price": price.toJson(),
    };
}

class Configurator {
    Configurator({
        required this.pid,
        required this.vid,
    });

    String pid;
    String vid;

    factory Configurator.fromJson(Map<String, dynamic> json) => Configurator(
        pid: json["Pid"],
        vid: json["Vid"],
    );

    Map<String, dynamic> toJson() => {
        "Pid": pid,
        "Vid": vid,
    };
}




class Price {
    Price({
        required this.originalPrice,
        required this.marginPrice,
        required this.originalCurrencyCode,
        required this.convertedPriceList,
        required this.convertedPrice,
        required this.convertedPriceWithoutSign,
        required this.currencySign,
        required this.currencyName,
        required this.isDeliverable,
        required this.deliveryPrice,
        required this.oneItemDeliveryPrice,
        required this.priceWithoutDelivery,
        required this.oneItemPriceWithoutDelivery,
    });

    double originalPrice;
    double marginPrice;
    String originalCurrencyCode;
    ConvertedPriceList convertedPriceList;
    String convertedPrice;
    String convertedPriceWithoutSign;
    String currencySign;
    String currencyName;
    bool isDeliverable;
    DeliveryPrice deliveryPrice;
    DeliveryPrice oneItemDeliveryPrice;
    DeliveryPrice priceWithoutDelivery;
    DeliveryPrice oneItemPriceWithoutDelivery;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        originalPrice: json["OriginalPrice"]?.toDouble(),
        marginPrice: json["MarginPrice"]?.toDouble(),
        originalCurrencyCode:json["OriginalCurrencyCode"]!,
        convertedPriceList: ConvertedPriceList.fromJson(json["ConvertedPriceList"]),
        convertedPrice:json["ConvertedPrice"],
        convertedPriceWithoutSign: json["ConvertedPriceWithoutSign"],
        currencySign: json["CurrencySign"],
        currencyName:json["CurrencyName"],
        isDeliverable: json["IsDeliverable"],
        deliveryPrice: DeliveryPrice.fromJson(json["DeliveryPrice"]),
        oneItemDeliveryPrice: DeliveryPrice.fromJson(json["OneItemDeliveryPrice"]),
        priceWithoutDelivery: DeliveryPrice.fromJson(json["PriceWithoutDelivery"]),
        oneItemPriceWithoutDelivery: DeliveryPrice.fromJson(json["OneItemPriceWithoutDelivery"]),
    );

    Map<String, dynamic> toJson() => {
        "OriginalPrice": originalPrice,
        "MarginPrice": marginPrice,
        "OriginalCurrencyCode":originalCurrencyCode,
        "ConvertedPriceList": convertedPriceList.toJson(),
        "ConvertedPrice": convertedPrice,
        "ConvertedPriceWithoutSign": convertedPriceWithoutSign,
        "CurrencySign": currencySign,
        "CurrencyName": currencyName,
        "IsDeliverable": isDeliverable,
        "DeliveryPrice": deliveryPrice.toJson(),
        "OneItemDeliveryPrice": oneItemDeliveryPrice.toJson(),
        "PriceWithoutDelivery": priceWithoutDelivery.toJson(),
        "OneItemPriceWithoutDelivery": oneItemPriceWithoutDelivery.toJson(),
    };
}


class ConvertedPriceList {
    ConvertedPriceList({
        required this.internal,
        required this.displayedMoneys,
    });

    Internal internal;
    List<Internal> displayedMoneys;

    factory ConvertedPriceList.fromJson(Map<String, dynamic> json) => ConvertedPriceList(
        internal: Internal.fromJson(json["Internal"]),
        displayedMoneys: List<Internal>.from(json["DisplayedMoneys"].map((x) => Internal.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Internal": internal.toJson(),
        "DisplayedMoneys": List<dynamic>.from(displayedMoneys.map((x) => x.toJson())),
    };
}

class Internal {
    Internal({
        required this.price,
        required this.sign,
        required this.code,
    });

    double price;
    String sign;
    String code;

    factory Internal.fromJson(Map<String, dynamic> json) => Internal(
        price: json["Price"]?.toDouble(),
        sign: json["Sign"],
        code: json["Code"],
    );

    Map<String, dynamic> toJson() => {
        "Price": price,
        "Sign": sign,
        "Code": code,
    };
}







class DeliveryPrice {
    DeliveryPrice({
        required this.originalPrice,
        required this.marginPrice,
        required this.originalCurrencyCode,
        required this.convertedPriceList,
    });

    double originalPrice;
    double marginPrice;
    String originalCurrencyCode;
    ConvertedPriceList convertedPriceList;

    factory DeliveryPrice.fromJson(Map<String, dynamic> json) => DeliveryPrice(
        originalPrice: json["OriginalPrice"]?.toDouble(),
        marginPrice: json["MarginPrice"]?.toDouble(),
        originalCurrencyCode:json["OriginalCurrencyCode"],
        convertedPriceList: ConvertedPriceList.fromJson(json["ConvertedPriceList"]),
    );

    Map<String, dynamic> toJson() => {
        "OriginalPrice": originalPrice,
        "MarginPrice": marginPrice,
        "OriginalCurrencyCode":originalCurrencyCode,
        "ConvertedPriceList": convertedPriceList.toJson(),
    };
}

