import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/shared/cubit/bloc/create_post_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

import '../../shared/config/const.dart';
import '../feeds/components/user_image.dart';
import '../feeds/components/user_name_and_date.dart';
import 'components/create_post_button.dart';
import 'components/post_text_form_filed.dart';
import 'components/uploaded_image_with_deleteButton.dart';

class AddNewPostScreen extends StatelessWidget {
  const AddNewPostScreen({Key? key}) : super(key: key);
  static final formKey = GlobalKey<FormState>();
  static final TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (BuildContext context) => CreatePostBloc(),
      child: BlocConsumer<CreatePostBloc, SocialAppStates>(
        listener: (BuildContext context, state) {
          if (state is CreatePostSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, Object? state) {
          var createPostCubit = CreatePostBloc.object(context);
          return Form(
            key: AddNewPostScreen.formKey,
            child: Scaffold(
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
                  CreatePostButton(
                    postController: postController,
                    createPostCubit: createPostCubit,
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding * 1.5),
                  child: Column(
                    children: [
                      Visibility(
                        visible: state is CreatePostLoading ||
                            state is UploadPickedImageForPostLoading,
                        child: const LinearProgressIndicator(),
                      ),
                      Row(
                        children: [
                          UserImage(
                            width: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? width / 8
                                : width / 15,
                            profileImage: subImage,
                          ),
                          const SizedBox(width: 15),
                          UserNameAndDate(
                              width: width, inCreatePostScreen: true),
                        ],
                      ),
                      PostTextFormFiled(
                        postController: postController,
                        width: width,
                      ),
                      Visibility(
                        visible: createPostCubit.imageFile != null,
                        child: UploadedImageWithDeleteButton(
                            createPostCubit: createPostCubit),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () async {
                                await createPostCubit.pickedImage();
                              },
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
              ),
            ),
          );
        },
      ),
    );
  }
}
