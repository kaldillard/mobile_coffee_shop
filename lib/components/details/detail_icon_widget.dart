import 'package:flutter/material.dart';

class DetailIcon extends StatelessWidget {
  final String image;
  const DetailIcon({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(15)),
      child: Image.asset(
        image,
        fit: BoxFit.contain,
        height: 24,
        width: 24,
      ),
    );
  }
}
