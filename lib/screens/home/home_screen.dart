import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/shared/cached/cached_helper.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/home_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeScreenBloc()..getCurrentUser(context: context),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  print(CachedHelper.getData(key: kLoginUid));
                },
                icon: Icon(Icons.add))
          ],
          title: Text(
            'Home Feeds',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontFamily: 'firecode',
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        body: BlocConsumer<HomeScreenBloc, SocialAppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            var homeScreenCubit = HomeScreenBloc.object(context);
            return Column(
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
              ],
            );
          },
        ),
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
