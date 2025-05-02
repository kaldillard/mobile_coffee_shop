import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_coffee_shop/constants/colors.dart';
import 'package:mobile_coffee_shop/components/my_icon_button.dart';

class DeliveryScreenRow extends StatelessWidget {
  const DeliveryScreenRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyIconButton(
            icon: IconlyLight.arrow_left_2,
            onPresssed: () {
              Navigator.pop(context);
            },
            backgroundColor: color04,
          ),
          MyIconButton(
            icon: Icons.my_location,
            onPresssed: () {},
            backgroundColor: color04,
          ),
        ],
      ),
    );
  }
}
