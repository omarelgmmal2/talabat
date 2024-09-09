import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../view/home/pages/profile/screens/viewed_recently/model.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> _viewedProdItems = {};

  Map<String, ViewedProdModel> get getViewedProdItems {
    return _viewedProdItems;
  }

  bool isProductInViewed({required String productId}) {
    return _viewedProdItems.containsKey(productId);
  }

  void addOrRemoveProductToHistory({required String productId}) {
    if(_viewedProdItems.containsKey(productId)){
      _viewedProdItems.remove(productId);
    }else{
      _viewedProdItems.putIfAbsent(
        productId,
            () => ViewedProdModel(
          id: const Uuid().v4(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }
  void clearLocalViewed() {
    _viewedProdItems.clear();
    notifyListeners();
  }

}
