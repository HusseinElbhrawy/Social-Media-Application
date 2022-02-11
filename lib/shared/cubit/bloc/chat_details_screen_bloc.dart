import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/models/message_model.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class ChatDetailsScreenBloc extends Cubit<SocialAppStates> {
  ChatDetailsScreenBloc() : super(ChatDetailsScreenInitialState());

  static ChatDetailsScreenBloc object(context) => BlocProvider.of(context);

  String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  var firebaseFirestore = FirebaseFirestore.instance;

  sendMessage(
      {required receiverId, required messageText, required date}) async {
    emit(SendMessageLoading());
    MessageModel model = MessageModel(
      date,
      receiverId,
      currentUserUid,
      messageText,
    );

    await firebaseFirestore
        .collection('users')
        .doc(currentUserUid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError(
      (error) {
        emit(SendMessageFail());
      },
    );
    emit(SendMessageLoading());
    await firebaseFirestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(currentUserUid)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError(
      (error) {
        emit(SendMessageFail());
      },
    );
  }

  void scrollDownToEndOfList({required scrollController}) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
