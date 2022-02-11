import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/feeds/components/post_image.dart';
import 'package:social_media_app/screens/feeds/components/post_text.dart';
import 'package:social_media_app/screens/feeds/components/react_button.dart';
import 'package:social_media_app/screens/feeds/components/tag_text.dart';
import 'package:social_media_app/screens/feeds/components/user_image.dart';
import 'package:social_media_app/screens/feeds/components/user_name_and_date.dart';
import 'package:social_media_app/shared/config/components.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/feeds_screen_bloc.dart';
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
    required this.postDate,
    required this.userName,
    required this.postText,
    required this.postId,
    required this.index,
    required this.commentController,
  }) : super(key: key);

  final String subImage;
  final String subImage2;
  final double width;
  final double height;
  final String userName;
  final String postDate;
  final String postText;
  final String postId;
  final int index;
  final TextEditingController commentController;

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
                UserNameAndDate(
                  width: width,
                  postDate: postDate,
                  userName: userName,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.More_Circle),
                ),
              ],
            ),
            const Divider(),
            PostText(postText: postText),
            Wrap(
              children: const [
                TagText(),
                TagText(),
                TagText(),
                TagText(),
                TagText(),
              ],
            ),
            Visibility(
              visible: subImage2.isNotEmpty,
              child: PostImage(
                subImage2: subImage2,
                height: height,
              ),
            ),
            Row(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId)
                        .collection('likes')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return NumberOfLikesAndComments(
                          onTap: () {},
                          icon: IconBroken.Heart,
                          iconColor: Colors.red,
                          text: snapshot.data.docs.length.toString(),
                        );
                      } else {
                        return const Text('Loading....');
                      }
                    }),
                const Spacer(),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(postId)
                      .collection('comments')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return NumberOfLikesAndComments(
                        onTap: () {},
                        icon: IconBroken.Info_Circle,
                        iconColor: Colors.amber,
                        text: snapshot.data.docs.length.toString(),
                      );
                    } else {
                      return const Text('Loading....');
                    }
                  },
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
                Expanded(
                  flex: 2,
                  child: CommentTextFormFiled(
                    validatorMessage: 'Please write...',
                    commentController: commentController,
                  ),
                ),
                ReactButton(
                  iconColor: Colors.red,
                  icon: IconBroken.Heart,
                  onTap: () async {
                    await FeedsScreenBloc.object(context)
                        .addLikeToPost(postId: postId);
                  },
                  title: 'Like',
                ),
                ReactButton(
                  iconColor: Colors.green,
                  icon: IconBroken.Send,
                  onTap: () async {
                    if (commentController.text.isEmpty ||
                        commentController.text == null) {
                      warningMotionToast('Please Write Comment ').show(context);
                    } else {
                      await FeedsScreenBloc.object(context).addCommentToPost(
                        postId: postId,
                        commentText: commentController.text,
                      );
                      commentController.clear();
                    }
                  },
                  title: 'Comment',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
