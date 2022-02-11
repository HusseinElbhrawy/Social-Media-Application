import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class FeedsScreenBloc extends Cubit<SocialAppStates> {
  FeedsScreenBloc() : super(FeedsScreenInitialState());

  static FeedsScreenBloc object(context) => BlocProvider.of(context);

  var firebaseFirestoreObject = FirebaseFirestore.instance;
  Map<String, dynamic>? currentUserData;

  getCurrentUserData() async {
    String currentUserUId = FirebaseAuth.instance.currentUser!.uid;
    emit(GetCurrentUserDataLoading());
    await firebaseFirestoreObject
        .collection('users')
        .doc(currentUserUId)
        .get()
        .then(
      (value) {
        currentUserData = value.data();
        emit(GetCurrentUserDataSuccess());
      },
    ).catchError((error) {
      print('Error While get current user data $error');
      emit(GetCurrentUserDataFail());
    });
  }

  addLikeToPost({required postId}) async {
    emit(AddLikeToPostLoading());

    var currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    await firebaseFirestoreObject
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(currentUserUid)
        .set({'likes': true}).then((value) {
      emit(AddLikeToPostSuccess());
    }).catchError((error) {
      print('Error while add like to post $error');
      emit(AddLikeToPostFail());
    });
  }

  addCommentToPost({required postId, required commentText}) async {
    emit(AddCommentToPostLoading());

    var currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    await firebaseFirestoreObject
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(currentUserUid)
        .set({'comments': commentText}).then((value) {
      emit(AddCommentToPostSuccess());
    }).catchError((error) {
      print('Error while add Comment to post $error');
      emit(AddCommentToPostFail());
    });
  }
}
