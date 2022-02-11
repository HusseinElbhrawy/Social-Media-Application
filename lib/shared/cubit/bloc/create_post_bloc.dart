import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class CreatePostBloc extends Cubit<SocialAppStates> {
  CreatePostBloc() : super(CreatePostScreenInitialState());

  static CreatePostBloc object(context) => BlocProvider.of(context);

  Future<void> createPost({
    required text,
  }) async {
    emit(CreatePostLoading());
    var currentUserUId = FirebaseAuth.instance.currentUser!.uid;
    var currentUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUId)
        .get();

    PostModel model = PostModel(
      currentUser['name'],
      currentUserUId.toString(),
      currentUser['image'],
      text,
      imageUrl ?? '',
      DateTime.now().toString(),
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(
          model.toJson(),
        )
        .then((value) {
      print(value.id);
      emit(CreatePostSuccess());
    }).catchError((error) {
      print('Error While create post $error');
      emit(CreatePostFail());
    });
  }

  File? imageFile;
  XFile? pickedImageXFile;
  var imagePicker = ImagePicker();
  String? imageUrl;
  pickedImage() async {
    emit(PickedImageForPostLoading());
    pickedImageXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImageXFile != null) {
      imageFile = File(pickedImageXFile!.path);
      emit(PickedImageForPostSuccess());
    } else {
      print('Please Select Image');
      emit(PickedImageForPostFail());
    }
  }

  uploadPickedImage({
    required root,
    required imageName,
  }) async {
    emit(UploadPickedImageForPostLoading());
    await FirebaseStorage.instance
        .ref('$root/$imageName')
        .putFile(imageFile!)
        .then((value) async {
      imageUrl = await value.ref.getDownloadURL();
      print(value);
      emit(UploadPickedImageForPostSuccess());
    }).catchError(
      (error) {
        print('Error While upload post Image $error');
        emit(UploadPickedImageForPostFail());
      },
    );
  }

  clearImage() async {
    imageFile = null;
    emit(ClearSelectedImageForPost());
  }

  Map<String, dynamic>? currentUserData;
  getCurrentUserData() async {
    var currentUserUId = FirebaseAuth.instance.currentUser!.uid;
    emit(GetCurrentUserDataLoading());
    await FirebaseFirestore.instance
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
}
