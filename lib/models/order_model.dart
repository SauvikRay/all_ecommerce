import 'package:skybuybd/models/category/category_product_model.dart';

class OrderModel {
  String? status;
  Data? data;

  OrderModel({this.status, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Order>? result;
  int? totalOrders;

  Data({this.result, this.totalOrders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Order>[];
      json['result'].forEach((v) {
        result!.add(Order.fromJson(v));
      });
    }
    totalOrders = json['total_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['total_orders'] = this.totalOrders;
    return data;
  }
}

class Order {
  int? id;
  String? orderNumber;
  String? name;
  String? email;
  String? phone;
  int? amount;
  int? needToPay;
  int? dueForProducts;
  String? status;
  String? transactionId;
  String? payMethod;
  String? bkashPaymentId;
  String? bkashTrxId;
  String? bkashRefundTrxId;
  String? currency;
  String? couponCode;
  String? couponVictory;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? orderItemsCount;
  List<OrderItems>? orderItems;
  User? user;

  Order(
      {this.id,
        this.orderNumber,
        this.name,
        this.email,
        this.phone,
        this.amount,
        this.needToPay,
        this.dueForProducts,
        this.status,
        this.transactionId,
        this.payMethod,
        this.bkashPaymentId,
        this.bkashTrxId,
        this.bkashRefundTrxId,
        this.currency,
        this.couponCode,
        this.couponVictory,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.orderItemsCount,
        this.orderItems,
        this.user});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    amount = json['amount'];
    needToPay = json['needToPay'];
    dueForProducts = json['dueForProducts'];
    status = json['status'];
    transactionId = json['transaction_id'];
    payMethod = json['pay_method'];
    bkashPaymentId = json['bkash_payment_id'];
    bkashTrxId = json['bkash_trx_id'];
    bkashRefundTrxId = json['bkash_refund_trx_id'];
    currency = json['currency'];
    couponCode = json['coupon_code'];
    couponVictory = json['coupon_victory'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    orderItemsCount = json['order_items_count'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['amount'] = this.amount;
    data['needToPay'] = this.needToPay;
    data['dueForProducts'] = this.dueForProducts;
    data['status'] = this.status;
    data['transaction_id'] = this.transactionId;
    data['pay_method'] = this.payMethod;
    data['bkash_payment_id'] = this.bkashPaymentId;
    data['bkash_trx_id'] = this.bkashTrxId;
    data['bkash_refund_trx_id'] = this.bkashRefundTrxId;
    data['currency'] = this.currency;
    data['coupon_code'] = this.couponCode;
    data['coupon_victory'] = this.couponVictory;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['order_items_count'] = this.orderItemsCount;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class OrderItems {
  int? id;
  String? orderItemNumber;
  int? orderId;
  int? productId;
  String? name;
  String? link;
  String? image;
  String? shippingFrom;
  String? shippedBy;
  int? shippingRate;
  String? shippingMark;
  String? approxWeight;
  int? chinaLocalDelivery;
  String? chinaLocalDeliveryRmb;
  String? orderNumber;
  String? orderItemRmb;
  String? productType;
  String? trackingNumber;
  String? cbm;
  String? cartonId;
  String? chnWarehouseWeight;
  String? chnWarehouseQty;
  int? actualWeight;
  int? quantity;
  int? productValue;
  String? purchaseCostBd;
  String? purchaseRmb;
  String? productBdReceivedCost;
  dynamic firstPayment;
  String? couponContribution;
  int? shippingCharge;
  String? courierBill;
  String? outOfStock;
  String? outOfStockType;
  String? missing;
  String? adjustment;
  String? refunded;
  String? lastPayment;
  int? duePayment;
  String? invoiceNo;
  String? status;
  int? step;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  OrderItems(
      {this.id,
        this.orderItemNumber,
        this.orderId,
        this.productId,
        this.name,
        this.link,
        this.image,
        this.shippingFrom,
        this.shippedBy,
        this.shippingRate,
        this.shippingMark,
        this.approxWeight,
        this.chinaLocalDelivery,
        this.chinaLocalDeliveryRmb,
        this.orderNumber,
        this.orderItemRmb,
        this.productType,
        this.trackingNumber,
        this.cbm,
        this.cartonId,
        this.chnWarehouseWeight,
        this.chnWarehouseQty,
        this.actualWeight,
        this.quantity,
        this.productValue,
        this.purchaseCostBd,
        this.purchaseRmb,
        this.productBdReceivedCost,
        this.firstPayment,
        this.couponContribution,
        this.shippingCharge,
        this.courierBill,
        this.outOfStock,
        this.outOfStockType,
        this.missing,
        this.adjustment,
        this.refunded,
        this.lastPayment,
        this.duePayment,
        this.invoiceNo,
        this.status,
        this.step,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderItemNumber = json['order_item_number'];
    orderId = json['order_id'];
    productId = json['product_id'];
    name = json['name'];
    link = json['link'];
    image = json['image'];
    shippingFrom = json['shipping_from'];
    shippedBy = json['shipped_by'];
    shippingRate = json['shipping_rate'];
    shippingMark = json['shipping_mark'];
    approxWeight = json['approxWeight'];
    chinaLocalDelivery = json['chinaLocalDelivery'];
    chinaLocalDeliveryRmb = json['china_local_delivery_rmb'];
    orderNumber = json['order_number'];
    orderItemRmb = json['order_item_rmb'];
    productType = json['product_type'];
    trackingNumber = json['tracking_number'];
    cbm = json['cbm'];
    cartonId = json['carton_id'];
    chnWarehouseWeight = json['chn_warehouse_weight'];
    chnWarehouseQty = json['chn_warehouse_qty'];
    actualWeight = json['actual_weight'];
    quantity = json['quantity'];
    productValue = json['product_value'];
    purchaseCostBd = json['purchase_cost_bd'];
    purchaseRmb = json['purchase_rmb'];
    productBdReceivedCost = json['product_bd_received_cost'];
    firstPayment = json['first_payment'];
    couponContribution = json['coupon_contribution'];
    shippingCharge = json['shipping_charge'];
    courierBill = json['courier_bill'];
    outOfStock = json['out_of_stock'];
    outOfStockType = json['out_of_stock_type'];
    missing = json['missing'];
    adjustment = json['adjustment'];
    refunded = json['refunded'];
    lastPayment = json['last_payment'];
    duePayment = json['due_payment'];
    invoiceNo = json['invoice_no'];
    status = json['status'];
    step = json['step'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_item_number'] = this.orderItemNumber;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['link'] = this.link;
    data['image'] = this.image;
    data['shipping_from'] = this.shippingFrom;
    data['shipped_by'] = this.shippedBy;
    data['shipping_rate'] = this.shippingRate;
    data['shipping_mark'] = this.shippingMark;
    data['approxWeight'] = this.approxWeight;
    data['chinaLocalDelivery'] = this.chinaLocalDelivery;
    data['china_local_delivery_rmb'] = this.chinaLocalDeliveryRmb;
    data['order_number'] = this.orderNumber;
    data['order_item_rmb'] = this.orderItemRmb;
    data['product_type'] = this.productType;
    data['tracking_number'] = this.trackingNumber;
    data['cbm'] = this.cbm;
    data['carton_id'] = this.cartonId;
    data['chn_warehouse_weight'] = this.chnWarehouseWeight;
    data['chn_warehouse_qty'] = this.chnWarehouseQty;
    data['actual_weight'] = this.actualWeight;
    data['quantity'] = this.quantity;
    data['product_value'] = this.productValue;
    data['purchase_cost_bd'] = this.purchaseCostBd;
    data['purchase_rmb'] = this.purchaseRmb;
    data['product_bd_received_cost'] = this.productBdReceivedCost;
    data['first_payment'] = this.firstPayment;
    data['coupon_contribution'] = this.couponContribution;
    data['shipping_charge'] = this.shippingCharge;
    data['courier_bill'] = this.courierBill;
    data['out_of_stock'] = this.outOfStock;
    data['out_of_stock_type'] = this.outOfStockType;
    data['missing'] = this.missing;
    data['adjustment'] = this.adjustment;
    data['refunded'] = this.refunded;
    data['last_payment'] = this.lastPayment;
    data['due_payment'] = this.duePayment;
    data['invoice_no'] = this.invoiceNo;
    data['status'] = this.status;
    data['step'] = this.step;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class User {
  int? id;
  String? uuid;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? otpCode;
  int? shippingId;
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

  User(
      {this.id,
        this.uuid,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.otpCode,
        this.shippingId,
        this.billingId,
        this.avatarType,
        this.avatarLocation,
        this.apiToken,
        this.passwordChangedAt,
        this.active,
        this.confirmationCode,
        this.confirmed,
        this.timezone,
        this.lastLoginAt,
        this.lastLoginIp,
        this.toBeLoggedOut,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.fullName});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['otp_code'] = this.otpCode;
    data['shipping_id'] = this.shippingId;
    data['billing_id'] = this.billingId;
    data['avatar_type'] = this.avatarType;
    data['avatar_location'] = this.avatarLocation;
    data['api_token'] = this.apiToken;
    data['password_changed_at'] = this.passwordChangedAt;
    data['active'] = this.active;
    data['confirmation_code'] = this.confirmationCode;
    data['confirmed'] = this.confirmed;
    data['timezone'] = this.timezone;
    data['last_login_at'] = this.lastLoginAt;
    data['last_login_ip'] = this.lastLoginIp;
    data['to_be_logged_out'] = this.toBeLoggedOut;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['full_name'] = this.fullName;
    return data;
  }
}