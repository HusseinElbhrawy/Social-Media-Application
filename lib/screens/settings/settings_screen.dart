import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_media_app/screens/edit/edit_profile_screen.dart';
import 'package:social_media_app/shared/config/components.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/settings_screen_bloc.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

import 'components/custom_outlined_button.dart';
import 'components/number_of_posts.dart';
import 'components/profile_image_cover.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  static final userData =
      FirebaseFirestore.instance.collection('users').doc(currentUserUid);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => SettingsScreenBloc(),
      child: StreamBuilder(
        stream: userData.snapshots(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          } else if (snapshot.hasData) {
            return Column(
              children: [
                ProfileCoverAndPicture(
                  profileUserImage: snapshot.data['image'],
                  profileUserCoverImage: snapshot.data['coverImage'],
                  width: width,
                ),
                Text(
                  snapshot.data['name'],
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontFamily: 'jannah',
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  snapshot.data['bio'],
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
                            profileImage: snapshot.data['image'],
                            profileCover: snapshot.data['coverImage'],
                            bio: snapshot.data['bio'],
                            name: snapshot.data['name'],
                            phone: snapshot.data['phone'],
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
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(height: height / 10),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding * 1.3),
                    child: Text(
                      'Error happen While get current user data from Database , May be User Deleted',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontFamily: 'jannah',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SvgPicture.asset('assets/images/error.svg'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
