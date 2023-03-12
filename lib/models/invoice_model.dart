class InvoiceModel {
  String? status;
  String? message;
  Data? data;

  InvoiceModel({this.status, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] ?? '';
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
  List<Invoice>? result;

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Invoice>[];
      json['result'].forEach((v) {
        result!.add(Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoice {
  int? id;
  String? transactionId;
  String? invoiceNo;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  int? totalCourier;
  String? paymentMethod;
  String? deliveryMethod;
  String? status;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<InvoiceItems>? invoiceItems;

  Invoice(
      {this.id,
        this.transactionId,
        this.invoiceNo,
        this.customerName,
        this.customerPhone,
        this.customerAddress,
        this.totalCourier,
        this.paymentMethod,
        this.deliveryMethod,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.invoiceItems});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    invoiceNo = json['invoice_no'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    //customerAddress = json['customer_address'];
    totalCourier = json['total_courier'];
    paymentMethod = json['payment_method'];
    deliveryMethod = json['delivery_method'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['invoice_items'] != null) {
      invoiceItems = <InvoiceItems>[];
      json['invoice_items'].forEach((v) {
        invoiceItems!.add(InvoiceItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['invoice_no'] = this.invoiceNo;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['total_courier'] = this.totalCourier;
    data['payment_method'] = this.paymentMethod;
    data['delivery_method'] = this.deliveryMethod;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.invoiceItems != null) {
      data['invoice_items'] =
          this.invoiceItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceItems {
  int? id;
  int? invoiceId;
  int? orderId;
  int? itemId;
  int? productId;
  String? productName;
  int? itemsTotal;
  int? chinaShipping;
  double? weight;
  int? shippingRate;
  int? courierBill;
  int? itemsPayable;
  int? deposit;
  int? duePayment;
  int? secondPayment;
  String? status;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  InvoiceItems(
      {this.id,
        this.invoiceId,
        this.orderId,
        this.itemId,
        this.productId,
        this.productName,
        this.itemsTotal,
        this.chinaShipping,
        this.weight,
        this.shippingRate,
        this.courierBill,
        this.itemsPayable,
        this.deposit,
        this.duePayment,
        this.secondPayment,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  InvoiceItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    orderId = json['order_id'];
    itemId = json['item_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    itemsTotal = json['items_total'];
    chinaShipping = json['china_shipping'];
    weight = json['weight'];
    shippingRate = json['shipping_rate'];
    courierBill = json['courier_bill'];
    itemsPayable = json['items_payable'];
    deposit = json['deposit'];
    duePayment = json['due_payment'];
    secondPayment = json['second_payment'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_id'] = this.invoiceId;
    data['order_id'] = this.orderId;
    data['item_id'] = this.itemId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['items_total'] = this.itemsTotal;
    data['china_shipping'] = this.chinaShipping;
    data['weight'] = this.weight;
    data['shipping_rate'] = this.shippingRate;
    data['courier_bill'] = this.courierBill;
    data['items_payable'] = this.itemsPayable;
    data['deposit'] = this.deposit;
    data['due_payment'] = this.duePayment;
    data['second_payment'] = this.secondPayment;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}