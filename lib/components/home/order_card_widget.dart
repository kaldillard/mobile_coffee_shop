import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_coffee_shop/constants/colors.dart';
import 'package:mobile_coffee_shop/components/my_icon_button.dart';
import 'package:mobile_coffee_shop/models/coffee_model.dart';

class OrderCard extends StatelessWidget {
  final Coffee coffee;

  const OrderCard({
    super.key,
    required this.coffee,
  });

  @override
  Widget build(BuildContext context) {
    String displayIngredeints() {
      if (coffee.ingredients!.isEmpty) {
        return "N/A";
      } else {
        return coffee.ingredients![0].toLowerCase();
      }
    }

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      height: 238,
      width: 156,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: SizedBox.fromSize(
                      child: Image.network(
                        coffee.image!,
                        width: MediaQuery.sizeOf(context).width,
                        height: 128,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color03.withValues(alpha: .3),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      width: 51,
                      height: 28,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconlyBold.star,
                            color: Colors.yellow.shade800,
                            size: 16,
                          ),
                          const Text(
                            "4.8",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            FittedBox(
              child: Text(
                coffee.title!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              displayIngredeints(),
              style: const TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${coffee.price?.toStringAsPrecision(3) ?? 4.25}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                MyIconButton(
                  icon: Icons.add,
                  onPresssed: () {},
                  backgroundColor: color01,
                  foregroundColor: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
