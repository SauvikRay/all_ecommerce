import 'dart:convert';

SearchResponse searchFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
    SearchResponse({
        required this.items,
    });

    Items items;

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        items: Items.fromJson(json["items"]),
    );

    Map<String, dynamic> toJson() => {
        "items": items.toJson(),
    };
}

class Items {
    Items({
        required this.currentPage,
        required this.searchData,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        this.prevPageUrl,
        required this.to,
        required this.total,
    });

    int currentPage;
    List<SearchData>? searchData;
    String firstPageUrl;
    int? from;
    int lastPage;
    String lastPageUrl;
    String nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        currentPage: json["current_page"],
        searchData: List<SearchData>.from(json["data"].map((x) => SearchData.fromJson(x))),
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
        "data": List<dynamic>.from(searchData!.map((x) => x.toJson())),
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

class SearchData {
    SearchData({
        required this.id,
        required this.errorCode,
        required this.hasError,
        required this.providerType,
        required this.updatedTime,
        required this.title,
        required this.isTitleManuallyTranslated,
        required this.originalTitle,
        required this.categoryId,
        required this.externalCategoryId,
        required this.vendorId,
        required this.vendorName,
        required this.vendorDisplayName,
        required this.vendorScore,
        required this.taobaoItemUrl,
        required this.externalItemUrl,
        required this.mainPictureUrl,
        required this.stuffStatus,
        required this.volume,
        required this.price,
        required this.masterQuantity,
        required this.pictures,
        required this.location,
        required this.featuredValues,
        required this.isSellAllowed,
        required this.physicalParameters,
        required this.isFiltered,
    });

    String id;
    String errorCode;
    bool hasError;
    String providerType;
    DateTime updatedTime;
    String title;
    bool? isTitleManuallyTranslated;
    String originalTitle;
    String categoryId;
    String externalCategoryId;
    String vendorId;
    String vendorName;
    String vendorDisplayName;
    int vendorScore;
    String taobaoItemUrl;
    String externalItemUrl;
    String mainPictureUrl;
    String stuffStatus;
    int volume;
    Price price;
    int masterQuantity;
    List<Picture> pictures;
    Location location;
    List<FeaturedValue> featuredValues;
    bool isSellAllowed;
    dynamic physicalParameters;
    bool isFiltered;

    factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        id: json["Id"],
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        providerType: json["ProviderType"],
        updatedTime: DateTime.parse(json["UpdatedTime"]),
        title: json["Title"],
        isTitleManuallyTranslated: json["IsTitleManuallyTranslated"],
        originalTitle: json["OriginalTitle"],
        categoryId: json["CategoryId"],
        externalCategoryId: json["ExternalCategoryId"],
        vendorId: json["VendorId"],
        vendorName: json["VendorName"],
        vendorDisplayName: json["VendorDisplayName"],
        vendorScore: json["VendorScore"],
        taobaoItemUrl: json["TaobaoItemUrl"],
        externalItemUrl: json["ExternalItemUrl"],
        mainPictureUrl: json["MainPictureUrl"],
        stuffStatus: json["StuffStatus"],
        volume: json["Volume"],
        price: Price.fromJson(json["Price"]),
        masterQuantity: json["MasterQuantity"],
        pictures: List<Picture>.from(json["Pictures"].map((x) => Picture.fromJson(x))),
        location: Location.fromJson(json["Location"]),
        featuredValues: List<FeaturedValue>.from(json["FeaturedValues"].map((x) => FeaturedValue.fromJson(x))),
        isSellAllowed: json["IsSellAllowed"],
        physicalParameters: json["PhysicalParameters"],
        isFiltered: json["IsFiltered"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "ErrorCode": errorCode,
        "HasError": hasError,
        "ProviderType": providerType,
        "UpdatedTime": updatedTime.toIso8601String(),
        "Title": title,
        "IsTitleManuallyTranslated": isTitleManuallyTranslated,
        "OriginalTitle": originalTitle,
        "CategoryId": categoryId,
        "ExternalCategoryId": externalCategoryId,
        "VendorId": vendorId,
        "VendorName": vendorName,
        "VendorDisplayName": vendorDisplayName,
        "VendorScore": vendorScore,
        "TaobaoItemUrl": taobaoItemUrl,
        "ExternalItemUrl": externalItemUrl,
        "MainPictureUrl": mainPictureUrl,
        "StuffStatus": stuffStatus,
        "Volume": volume,
        "Price": price.toJson(),
        "MasterQuantity": masterQuantity,
        "Pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
        "Location": location.toJson(),
        "FeaturedValues": List<dynamic>.from(featuredValues.map((x) => x.toJson())),
        "IsSellAllowed": isSellAllowed,
        "PhysicalParameters": physicalParameters.toJson(),
        "IsFiltered": isFiltered,
    };
}

class FeaturedValue {
    FeaturedValue({
        required this.name,
        required this.value,
    });

    String name;
    String value;

