import 'package:flutter/material.dart';

class PostText extends StatelessWidget {
  const PostText({
    Key? key,
    required this.postText,
  }) : super(key: key);
  final String postText;
  @override
  Widget build(BuildContext context) {
    return Text(
      postText,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
