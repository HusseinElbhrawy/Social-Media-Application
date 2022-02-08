import 'package:flutter/material.dart';

class ReactButton extends StatelessWidget {
  const ReactButton({
    Key? key,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    required this.title,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () => onTap(),
      icon: Icon(
        icon,
        color: iconColor,
      ),
      label: Text(
        title,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
