import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/screens/edit/edit_profile_screen.dart';
import 'package:social_media_app/screens/feeds/components/custom_cached_network_image.dart';
import 'package:social_media_app/screens/feeds/components/user_image.dart';
import 'package:social_media_app/shared/config/components.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/settings_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) =>
          SettingsScreenBloc()..getCurrentUserData(),
      child: BlocConsumer<SettingsScreenBloc, SocialAppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var settingsScreenBloc = SettingsScreenBloc.object(context);
          if (state is GetCurrentUserDataLoading) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                ProfileCoverAndPicture(
                  settingsScreenBloc: settingsScreenBloc,
                  width: width,
                ),
                Text(
                  settingsScreenBloc.userModel.name.toString(),
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontFamily: 'jannah',
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  settingsScreenBloc.userModel.bio.toString(),
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontFamily: 'firecode',
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      NumberOfPosts(
                        title: 'Posts',
                        numbers: '100',
                      ),
                      NumberOfPosts(
                        title: 'Photos',
                        numbers: '265',
                      ),
                      NumberOfPosts(
                        title: 'Followers',
                        numbers: '10K',
                      ),
                      NumberOfPosts(
                        title: 'Following',
                        numbers: '64',
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding * 1.5),
                        child: CustomOutLinedButton(
                          child: Text(
                            'add photo'.toUpperCase(),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                    CustomOutLinedButton(
                      onTap: () {
                        navigateTo(
                          context: context,
                          nextPage: EditProfileScreen(
                            profileImage: settingsScreenBloc
                                .userModel.profileImage
                                .toString(),
                            profileCover: settingsScreenBloc
                                .userModel.coverImage
                                .toString(),
                            bio: settingsScreenBloc.userModel.bio.toString(),
                            name: settingsScreenBloc.userModel.name.toString(),
                          ),
                        );
                      },
                      child: const Icon(
                        IconBroken.Edit_Square,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class CustomOutLinedButton extends StatelessWidget {
  const CustomOutLinedButton({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);
  final Function onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: child,
      onPressed: () => onTap(),
    );
  }
}

class NumberOfPosts extends StatelessWidget {
  const NumberOfPosts({
    Key? key,
    required this.title,
    required this.numbers,
  }) : super(key: key);
  final String title;
  final String numbers;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          numbers,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'jannah',
              ),
        ),
        Text(
          title,
          style: const TextStyle(fontFamily: 'firecode'),
        ),
      ],
    );
  }
}

class ProfileCoverAndPicture extends StatelessWidget {
  const ProfileCoverAndPicture({
    Key? key,
    this.settingsScreenBloc,
    required this.width,
    this.isEditScreen = false,
    this.coverOnTap,
    this.profileImageOnTap,
    this.profileImage,
    this.profileCoverFile,
    this.profileCover,
    this.profileImageFile,
  }) : super(key: key);
  final SettingsScreenBloc? settingsScreenBloc;
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
              heightFactor: 1.3,
              child: profileCoverFile != null
                  ? Image.file(profileCoverFile as File)
                  : CustomCachedNetworkImage(
                      imageUrl: isEditScreen
                          ? profileCover.toString()
                          : settingsScreenBloc!.userModel.coverImage.toString(),
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
                    : settingsScreenBloc!.userModel.profileImage.toString(),
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
