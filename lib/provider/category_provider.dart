import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String _category = "all products";
  
  String get category => _category;
  
  set category (String categoryName) {
    _category = categoryName;
    notifyListeners();
  }
}
