class RegistrationResponse {
  String? status;
  String? message;
  RegisterData? data;

  RegistrationResponse({ required status, required message, required data}) {
    status = status;
    message = message;
    data = data;
  }

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
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

class RegisterData {
  String? token;
  User? user;

  RegisterData({required token, required user}){
    token = token;
    user = user;
  }

  RegisterData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? uuid;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? fullName;

  User({
    required firstName,
    required lastName,
    required email,
    required uuid,
    required updatedAt,
    required createdAt,
    required id,
    required fullName}){

    firstName = firstName;
    lastName = lastName;
    email = email;
    uuid = uuid;
    updatedAt = updatedAt;
    createdAt = createdAt;
    id = id;
    fullName = fullName;
  }

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    uuid = json['uuid'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['uuid'] = this.uuid;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    return data;
  }
}
