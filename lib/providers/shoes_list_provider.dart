import 'package:flutter/material.dart';
import 'package:provider_state_management_tutorial/models/shoes.dart';

class ShoesListProvider extends ChangeNotifier {
  final List<Shoes> _shoes = [
    Shoes(name: 'Nike', price: 1500.0, image: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2hvZXN8ZW58MHx8MHx8fDA%3D'),
    Shoes(name: 'Panda', price: 1200, image: 'https://images.unsplash.com/photo-1560769629-975ec94e6a86?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHNob2VzfGVufDB8fDB8fHww'),
    Shoes(name: 'Hills', price: 3000, image: 'https://plus.unsplash.com/premium_photo-1671718111684-9142a70a5fe0?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8c2hvZXN8ZW58MHx8MHx8fDA%3D'),
    Shoes(name: 'North Star', price: 2500, image: 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHNob2VzfGVufDB8fDB8fHww'),
  ];

  List<Shoes> get shoesList => _shoes;
  Order? _currentOrder;
  Order? get currentOrder => _currentOrder;

  void selectShoe(Shoes shoes) {
    _currentOrder = Order(shoes: shoes, quantity: 1); // Initialize quantity as 1
    notifyListeners();
  }

  void updateQuantity(int quantity) {
    if (_currentOrder != null) {
      _currentOrder!.quantity = quantity;
      // Update price when quantity changes
      _currentOrder!.totalPrice = _currentOrder!.shoes.price * quantity;
      notifyListeners();
    }
  }

  void placeOrder() {
    _currentOrder = null;
    notifyListeners();
  }
}
