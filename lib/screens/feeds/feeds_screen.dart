import 'package:flutter/material.dart';
import 'package:social_media_app/shared/config/const.dart';

import 'components/custom_cached_network_image.dart';
import 'components/post_widget.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Card(
          elevation: 7.0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              const CustomCachedNetworkImage(imageUrl: mainImage),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding * 1.5),
                child: Text(
                  'Communicate With Friends',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'firecode',
                      ),
                ),
              )
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return PostWidget(
              height: height,
              subImage: subImage,
              subImage2: subImage2,
              width: width,
            );
          },
          itemCount: 10,
        ),
      ],
    );
  }
}
