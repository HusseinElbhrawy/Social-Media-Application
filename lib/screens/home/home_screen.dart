import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/screens/home/components/verify_widget.dart';
import 'package:social_media_app/screens/newpost/new_post_screen.dart';
import 'package:social_media_app/shared/config/components.dart';
import 'package:social_media_app/shared/cubit/bloc/home_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeScreenBloc()..getCurrentUser(context: context),
      child: BlocConsumer<HomeScreenBloc, SocialAppStates>(
        listener: (BuildContext context, state) {
          /*if (state is OpenAddNewPostScreen) {
            navigateTo(context: context, nextPage: const AddNewPostScreen());
          }*/
        },
        builder: (BuildContext context, Object? state) {
          var homeScreenCubit = HomeScreenBloc.object(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                homeScreenCubit
                    .appBarTitle[homeScreenCubit.bottomNavigationCurrentIndex],
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontFamily: 'firecode',
                      fontWeight: FontWeight.bold,
                    ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconBroken.Search,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconBroken.Notification,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  state is SignOutLoading
                      ? const Center(child: LinearProgressIndicator())
                      : Visibility(
                          visible: homeScreenCubit.instanceCurrentUser
                                  .currentUser?.emailVerified ==
                              false,
                          child: VerifyWarningWidget(
                            onTap: () async {
                              await homeScreenCubit.signOut(context: context);
                            },
                          ),
                        ),
                  homeScreenCubit
                      .screens[homeScreenCubit.bottomNavigationCurrentIndex],
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                navigateTo(
                    context: context, nextPage: const AddNewPostScreen());
              },
              child: const Icon(
                IconBroken.Paper_Upload,
                color: Colors.black,
              ),
            ),
            bottomNavigationBar: AnimatedBottomNavigationBar(
              icons: homeScreenCubit.icons,
              activeIndex: homeScreenCubit.bottomNavigationCurrentIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.sharpEdge,
              backgroundColor: Colors.white,
              activeColor: Colors.blue,
              inactiveColor: Colors.black,
              onTap: (index) {
                homeScreenCubit.changeBottomNavigationBarIndex(newIndex: index);
              },
              //other params
            ),
            /*bottomNavigationBar: BottomNavigationBar(
              currentIndex: homeScreenCubit.bottomNavigationCurrentIndex,
              onTap: (newIndex) {
                homeScreenCubit.changeBottomNavigationBarIndex(
                    newIndex: newIndex);
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location),
                  label: 'Location',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                  label: 'Setting',
                ),
              ],
            ),*/
          );
        },
      ),
    );
  }
}
