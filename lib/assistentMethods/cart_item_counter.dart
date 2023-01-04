import 'package:flutter/material.dart';
import 'package:users_app/global/global.dart';

class CartItemCounter extends ChangeNotifier {
  // pravimo varijablu u koju smjestamo ukupan broj itema iz liste - 1(initialvalue)
  int cartListItemCounter =
      sharedPreferences!.getStringList('userCart')!.length - 1;

  int get count => cartListItemCounter;

  Future<void> showCartListItemsNumber() async {
    cartListItemCounter =
        sharedPreferences!.getStringList('userCart')!.length - 1;

    await Future.delayed(const Duration(milliseconds: 100), () {
      //update UI o broju itema
      notifyListeners();
    });
  }
}
