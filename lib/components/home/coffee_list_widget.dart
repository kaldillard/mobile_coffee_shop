import 'package:flutter/material.dart';
import 'package:mobile_coffee_shop/components/home/order_card_widget.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';
import 'package:mobile_coffee_shop/screens/coffee_details_screen.dart';

class CoffeeList extends StatelessWidget {
  final Iterable<Coffee> coffees;
  const CoffeeList({
    super.key,
    required this.coffees,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: coffees.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          childAspectRatio: 2 / 3),
      itemBuilder: (context, index) {
        final coffee = coffees.elementAt(index);
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return CoffeeDetailsScreen(
                    coffee: coffee,
                  );
                },
              ),
            );
          },
          child: OrderCard(
            coffee: coffee,
          ),
        );
      },
    );
  }
}
