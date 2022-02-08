import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/screens/chat/chats_screen.dart';
import 'package:social_media_app/screens/feeds/feeds_screen.dart';
import 'package:social_media_app/screens/login/login_screen.dart';
import 'package:social_media_app/screens/newpost/new_post_screen.dart';
import 'package:social_media_app/screens/settings/settings_screen.dart';
import 'package:social_media_app/screens/users/users_screen.dart';
import 'package:social_media_app/shared/config/components.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class HomeScreenBloc extends Cubit<SocialAppStates> {
  HomeScreenBloc() : super(HomeScreenInitialState());

  static HomeScreenBloc object(context) => BlocProvider.of(context);
  late FirebaseAuth instanceCurrentUser;
  getCurrentUser({required context}) async {
    emit(GetCurrentUserLoading());
    instanceCurrentUser = FirebaseAuth.instance;
    if (instanceCurrentUser.currentUser != null) {
      emit(GetCurrentUserSuccess());
      print(instanceCurrentUser.currentUser!.email);
      return instanceCurrentUser;
    } else {
      emit(GetCurrentUserFail());
    }
  }

  Future<void> sendEmailVerification({required context}) async {
    emit(SendVerificationEmailLoading());
    return await instanceCurrentUser.currentUser!
        .sendEmailVerification()
        .then((value) {
      emit(SendVerificationEmailSuccess());
      return value;
    }).catchError(
      (error) {
        print('Error ${error.message}');
        emit(SendVerificationEmailFail(error.message));
      },
    );
  }

  signOut({required context}) async {
    emit(SignOutLoading());
    await instanceCurrentUser.signOut().then((value) {
      emit(SignOutSuccess());
      navigateToWithReplacement(
          context: context, nextPage: const LoginScreen());
    }).catchError((error) {
      print('Error happen while sign out $error');
      emit(SignOutFail());
    });
  }

  int bottomNavigationCurrentIndex = 0;
  List screens = [
    const FeedsScreen(),
    const ChatScreen(),
    const AddNewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List appBarTitle = [
    'News Feeds',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];
  changeBottomNavigationBarIndex({required int newIndex}) {
    if (newIndex == 2) {
      emit(OpenAddNewPostScreen());
    } else {
      bottomNavigationCurrentIndex = newIndex;
      emit(ChangeBottomNavigationIndex());
    }
  }
}
