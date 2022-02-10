import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/screens/login/components/custom_text_form_filed.dart';
import 'package:social_media_app/screens/settings/components/profile_image_cover.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/edit_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/bloc/settings_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    Key? key,
    required this.profileImage,
    required this.profileCover,
    required this.name,
    required this.bio,
    required this.phone,
  }) : super(key: key);
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController bioController = TextEditingController();
  static final TextEditingController phoneController = TextEditingController();
  final String profileImage;
  final String profileCover;
  final String name;
  final String bio;
  final String phone;

  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    bioController.text = bio;
    phoneController.text = phone;
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
                BlocProvider(
                  create: (BuildContext context) => SettingsScreenBloc(),
                  child: BlocConsumer<SettingsScreenBloc, SocialAppStates>(
                    listener: (BuildContext context, state) {},
                    builder: (BuildContext context, Object? state) =>
                        TextButton(
                      onPressed: () {
                        editScreenCubit
                            .updateUserInformation(
                          name: nameController.text,
                          bio: bioController.text,
                          phone: phoneController.text,
                          settingsScreenBloc:
                              SettingsScreenBloc.object(context),
                        )
                            .then((value) {
                          SettingsScreenBloc.object(context)
                              .getCurrentUserData();
                        });
                        /* editScreenCubit
                            .uploadImage(
                          isProfileCoverImage: false,
                          imageName: editScreenCubit.pickedProfileImage!.name,
                          root: 'profileImage',
                          file: editScreenCubit.profileImageFile as File,
                        )
                            .then((value) {
                          editScreenCubit.updateImagesInDatabase(
                            profileImageUrl: editScreenCubit.profileImageUrl,
                            profileCoverImageUrl: null,
                          );
                        });

                        //----------------------
                        editScreenCubit
                            .uploadImage(
                          isProfileCoverImage: true,
                          imageName: editScreenCubit.pickedProfileCoverImage!.name,
                          root: 'profileCover',
                          file: editScreenCubit.profileCoverImageFile as File,
                        )
                            .then((value) {
                          editScreenCubit.updateImagesInDatabase(
                            profileImageUrl: null,
                            profileCoverImageUrl:
                                editScreenCubit.profileCoverImageUrl,
                          );
                        });*/
                      },
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
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Visibility(
                    visible: false,
                    child: Padding(
                      padding: EdgeInsets.all(kDefaultPadding * 1.5),
                      child: LinearProgressIndicator(),
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      ProfileCoverAndPicture(
                        isEditScreen: true,
                        // profileImageFile: editScreenCubit.profileImageFile,
                        profileImage: profileImage,
                        profileImageOnTap: () {
                          // editScreenCubit.pickedImage(isProfileCover: false);
                        },
                        profileCover: profileCover,
                        // profileCoverFile: editScreenCubit.profileCoverImageFile,
                        coverOnTap: () {
                          // editScreenCubit.pickedImage(isProfileCover: true);
                        },
                        width: width,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: IconButton(
                              onPressed: () {
                                editScreenCubit
                                    .changeEditUserInformationState();
                              },
                              icon: const Icon(IconBroken.Edit),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: CustomTextFormFiled(
                      enable: editScreenCubit.editUserInformation,
                      controller: nameController,
                      prefixIcon: IconBroken.User,
                      hintLabel: 'Name',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: CustomTextFormFiled(
                      controller: bioController,
                      enable: editScreenCubit.editUserInformation,
                      prefixIcon: IconBroken.Info_Circle,
                      hintLabel: 'Bio',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: CustomTextFormFiled(
                      controller: phoneController,
                      enable: editScreenCubit.editUserInformation,
                      prefixIcon: IconBroken.Call,
                      hintLabel: 'Phone',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
