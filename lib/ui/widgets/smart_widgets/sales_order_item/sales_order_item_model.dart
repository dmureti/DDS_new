import 'package:stacked/stacked.dart';

import 'package:tripletriocore/tripletriocore.dart';
import 'package:flutter/material.dart';

class SalesOrderItemModel extends BaseViewModel {
  final Product product;
//  SalesOrderItem salesOrderItem;
  double _total = 0.00;
  double get total => _total;

  num _quantity = 0;
  num get quantity => _quantity;

  num _maxQuantity;
  num get maxQuantity => _maxQuantity;
  SalesOrderItemModel({@required this.product, num maxQuantity})
      : assert(product != null),
        _maxQuantity = maxQuantity;

  bool get isEnabled => product.itemPrice > 0;

  /// If the item has a price enable the add item quantity
  addItemQuantity() {
    if (isEnabled) {
      if (maxQuantity == null) {
        _quantity++;
        setItemTotal();
        notifyListeners();
      } else if (quantity < maxQuantity) {
        _quantity++;
        setItemTotal();
        notifyListeners();
      }
    } else {
      null;
    }
  }

  /// If [isEnabled] set the total price for this item
  setItemTotal() {
    if (isEnabled) {
      var result = product.itemPrice * quantity;
      _total = result.roundToDouble();
      notifyListeners();
    }
  }

  /// If [isEnabled] remove [quantity] of 1 unit from the total quantity
  /// If the [quantity] is equal to zero. Disable
  removeItemQuantity() {
    if (_quantity > 0 && isEnabled) {
      _quantity--;
      setItemTotal();
      notifyListeners();
    }
  }

  /// For large quantities, the bottom modal sheet is used for data input
  /// If [isEnabled] allow the user to add the number of units required
  void updateQuantity(String value, Product product) {
    if (isEnabled) {
      int quantity = int.tryParse(value);
      _quantity = quantity;
      var result = product.itemPrice * _quantity;
      _total = result.roundToDouble();
      setItemTotal();
      notifyListeners();
    }
  }

  setQuantity() {}
}
