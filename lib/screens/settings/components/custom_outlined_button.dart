import 'package:flutter/material.dart';

class CustomOutLinedButton extends StatelessWidget {
  const CustomOutLinedButton({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);
  final Function onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: child,
      onPressed: () => onTap(),
    );
  }
}
