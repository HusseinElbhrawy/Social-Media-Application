import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/screens/login/components/custom_text_form_filed.dart';
import 'package:social_media_app/screens/settings/settings_screen.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/edit_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    Key? key,
    required this.profileImage,
    required this.profileCover,
    required this.name,
    required this.bio,
  }) : super(key: key);
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController bioController = TextEditingController();
  final String profileImage;
  final String profileCover;
  final String name;
  final String bio;

  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    bioController.text = bio;
    return BlocProvider(
      create: (BuildContext context) => EditScreenBloc(),
      child: BlocConsumer<EditScreenBloc, SocialAppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var editScreenCubit = EditScreenBloc.object(context);
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Edit Profile'),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Update'.toUpperCase(),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(
                        kDefaultPadding * 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                ProfileCoverAndPicture(
                  isEditScreen: true,
                  profileImageFile: editScreenCubit.profileImage,
                  profileImage: profileImage,
                  profileImageOnTap: () {
                    editScreenCubit.getProfileImage();
                  },
                  profileCover: profileCover,
                  profileCoverFile: editScreenCubit.coverImage,
                  coverOnTap: () {
                    editScreenCubit.getProfileCover();
                  },
                  width: width,
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: CustomTextFormFiled(
                    enable: false,
                    controller: nameController,
                    prefixIcon: IconBroken.User,
                    hintLabel: 'Name',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: CustomTextFormFiled(
                    controller: bioController,
                    enable: false,
                    prefixIcon: IconBroken.Info_Circle,
                    hintLabel: 'Bio',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
