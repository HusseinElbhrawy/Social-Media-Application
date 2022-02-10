import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class SettingsScreenBloc extends Cubit<SocialAppStates> {
  SettingsScreenBloc() : super(SettingScreenInitialState());

  static SettingsScreenBloc object(context) => BlocProvider.of(context);

  late UserModel userModel;
  getCurrentUserData() async {
    emit(GetCurrentUserUId());
    var uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);
    emit(GetCurrentUserDataLoading());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!.cast());
      emit(GetCurrentUserDataSuccess());
    }).catchError((error) {
      emit(GetCurrentUserDataFail());
      print('Error happen While get current user data from firestore $error');
    });
  }
}
