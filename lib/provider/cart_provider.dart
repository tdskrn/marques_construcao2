import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marques_construcao/models/cart_attributes.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttributes> _cartItems = {};

  // getter que retorna os cart items
  Map<String, CartAttributes> get getCartItem {
    return _cartItems;
  }

  double get totalPrice {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      // value que pega os atributos
      total += value.quantity * value.price;
    });

    return total;
  }

  void deleteAllCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void removeProductToCart(productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void addProductToCart(
    String productName,
    String productId,
    List imageUrl,
    int quantity,
    int productQuantity,
    double price,
    String vendorId,
    String productSize,
    Timestamp scheduleDate,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCart) => CartAttributes(
          productName: existingCart.productName,
          productId: existingCart.productId,
          imageUrl: existingCart.imageUrl,
          quantity: existingCart.quantity + 1,
          productQuantity: existingCart.productQuantity,
          price: existingCart.price,
          vendorId: existingCart.vendorId,
          productSize: existingCart.productSize,
          scheduleDate: existingCart.scheduleDate,
        ),
      );
      notifyListeners();
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartAttributes(
          productName: productName,
          productId: productId,
          imageUrl: imageUrl,
          productQuantity: productQuantity,
          quantity: quantity,
          price: price,
          vendorId: vendorId,
          productSize: productSize,
          scheduleDate: scheduleDate,
        ),
      );
      notifyListeners();
    }
  }

  void increment(CartAttributes cartAttributes) {
    cartAttributes.increase();
    notifyListeners();
  }

  void decrement(CartAttributes cartAttributes) {
    cartAttributes.decrease();
    notifyListeners();
  }
}
