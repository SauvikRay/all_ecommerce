import '../category/category_product_model.dart';
import '../home/picture_model.dart';
import '../home/price_model.dart';
import '../product/product_size.dart';

class ProductDetails {
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
  List<PictureModel>? pictures;
  Location? location;
  List<FeaturedValues>? featureValues;
  bool? isSellAllowed;
  // PhysicalParameters? physicalParameters;
  bool? isFiltered;
  bool? hasInternalDelivery;
  List<DeliveryCost>? deliveryCost;
  List<Attribute>? attributes;
  bool? hasHierarchicalConfigurators;
  List<ConfiguredItems>? configuredItems;
  int? firstLotQuantity;
  int? nextLotQuantity;
  List<WeightInfo>? weightInfo;
  WeightInfo? actualWeightInfo;

  ProductDetails(
      {this.quantityRanges,
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
      this.featureValues,
      this.isSellAllowed,
      // this.physicalParameters,
      this.isFiltered,
      this.hasInternalDelivery,
      this.deliveryCost,
      this.attributes,
      this.hasHierarchicalConfigurators,
      this.configuredItems,
      this.firstLotQuantity,
      this.nextLotQuantity,
      this.weightInfo,
      this.actualWeightInfo});

  ProductDetails.fromJson(Map<String, dynamic> json) {
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
      pictures = <PictureModel>[];
      json['Pictures'].forEach((v) {
        pictures!.add(PictureModel.fromJson(v));
      });
    }
    location =
        json['Location'] != null ? Location.fromJson(json['Location']) : null;
    if (json['FeaturedValues'] != null) {
      featureValues = <FeaturedValues>[];
      json['FeaturedValues'].forEach((v) {
        featureValues!.add(FeaturedValues.fromJson(v));
      });
    }
    isSellAllowed = json['IsSellAllowed'];
    // physicalParameters = json['PhysicalParameters'] != null
    //     ? PhysicalParameters.fromJson(json["PhysicalParameters"])
    //     : null;
    isFiltered = json['IsFiltered'];
    hasInternalDelivery = json['HasInternalDelivery'];
    if (json['DeliveryCosts'] != null) {
      deliveryCost = <DeliveryCost>[];
      json['DeliveryCosts'].forEach((v) {
        deliveryCost!.add(DeliveryCost.fromJson(v));
      });
    }
    if (json['Attributes'] != null) {
      attributes = <Attribute>[];
      json['Attributes'].forEach((v) {
        attributes!.add(Attribute.fromJson(v));
      });
    }
    hasHierarchicalConfigurators = json['HasHierarchicalConfigurators'];
    if (json['ConfiguredItems'] != null) {
      configuredItems = <ConfiguredItems>[];
      json['ConfiguredItems'].forEach((v) {
        configuredItems!.add(ConfiguredItems.fromJson(v));
      });
    }
    firstLotQuantity = json['FirstLotQuantity'];
    nextLotQuantity = json['NextLotQuantity'];
    if (json['WeightInfos'] != null) {
      weightInfo = <WeightInfo>[];
      json['WeightInfos'].forEach((v) {
        weightInfo!.add(WeightInfo.fromJson(v));
      });
    }
    actualWeightInfo = json['ActualWeightInfo'] != null
        ? WeightInfo.fromJson(json["ActualWeightInfo"])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    if (this.quantityRanges != null) {
      data['QuantityRanges'] =
          this.quantityRanges!.map((v) => v.toJson()).toList();
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
    if (this.featureValues != null) {
      data['FeaturedValues'] =
          this.featureValues!.map((v) => v.toJson()).toList();
    }
    data['IsSellAllowed'] = this.isSellAllowed;
    // if (this.physicalParameters != null) {
    //   data['PhysicalParameters'] = this.physicalParameters!.toJson();
    // }
    data['IsFiltered'] = this.isFiltered;
    data['HasInternalDelivery'] = this.hasInternalDelivery;
    if (this.deliveryCost != null) {
      data['DeliveryCosts'] =
          this.deliveryCost!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['Attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['HasHierarchicalConfigurators'] = this.hasHierarchicalConfigurators;
    if (this.configuredItems != null) {
      data['ConfiguredItems'] =
          this.configuredItems!.map((v) => v.toJson()).toList();
    }
    data['FirstLotQuantity'] = this.firstLotQuantity;
    data['NextLotQuantity'] = this.nextLotQuantity;
    if (this.weightInfo != null) {
      data['WeightInfos'] = this.weightInfo!.map((v) => v.toJson()).toList();
    }
    if (this.actualWeightInfo != null) {
      data['ActualWeightInfo'] = this.actualWeightInfo!.toJson();
    }

    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class DeliveryCost {
  String? areaCode;
  String? mode;
  Price? price;
  dynamic startCost;
  int? startWeight;
  int? addWeight;
  int? addCost;

  DeliveryCost(
      {this.areaCode,
      this.mode,
      this.price,
      this.startCost,
      this.startWeight,
      this.addWeight,
      this.addCost});

  DeliveryCost.fromJson(Map<String, dynamic> json) {
    areaCode = json['AreaCode'];
    mode = json['Mode'];
    price = json['Price'] != null ? Price.fromJson(json['Price']) : null;
    startCost = json['StartCost'];
    startWeight = json['StartWeight'];
    addWeight = json['AddWeight'];
    addCost = json['AddCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AreaCode'] = this.areaCode;
    data['Mode'] = this.mode;
    if (this.price != null) {
      data['Price'] = this.price!.toJson();
    }
    data['StartCost'] = this.startCost;
    data['StartWeight'] = this.startWeight;
    data['AddWeight'] = this.addWeight;
    data['AddCost'] = this.addCost;
    return data;
  }
}

class Attribute {
  String? pid;
  String? vid;
  String? propertyName;
  String? value;
  String? originalPropertyName;
  String? originalValue;
  bool? isConfigurator;
  String? imageUrl;
  String? miniImageUrl;

  Attribute(
      {this.pid,
      this.vid,
      this.propertyName,
      this.value,
      this.originalPropertyName,
      this.originalValue,
      this.isConfigurator,
      this.imageUrl,
      this.miniImageUrl});

  Attribute.fromJson(Map<String, dynamic> json) {
    pid = json['Pid'];
    vid = json['Vid'];
    propertyName = json['PropertyName'];
    value = json['Value'];
    originalPropertyName = json['OriginalPropertyName'];
    originalValue = json['OriginalValue'];
    isConfigurator = json['IsConfigurator'];
    imageUrl = json['ImageUrl'];
    miniImageUrl = json['MiniImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pid'] = this.pid;
    data['Vid'] = this.vid;
    data['PropertyName'] = this.propertyName;
    data['Value'] = this.value;
    data['OriginalPropertyName'] = this.originalPropertyName;
    data['OriginalValue'] = this.originalValue;
    data['IsConfigurator'] = this.isConfigurator;
    data['ImageUrl'] = this.imageUrl;
    data['MiniImageUrl'] = this.miniImageUrl;
    return data;
  }
}

class ConfiguredItems {
  String? id;
  int? quantity;
  int? salesCount;
  List<Configurators>? configurators;
  Price? price;
  List<QuantityRanges>? quantityRanges;
  

  ConfiguredItems(
      {this.id,
      this.quantity,
      this.salesCount,
      this.configurators,
      this.price,
      this.quantityRanges,
      });

  ConfiguredItems.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    quantity = json['Quantity'];
    salesCount = json['SalesCount'];
    if (json['Configurators'] != null) {
      configurators = <Configurators>[];
      json['Configurators'].forEach((v) {
        configurators!.add(Configurators.fromJson(v));
      });
    }
    price = json['Price'] != null ? Price.fromJson(json['Price']) : null;
    if (json['QuantityRanges'] != null) {
      quantityRanges = <QuantityRanges>[];
      json['QuantityRanges'].forEach((v) {
        quantityRanges!.add(QuantityRanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Quantity'] = this.quantity;
    data['SalesCount'] = this.salesCount;
    if (this.configurators != null) {
      data['Configurators'] =
          this.configurators!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['Price'] = this.price!.toJson();
    }
    if (this.quantityRanges != null) {
      data['QuantityRanges'] =
          this.quantityRanges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Configurators {
  String? pid;
  String? vid;

  Configurators({this.pid, this.vid});

  Configurators.fromJson(Map<String, dynamic> json) {
    pid = json['Pid'];
    vid = json['Vid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Pid'] = this.pid;
    data['Vid'] = this.vid;
    return data;
  }
}

class ConvertedPriceList {
  Internal? internal;
  List<DisplayedMoneys>? displayedMoneys;

  ConvertedPriceList({this.internal, this.displayedMoneys});

  ConvertedPriceList.fromJson(Map<String, dynamic> json) {
    internal =
        json['Internal'] != null ? Internal.fromJson(json['Internal']) : null;
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
      data['DisplayedMoneys'] =
          this.displayedMoneys!.map((v) => v.toJson()).toList();
    }
    return data;
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
}

class QuantityRanges {
  int? minQuantity;
  Price? price;

  QuantityRanges({this.minQuantity, this.price});

  QuantityRanges.fromJson(Map<String, dynamic> json) {
    minQuantity = json['MinQuantity'];
    price = json['Price'] != null ? new Price.fromJson(json['Price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MinQuantity'] = this.minQuantity;
    if (this.price != null) {
      data['Price'] = this.price!.toJson();
    }
    return data;
  }
}

class WeightInfo {
  String? type;
  String? displayName;
  dynamic weight;

  WeightInfo({this.type, this.displayName, this.weight});

  WeightInfo.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    displayName = json['DisplayName'];
    weight = json['Weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Type'] = this.type;
    data['DisplayName'] = this.displayName;
    data['Weight'] = this.weight;
    return data;
  }
}
