import 'package:flutter/material.dart';
import 'package:social_media_app/screens/feeds/components/post_image.dart';
import 'package:social_media_app/screens/feeds/components/post_text.dart';
import 'package:social_media_app/screens/feeds/components/react_button.dart';
import 'package:social_media_app/screens/feeds/components/tag_text.dart';
import 'package:social_media_app/screens/feeds/components/user_image.dart';
import 'package:social_media_app/screens/feeds/components/user_name_and_date.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

import 'comment_text_form_field.dart';
import 'number_of_likes_comments.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.subImage,
    required this.subImage2,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String subImage;
  final String subImage2;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.red,
      elevation: 10.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserImage(
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? width / 8
                          : width / 15,
                  profileImage: subImage,
                ),
                const SizedBox(width: 15),
                UserNameAndDate(width: width),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.More_Circle),
                ),
              ],
            ),
            const Divider(),
            const PostText(),
            Wrap(
              children: const [
                TagText(),
                TagText(),
                TagText(),
                TagText(),
                TagText(),
              ],
            ),
            PostImage(subImage2: subImage2, height: height),
            Row(
              children: [
                NumberOfLikesAndComments(
                  onTap: () {},
                  icon: IconBroken.Heart,
                  iconColor: Colors.red,
                  text: '1200',
                ),
                const Spacer(),
                NumberOfLikesAndComments(
                  onTap: () {},
                  icon: IconBroken.Info_Circle,
                  iconColor: Colors.amber,
                  text: '512 Comment',
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                UserImage(
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? width / 10
                          : width / 20,
                  profileImage: subImage,
                  inComment: true,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  flex: 2,
                  child: CommentTextFormFiled(),
                ),
                ReactButton(
                  iconColor: Colors.red,
                  icon: IconBroken.Heart,
                  onTap: () {},
                  title: 'Like',
                ),
                ReactButton(
                  iconColor: Colors.green,
                  icon: IconBroken.Send,
                  onTap: () {},
                  title: 'Share',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
