import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class DeliveryDriverTile extends StatelessWidget {
  final String driversName;
  final String driversImage;

  const DeliveryDriverTile({
    super.key,
    required this.driversName,
    required this.driversImage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(image: NetworkImage(driversImage))),
      ),
      title: Text(
        driversName,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      subtitle: const Text(
        "Personal Courier",
        style: TextStyle(color: Colors.grey),
      ),
      trailing: IconButton.outlined(
        onPressed: () {},
        icon: const Icon(IconlyLight.calling),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
