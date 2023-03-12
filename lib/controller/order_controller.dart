
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skybuybd/data/repository/order_repo.dart';
import 'package:skybuybd/data/repository/product_repo.dart';
import 'package:skybuybd/models/category/category_product_model.dart';
import 'package:skybuybd/models/invoice_model.dart';
import 'package:skybuybd/models/order_model.dart';
import 'package:skybuybd/models/product_details/product_details.dart';
import 'package:skybuybd/models/product_details/product_details_model.dart';
import 'package:skybuybd/models/user_address_model.dart';
import 'package:skybuybd/pages/product/single_product_page.dart';
import '../data/repository/category_product_repo.dart';
import '../data/repository/category_repo.dart';
import '../data/service/ImageService.dart';
import '../models/category/category_model.dart';
import 'package:http/http.dart' as http;
import '../models/home/picture_model.dart';
import '../models/product/color_image.dart';
import '../models/product/product_size.dart';
import '../models/product/small_image.dart';

class OrderController extends GetxController implements GetxService{
  final OrderRepo orderRepo;

  OrderController({
    required this.orderRepo
  });

  ///For Order
  bool _isOrderListLoaded = false;
  bool get isOrderListLoaded => _isOrderListLoaded;

  OrderModel _orderModel = OrderModel();
  OrderModel get orderModel => _orderModel;

  List<Order> _orderList = [];
  List<Order> get orderList => _orderList;

  List<OrderItems> _totalOrderItems = [];
  List<OrderItems> get totalOrderItems => _totalOrderItems;

  ///For Invoice
  bool _isInvoiceListLoaded = false;
  bool get isInvoiceListLoaded => _isInvoiceListLoaded;

  InvoiceModel _invoiceModel = InvoiceModel();
  InvoiceModel get invoiceModel => _invoiceModel;

  List<Invoice> _invoiceList = [];
  List<Invoice> get invoiceList => _invoiceList;

  List<InvoiceItems> _invoiceItemList = [];
  List<InvoiceItems> get invoiceItemList => _invoiceItemList;

  ///For Address
  bool _isAddressLoaded = false;
  bool get isAddressLoaded => _isAddressLoaded;

  UserAddressModel _userAddressModel = UserAddressModel();
  UserAddressModel get userAddressModel => _userAddressModel;

  List<UserAddress> _userAddressList = [];
  List<UserAddress> get userAddressList => _userAddressList;

  Future<void> getCustomerOrderList() async{

    _orderList = [];
    _totalOrderItems = [];
    _isOrderListLoaded = false;
    update();

    Response response = await orderRepo.getCustomerOrderList();

    if(response.statusCode == 200){
      //print("orderModel : ${response.body}");
      _orderModel = OrderModel.fromJson(response.body);

      _orderList = _orderModel.data!.result!;

      for(final item in _orderList){
        _totalOrderItems.addAll(item.orderItems!);
      }

      _isOrderListLoaded = true;
      update();

    }else{
      if (kDebugMode) {
        print('Error on getting customer order list');
      }

    }
  }

  Future<void> getCustomerOrderInvoiceList() async{

    _invoiceList = [];
    _invoiceItemList = [];
    _isInvoiceListLoaded = false;
    update();

    Response response = await orderRepo.getCustomerOrderInvoiceList();

    if(response.statusCode == 200){

      _invoiceModel = InvoiceModel.fromJson(response.body);
      _invoiceList = _invoiceModel.data!.result!;

      _isInvoiceListLoaded = true;
      update();

    }else{
      if (kDebugMode) {
        print('Error on getting customer invoice list');
      }

    }
  }

  Future<void> getCustomerAddressList() async{

    _userAddressList = [];
    _isAddressLoaded = false;
    update();

    Response response = await orderRepo.getCustomerAddressList();

    if(response.statusCode == 200){

      _userAddressModel = UserAddressModel.fromJson(response.body);
      _userAddressList = _userAddressModel.data!.result!;

      _isAddressLoaded = true;
      update();

    }else{
      if (kDebugMode) {
        print('Error on getting customer address list');
      }

    }
  }

}