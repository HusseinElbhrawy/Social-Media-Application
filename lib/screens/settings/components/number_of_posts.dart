import 'package:flutter/material.dart';

class NumberOfPosts extends StatelessWidget {
  const NumberOfPosts({
    Key? key,
    required this.title,
    required this.numbers,
  }) : super(key: key);
  final String title;
  final String numbers;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          numbers,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'jannah',
              ),
        ),
        Text(
          title,
          style: const TextStyle(fontFamily: 'firecode'),
        ),
      ],
    );
  }
}
