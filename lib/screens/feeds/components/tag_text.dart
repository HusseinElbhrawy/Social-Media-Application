import 'package:flutter/material.dart';
import 'package:social_media_app/shared/config/const.dart';

class TagText extends StatelessWidget {
  const TagText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          top: kDefaultPadding * 1.5, end: kDefaultPadding / 2),
      child: InkWell(
        enableFeedback: true,
        onTap: () {},
        child: Text(
          '#software',
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: Colors.blue),
        ),
      ),
    );
  }
}
