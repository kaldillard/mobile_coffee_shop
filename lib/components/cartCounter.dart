import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';
import 'package:mobile_coffee_shop/providers/checkout/cart_counter_provider.dart';

class CartCounterWidget extends ConsumerWidget {
  final Coffee coffee;
  final String size;
  final Function() increment;
  final Function() decrement;

  const CartCounterWidget({
    super.key,
    required this.coffee,
    required this.size,
    required this.increment,
    required this.decrement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = true;

    final cartItems = ref.watch(cartProvider);

    final index = cartItems.indexWhere((item) => item.coffee.id == coffee.id);

    return Row(
      children: [
        IconButton(
          onPressed: decrement,
          icon: const Icon(
            Icons.remove,
          ),
          disabledColor: Colors.grey,
          color: Colors.black,
          isSelected: isSelected,
        ),
        Text(
          "${cartItems[index].quantity}",
        ),
        IconButton(
          onPressed: increment,
          icon: const Icon(
            Icons.add,
          ),
          disabledColor: Colors.grey,
        ),
      ],
    );
  }
}
