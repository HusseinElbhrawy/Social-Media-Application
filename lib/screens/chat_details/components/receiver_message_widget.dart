import 'package:flutter/material.dart';

import '../../../shared/config/const.dart';

class ReceiverMessageWidget extends StatelessWidget {
  const ReceiverMessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
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
          color: Colors.blue.shade200,
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(kDefaultPadding),
            topEnd: Radius.circular(kDefaultPadding),
            bottomStart: Radius.circular(kDefaultPadding),
          ),
        ),
      ),
    );
  }
}
