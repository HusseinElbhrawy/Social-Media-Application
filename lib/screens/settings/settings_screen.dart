import 'package:flutter/material.dart';
import 'package:social_media_app/screens/feeds/components/custom_cached_network_image.dart';
import 'package:social_media_app/screens/feeds/components/user_image.dart';
import 'package:social_media_app/shared/config/const.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            const Align(
              alignment: AlignmentDirectional.topCenter,
              heightFactor: 1.23,
              child: CustomCachedNetworkImage(imageUrl: mainImage),
            ),
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: MediaQuery.of(context).orientation == Orientation.portrait
                  ? width / 6
                  : width / 11,
              child: UserImage(
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? width / 3.2
                        : width / 6,
                subImage: subImage,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
