

import 'dart:developer';

import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {



addCartItems(){

}

cartCountWithId(int count){

  count;
  log("Carted count : ${count}");
  notifyListeners();
}


}
