import 'package:flutter/material.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../../shared/config/components.dart';
import '../../../shared/cubit/bloc/create_post_bloc.dart';
import '../new_post_screen.dart';

class CreatePostButton extends StatelessWidget {
  const CreatePostButton({
    Key? key,
    required this.postController,
    required this.createPostCubit,
  }) : super(key: key);

  final TextEditingController postController;
  final CreatePostBloc createPostCubit;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (postController.text.isEmpty ||
            postController.text == null && createPostCubit.imageFile == null) {
          warningMotionToast(
            'Please Write Post or select Image',
            animationType: ANIMATION.fromBottom,
            position: MOTION_TOAST_POSITION.bottom,
          ).show(context);
        } else {
          createPostCubit.imageFile == null
              ? print('No Image ')
              : await createPostCubit.uploadPickedImage(
                  root: 'postsImage',
                  imageName: createPostCubit.pickedImageXFile?.name,
                );
          await createPostCubit.createPost(
            text: AddNewPostScreen.postController.text,
          );
          AddNewPostScreen.postController.clear();
        }
      },
      child: Text(
        'post'.toUpperCase(),
      ),
    );
  }
}
