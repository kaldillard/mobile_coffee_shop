import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/models/cart_item_model.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addCoffee(Coffee coffee) {
    final index = state.indexWhere((item) => item.coffee.id == coffee.id);
    if (index != -1) {
      // Coffee already in cart, increase quantity
      final updatedItem = state[index];
      updatedItem.quantity += 1;
      coffee.qty++;

      print("item count ${updatedItem.quantity}");

      state = [...state]; // trigger UI update
    } else {
      // New coffee
      state = [...state, CartItem(coffee: coffee)];
      coffee.qty++;
    }
  }

  void removeCoffee(Coffee coffee) {
    state = state.where((item) => item.coffee.id != coffee.id).toList();
  }

  void decreaseQuantity(Coffee coffee) {
    final index = state.indexWhere((item) => item.coffee.id == coffee.id);
    if (index != -1) {
      final item = state[index];
      if (item.quantity > 1) {
        item.quantity -= 1;
        state = [...state];
      } else {
        removeCoffee(coffee);
      }
    }
  }

  void clearCart() {
    state = [];
  }
}
