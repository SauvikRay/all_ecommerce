import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';
import 'dart:io';

class OrderRepo{
  final ApiClient apiClient;
  final SharedPreferences preferences;

  OrderRepo({
    required this.apiClient,
    required this.preferences
  });

  ///Order List
  Future<Response> getCustomerOrderList() async{
    return await apiClient.getData(Constants.CUSTOMER_ORDER_LIST_URL);
  }

  ///Invoice List
  Future<Response> getCustomerOrderInvoiceList() async{
    return await apiClient.getData(Constants.CUSTOMER_ORDER_INVOICE_LIST_URL);
  }

  ///Address List
  Future<Response> getCustomerAddressList() async{
    return await apiClient.getData(Constants.CUSTOMER_ADDRESS_LIST_URL);
  }
}