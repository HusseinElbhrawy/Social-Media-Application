import 'package:flutter/material.dart';

class AddNewPostScreen extends StatelessWidget {
  const AddNewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Post',
          style: TextStyle(fontFamily: 'firecode'),
        ),
      ),
    );
  }
}
