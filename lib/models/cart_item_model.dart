import 'package:mobile_coffee_shop/models/coffee_model.dart';

class CartItem {
  final Coffee coffee;
  int quantity;

  CartItem({
    required this.coffee,
    this.quantity = 1,
  });
}
