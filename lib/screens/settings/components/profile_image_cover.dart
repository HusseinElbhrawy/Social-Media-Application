import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/screens/feeds/components/custom_cached_network_image.dart';
import 'package:social_media_app/screens/feeds/components/user_image.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

class ProfileCoverAndPicture extends StatelessWidget {
  const ProfileCoverAndPicture({
    Key? key,
    required this.width,
    this.profileImageFile,
    this.isEditScreen = false,
    this.coverOnTap,
    this.profileImageOnTap,
    this.profileImage,
    this.profileCoverFile,
    this.profileCover,
    this.profileUserImage,
    this.profileUserCoverImage,
  }) : super(key: key);
  // final SettingsScreenBloc? settingsScreenBloc;
  final String? profileUserImage;
  final String? profileUserCoverImage;
  final double width;
  final bool isEditScreen;
  final Function? coverOnTap;
  final Function? profileImageOnTap;
  final String? profileImage;
  final String? profileCover;
  final File? profileCoverFile;
  final File? profileImageFile;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              heightFactor: 1.2,
              child: profileCoverFile != null
                  ? Image.file(
                      profileCoverFile as File,
                    )
                  : CustomCachedNetworkImage(
                      imageUrl: isEditScreen
                          ? profileCover.toString()
                          : profileUserCoverImage.toString(),
                    ),
            ),
            Visibility(
              visible: isEditScreen,
              child: IconButton(
                onPressed: isEditScreen ? () => coverOnTap!() : () {},
                icon: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(IconBroken.Camera),
                ),
              ),
            ),
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: MediaQuery.of(context).orientation == Orientation.portrait
                  ? width / 6
                  : width / 11,
              child: UserImage(
                profileImageFile: profileImageFile,
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? width / 3.2
                        : width / 6,
                profileImage: isEditScreen
                    ? profileImage.toString()
                    : profileUserImage.toString(),
              ),
            ),
            Visibility(
              visible: isEditScreen,
              child: IconButton(
                onPressed: isEditScreen ? () => profileImageOnTap!() : () {},
                icon: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    IconBroken.Camera,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
