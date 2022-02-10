import 'package:flutter/material.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

import '../../shared/config/const.dart';
import '../feeds/components/user_image.dart';
import '../feeds/components/user_name_and_date.dart';

class AddNewPostScreen extends StatelessWidget {
  const AddNewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final TextEditingController postController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconBroken.Arrow___Left_2),
        ),
        title: const Text(
          'Create Post',
          style: TextStyle(fontFamily: 'firecode'),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'post'.toUpperCase(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding * 2),
        child: Column(
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
                UserNameAndDate(width: width, inCreatePostScreen: true),
              ],
            ),
            Expanded(
              child: TextFormField(
                style: TextStyle(
                  fontFamily: 'jannah',
                  fontSize:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? width / 20
                          : width / 30,
                  fontWeight: FontWeight.bold,
                ),
                scrollPhysics: BouncingScrollPhysics(),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'What is on your mind...',
                  hintStyle:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'firecode',
                              )
                          : Theme.of(context).textTheme.headline6,
                  border: InputBorder.none,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(IconBroken.Image),
                    label: const Text('Add Image'),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(IconBroken.Category),
                    label: const Text('Tags'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
