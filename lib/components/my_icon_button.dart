import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onPresssed;
  final Color backgroundColor;
  final Color? foregroundColor;
  const MyIconButton({
    super.key,
    required this.icon,
    required this.onPresssed,
    required this.backgroundColor,
    this.foregroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPresssed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
    );
  }
}
