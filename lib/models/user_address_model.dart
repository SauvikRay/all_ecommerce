class UserAddressModel {
  String? status;
  String? message;
  Data? data;

  UserAddressModel({this.status, this.message, this.data});

  UserAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<UserAddress>? result;

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <UserAddress>[];
      json['result'].forEach((v) {
        result!.add(UserAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAddress {
  int? id;
  String? name;
  String? phoneOne;
  String? phoneTwo;
  String? phoneThree;
  String? address;
  String? areaId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  UserAddress(
      {this.id,
        this.name,
        this.phoneOne,
        this.phoneTwo,
        this.phoneThree,
        this.address,
        this.areaId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneOne = json['phone_one'];
    phoneTwo = json['phone_two'];
    phoneThree = json['phone_three'];
    address = json['address'];
    areaId = json['area_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_one'] = this.phoneOne;
    data['phone_two'] = this.phoneTwo;
    data['phone_three'] = this.phoneThree;
    data['address'] = this.address;
    data['area_id'] = this.areaId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}