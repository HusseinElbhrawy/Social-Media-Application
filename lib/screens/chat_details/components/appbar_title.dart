import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.userImage,
    required this.height,
    required this.userName,
  }) : super(key: key);

  final String userImage;
  final double height;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(child: Image.network(userImage)),
        SizedBox(width: height / 55),
        Text(userName),
      ],
    );
  }
}
