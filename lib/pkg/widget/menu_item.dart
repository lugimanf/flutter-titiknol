import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  const MenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.black87),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: textColor ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true,
    );
  }
}
