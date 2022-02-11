import 'package:flutter/material.dart';

import '../../../shared/config/const.dart';

class SenderMessageWidget extends StatelessWidget {
  const SenderMessageWidget({
    Key? key,
    required this.message,
    required this.userImage,
  }) : super(key: key);
  final String message;
  final String userImage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Row(
        children: [
          CircleAvatar(child: Image.network(userImage)),
          Container(
            padding: const EdgeInsetsDirectional.all(kDefaultPadding),
            margin: const EdgeInsetsDirectional.only(
                start: kDefaultPadding * 1.5,
                top: kDefaultPadding,
                end: kDefaultPadding,
                bottom: kDefaultPadding),
            child: Text(
              message,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontFamily: 'jannah',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(kDefaultPadding),
                bottomEnd: Radius.circular(kDefaultPadding),
                topEnd: Radius.circular(kDefaultPadding),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
