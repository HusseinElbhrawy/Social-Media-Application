import 'package:flutter/material.dart';

class UserNameAndDate extends StatelessWidget {
  const UserNameAndDate({
    Key? key,
    required this.width,
    this.postDate,
    this.userName,
    this.inCreatePostScreen = false,
  }) : super(key: key);

  final double width;
  final bool inCreatePostScreen;
  final String? userName;
  final String? postDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              userName.toString(),
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontFamily: 'jannah',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(width: width / 50),
            const Icon(
              Icons.check_circle,
              color: Colors.blue,
              size: 18,
            )
          ],
        ),
        inCreatePostScreen
            ? Text('')
            : Text(
                postDate.toString(),
                style: Theme.of(context).textTheme.caption!.copyWith(
                    fontWeight: FontWeight.bold, fontFamily: 'firecode'),
              )
      ],
    );
  }
}
