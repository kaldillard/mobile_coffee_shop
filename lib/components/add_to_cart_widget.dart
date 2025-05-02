import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_coffee_shop/constants/colors.dart';
import 'package:mobile_coffee_shop/components/cartCounter.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';

class AddToCartWidget extends ConsumerWidget {
  final int isCart;
  final Coffee coffee;

  final Function() increment;
  final Function() decrement;

  const AddToCartWidget({
    super.key,
    required this.isCart,
    required this.coffee,
    required this.increment,
    required this.decrement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isCart > 0
        ? CartCounterWidget(
            size: "M",
            coffee: coffee,
            increment: increment,
            decrement: decrement,
          )
        : TextButton(
            onPressed: increment,
            style: TextButton.styleFrom(
              backgroundColor: color01,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const SizedBox(
              width: 200,
              height: 35,
              child: Center(
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          );
  }
}
