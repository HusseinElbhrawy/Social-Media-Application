import 'package:flutter/material.dart';

class PostTextFormFiled extends StatelessWidget {
  const PostTextFormFiled({
    Key? key,
    required this.postController,
    required this.width,
  }) : super(key: key);

  final TextEditingController postController;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: postController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Must not be empty';
        }
        return null;
      },
      style: TextStyle(
        fontFamily: 'jannah',
        fontSize: MediaQuery.of(context).orientation == Orientation.portrait
            ? width / 20
            : width / 30,
        fontWeight: FontWeight.bold,
      ),
      scrollPhysics: const BouncingScrollPhysics(),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'What is on your mind...',
        hintStyle: MediaQuery.of(context).orientation == Orientation.portrait
            ? Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'firecode',
                )
            : Theme.of(context).textTheme.headline6,
        border: InputBorder.none,
      ),
    );
  }
}
