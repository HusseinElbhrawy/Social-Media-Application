import 'package:flutter/material.dart';

class CommentTextFormFiled extends StatelessWidget {
  const CommentTextFormFiled({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Write a comment',
        border: InputBorder.none,
      ),
    );
  }
}
