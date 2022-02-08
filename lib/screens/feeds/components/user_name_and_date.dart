import 'package:flutter/material.dart';

class UserNameAndDate extends StatelessWidget {
  const UserNameAndDate({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Hussein Elbhrawy',
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
        Text(
          'January 21,2021 at 11:00 pm',
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(fontWeight: FontWeight.bold, fontFamily: 'firecode'),
        )
      ],
    );
  }
}
