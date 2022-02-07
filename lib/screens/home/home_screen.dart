import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        listener: (BuildContext context, state) {},
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
            body: Column(
              children: [
                state is SignOutLoading
                    ? const Center(child: LinearProgressIndicator())
                    : Visibility(
                        visible: homeScreenCubit.instanceCurrentUser.currentUser
                                ?.emailVerified ==
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
            bottomNavigationBar: BottomNavigationBar(
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
                  icon: Icon(IconBroken.Location),
                  label: 'Location',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                  label: 'Setting',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VerifyWarningWidget extends StatelessWidget {
  const VerifyWarningWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child: ListTile(
        leading: const Icon(
          Icons.info,
          color: Colors.black,
        ),
        title: Text(
          'Please log in again to Verify Your account',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'firecode',
              ),
        ),
        trailing: TextButton(
          onPressed: () => onTap(),
          child: Text('Done'.toUpperCase()),
        ),
      ),
    );
  }
}
