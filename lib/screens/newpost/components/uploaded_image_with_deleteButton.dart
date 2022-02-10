import 'dart:io';

import 'package:flutter/material.dart';

import '../../../shared/cubit/bloc/create_post_bloc.dart';
import '../../../shared/styles/IconBroken.dart';

class UploadedImageWithDeleteButton extends StatelessWidget {
  const UploadedImageWithDeleteButton({
    Key? key,
    required this.createPostCubit,
  }) : super(key: key);

  final CreatePostBloc createPostCubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        createPostCubit.imageFile == null
            ? const Text('')
            : Image.file(
                createPostCubit.imageFile as File,
                fit: BoxFit.cover,
              ),
        IconButton(
          onPressed: () {
            createPostCubit.clearImage();
          },
          icon: const Icon(
            IconBroken.Delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
