import 'Roles.dart';

class User {
  int? id;
  String? uuid;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? otpCode;
  dynamic shippingId;
  String? billingId;
  String? avatarType;
  String? avatarLocation;
  String? apiToken;
  String? passwordChangedAt;
  bool? active;
  String? confirmationCode;
  bool? confirmed;
  String? timezone;
  String? lastLoginAt;
  String? lastLoginIp;
  bool? toBeLoggedOut;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? fullName;
  List<Roles>? _roles;
  List<Roles> get roles => _roles!;

  User({
    required id,
    required uuid,
    required name,
    required firstName,
    required lastName,
    required email,
    required phone,
    required otpCode,
    required shippingId,
    required billingId,
    required avatarType,
    required  avatarLocation,
    required apiToken,
    required passwordChangedAt,
    required active,
    required confirmationCode,
    required confirmed,
    required timezone,
    required lastLoginAt,
    required lastLoginIp,
    required toBeLoggedOut,
    required createdAt,
    required updatedAt,
    required deletedAt,
    required fullName,
    required roles
  }){
    this.id = id;
    this.uuid = uuid;
    this.name = name;
    this.firstName =  firstName;
    this.lastName = lastName;
    this.email = email;
    this.phone = phone;
    this.otpCode = otpCode;
    this.shippingId = shippingId;
    this.billingId = billingId;
    this.avatarType = avatarType;
    this.avatarLocation = avatarLocation;
    this.apiToken = apiToken;
    this.passwordChangedAt = passwordChangedAt;
    this.active = active;
    this.confirmationCode = confirmationCode;
    this.confirmed = confirmed;
    this.timezone = timezone;
    this.lastLoginAt = lastLoginAt;
    this.lastLoginIp = lastLoginIp;
    this.toBeLoggedOut = toBeLoggedOut;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.deletedAt = deletedAt;
    this.fullName = fullName;
    this._roles = roles;
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    otpCode = json['otp_code'];
    shippingId = json['shipping_id'];
    billingId = json['billing_id'];
    avatarType = json['avatar_type'];
    avatarLocation = json['avatar_location'];
    apiToken = json['api_token'];
    passwordChangedAt = json['password_changed_at'];
    active = json['active'];
    confirmationCode = json['confirmation_code'];
    confirmed = json['confirmed'];
    timezone = json['timezone'];
    lastLoginAt = json['last_login_at'];
    lastLoginIp = json['last_login_ip'];
    toBeLoggedOut = json['to_be_logged_out'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    fullName = json['full_name'];
    if (json['roles'] != null) {
      _roles = <Roles>[];
      json['roles'].forEach((v) {
        _roles!.add(Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : this.id,
      'uuid' : this.uuid,
      'name' : this.name,
      'first_name' : this.firstName,
      'last_name' : this.lastName,
      'email' : this.email,
      'phone' : this.phone,
      'otp_code' : this.otpCode,
      'shipping_id' : this.shippingId,
      'billing_id' : this.billingId,
      'avatar_type' : this.avatarType,
      'avatar_location' : this.avatarLocation,
      'api_token' : this.apiToken,
      'password_changed_at' : this.passwordChangedAt,
      'active' : this.active,
      'confirmation_code' : this.confirmationCode,
      'confirmed' : this.confirmed,
      'timezone' : this.timezone,
      'last_login_at' : this.lastLoginAt,
      'last_login_ip' : this.lastLoginIp,
      'to_be_logged_out' : this.toBeLoggedOut,
      'created_at' : this.createdAt,
      'updated_at' : this.updatedAt,
      'deleted_at' : this.deletedAt,
      'full_name' : this.fullName,
    };
  }

}