    factory FeaturedValue.fromJson(Map<String, dynamic> json) => FeaturedValue(
        name: json["Name"],
        value: json["Value"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Value": value,
    };
}

class Location {
    Location({
        required this.city,
        required this.state,
    });

    String city;
    String state;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        city: json["City"],
        state: json["State"],
    );

    Map<String, dynamic> toJson() => {
        "City": city,
        "State": state,
    };
}

class PhysicalParameters {
    PhysicalParameters({
        required this.weight,
        required this.width,
    });

    double weight;
    double? width;

    factory PhysicalParameters.fromJson(Map<String, dynamic> json) => PhysicalParameters(
        weight: json["Weight"]?.toDouble(),
        width: json["Width"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Weight": weight,
        "Width": width,
    };
}

class Picture {
    Picture({
        required this.url,
        required this.small,
        required this.medium,
        required this.large,
        required this.isMain,
    });

    String url;
    Large small;
    Large medium;
    Large large;
    bool isMain;

    factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        url: json["Url"],
        small: Large.fromJson(json["Small"]),
        medium: Large.fromJson(json["Medium"]),
        large: Large.fromJson(json["Large"]),
        isMain: json["IsMain"],
    );

    Map<String, dynamic> toJson() => {
        "Url": url,
        "Small": small.toJson(),
        "Medium": medium.toJson(),
        "Large": large.toJson(),
        "IsMain": isMain,
    };
}

class Large {
    Large({
        required this.url,
        required this.width,
        required this.height,
    });

    String url;
    int width;
    int height;

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
    CurrencyName originalCurrencyCode;
    ConvertedPriceList convertedPriceList;
    String convertedPrice;
    String convertedPriceWithoutSign;
    Sign currencySign;
    CurrencyName currencyName;
    bool isDeliverable;
    DeliveryPrice deliveryPrice;
    DeliveryPrice oneItemDeliveryPrice;
    DeliveryPrice priceWithoutDelivery;
    DeliveryPrice oneItemPriceWithoutDelivery;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        originalPrice: json["OriginalPrice"]?.toDouble(),
        marginPrice: json["MarginPrice"]?.toDouble(),
        originalCurrencyCode: currencyNameValues.map[json["OriginalCurrencyCode"]]!,
        convertedPriceList: ConvertedPriceList.fromJson(json["ConvertedPriceList"]),
        convertedPrice: json["ConvertedPrice"],
        convertedPriceWithoutSign: json["ConvertedPriceWithoutSign"],
        currencySign: signValues.map[json["CurrencySign"]]!,
        currencyName: currencyNameValues.map[json["CurrencyName"]]!,
        isDeliverable: json["IsDeliverable"],
        deliveryPrice: DeliveryPrice.fromJson(json["DeliveryPrice"]),
        oneItemDeliveryPrice: DeliveryPrice.fromJson(json["OneItemDeliveryPrice"]),
        priceWithoutDelivery: DeliveryPrice.fromJson(json["PriceWithoutDelivery"]),
        oneItemPriceWithoutDelivery: DeliveryPrice.fromJson(json["OneItemPriceWithoutDelivery"]),
    );

    Map<String, dynamic> toJson() => {
        "OriginalPrice": originalPrice,
        "MarginPrice": marginPrice,
        "OriginalCurrencyCode": currencyNameValues.reverse[originalCurrencyCode],
        "ConvertedPriceList": convertedPriceList.toJson(),
        "ConvertedPrice": convertedPrice,
        "ConvertedPriceWithoutSign": convertedPriceWithoutSign,
        "CurrencySign": signValues.reverse[currencySign],
        "CurrencyName": currencyNameValues.reverse[currencyName],
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
    Sign sign;
    CurrencyName code;

    factory Internal.fromJson(Map<String, dynamic> json) => Internal(
        price: json["Price"]?.toDouble(),
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

final currencyNameValues = EnumValues({
    "CNY": CurrencyName.CNY
});

enum Sign { EMPTY }

final signValues = EnumValues({
    "元": Sign.EMPTY
});

class DeliveryPrice {
    DeliveryPrice({
        required this.originalPrice,
        required this.marginPrice,
        required this.originalCurrencyCode,
        required this.convertedPriceList,
    });

    double originalPrice;
    double marginPrice;
    CurrencyName originalCurrencyCode;
    ConvertedPriceList convertedPriceList;

    factory DeliveryPrice.fromJson(Map<String, dynamic> json) => DeliveryPrice(
        originalPrice: json["OriginalPrice"]?.toDouble(),
        marginPrice: json["MarginPrice"]?.toDouble(),
        originalCurrencyCode: currencyNameValues.map[json["OriginalCurrencyCode"]]!,
        convertedPriceList: ConvertedPriceList.fromJson(json["ConvertedPriceList"]),
    );

    Map<String, dynamic> toJson() => {
        "OriginalPrice": originalPrice,
        "MarginPrice": marginPrice,
        "OriginalCurrencyCode": currencyNameValues.reverse[originalCurrencyCode],
        "ConvertedPriceList": convertedPriceList.toJson(),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}