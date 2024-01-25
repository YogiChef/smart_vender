import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() press;
  final TextStyle? style;
  final Color? color;

  const ButtonWidget({
    super.key,
    required this.label,
    required this.icon,
    this.style,
    required this.press,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        maximumSize: MediaQuery.of(context).size,
        backgroundColor: color ?? Colors.cyan.shade500,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      label: Text(
        label,
        style: style,
      ),
      onPressed: press,
      icon: Icon(
        icon,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
