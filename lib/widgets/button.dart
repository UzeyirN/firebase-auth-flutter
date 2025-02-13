import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final VoidCallback? onPressed;

  const MyButton(
      {super.key,
      required this.child,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: child,
      ),
    );
  }
}
