import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class ChatScreenBloc extends Cubit<SocialAppStates> {
  ChatScreenBloc() : super(ChatScreenInitialState());
  static ChatScreenBloc object(context) => BlocProvider.of(context);
  List<UserModel> allUsers = [];
  getAllUsers() async {
    emit(GetAllUsersLoading());
    if (allUsers.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != FirebaseAuth.instance.currentUser?.uid) {
            allUsers.add(UserModel.fromJson(element.data()));
          }
        });
        emit(GetAllUsersSuccess());
      }).catchError(
        (error) {
          print('Error happen while get all users $error');
          emit(SendMessageSuccess());
        },
      );
    }
  }
}
