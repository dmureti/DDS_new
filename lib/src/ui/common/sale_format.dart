import 'package:flutter/material.dart';

Color formatSale(String baseType) {
  switch (baseType.toLowerCase()) {
    case 'pickup':
      return Colors.deepOrange;
      break;
    case 'cash invoice':
      return Colors.purple;
      break;
    default:
      return Colors.black;
      break;
  }
}
