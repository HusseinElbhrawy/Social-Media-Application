import 'package:flutter/material.dart';

class NumberOfLikesAndComments extends StatelessWidget {
  const NumberOfLikesAndComments({
    Key? key,
    required this.text,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);
  final String text;
  final Function onTap;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      onTap: () {},
      enableFeedback: true,
    );
  }
}
