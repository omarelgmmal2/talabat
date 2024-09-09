import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../view/home/pages/profile/screens/wishlist/model.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  bool isProductInWishlist({required String productId}) {
    return _wishlistItems.containsKey(productId);
  }

  void addOrRemoveFromWishlist({required String productId}) {
    if(_wishlistItems.containsKey(productId)){
      _wishlistItems.remove(productId);
    }else{
      _wishlistItems.putIfAbsent(
        productId,
            () => WishlistModel(
          id: const Uuid().v4(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
