import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/shared/cubit/bloc/settings_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class EditScreenBloc extends Cubit<SocialAppStates> {
  EditScreenBloc() : super(EditScreenInitialState());

  static EditScreenBloc object(context) => BlocProvider.of(context);

  bool editUserInformation = false;
  changeEditUserInformationState() {
    editUserInformation = !editUserInformation;
    emit(ChangeEditUserInformationState());
  }

  var imagePicker = ImagePicker();
  File? profileCoverImageFile, profileImageFile;
  var firebaseStorage = FirebaseStorage.instance;
  XFile? pickedProfileCoverImage, pickedProfileImage;

  pickedImage({required bool isProfileCover}) async {
    if (isProfileCover) {
      emit(PickedProfileCoverLoading());
      pickedProfileCoverImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedProfileCoverImage != null) {
        profileCoverImageFile = File(pickedProfileCoverImage!.path);
        emit(PickedProfileCoverSuccess());
      } else {
        print('No image Selected ');
        emit(PickedProfileCoverFail());
      }
    } else {
      emit(PickedProfileImageLoading());
      pickedProfileImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedProfileImage != null) {
        profileImageFile = File(pickedProfileImage!.path);
        emit(PickedProfileImageSuccess());
      } else {
        print('No image Selected ');
        emit(PickedProfileImageFail());
      }
    }
  }

  String? profileImageUrl, profileCoverImageUrl;
  Future<void> uploadImage({
    required String imageName,
    required String root,
    required File file,
    required bool isProfileCoverImage,
  }) async {
    emit(UploadImageToStorageLoading());

    await FirebaseStorage.instance
        .ref('$root/$imageName')
        .putFile(file)
        .then((value) async {
      print('Upload Success $value');

      isProfileCoverImage == true
          ? profileCoverImageUrl = await value.ref.getDownloadURL()
          : profileImageUrl = await value.ref.getDownloadURL();

      emit(UploadImageToStorageSuccess());
    }).catchError((error) {
      print('Error While upload image $error');
      emit(UploadImageToStorageFail());
    });
  }

  updateImagesInDatabase({profileCoverImageUrl, profileImageUrl}) async {
    var currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    emit(UpdateChangesLoading());
    FirebaseFirestore.instance.collection('users').doc(currentUserUid).update(
      {
        'coverImage': profileCoverImageUrl ??
            'https://image.freepik.com/free-vector/gradient-metaverse-background_23-2149263788.jpg?w=996',
        'image': profileImageUrl ??
            'https://image.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740',
      },
    ).then((value) {
      print('Updated Success ');
      emit(UpdateChangesSuccess());
    }).catchError((error) {
      print('Updated Fail $error');
      emit(UpdateChangesFail());
    });
  }

  Future updateUserInformation({
    required String name,
    required String bio,
    required String phone,
    required SettingsScreenBloc settingsScreenBloc,
    required String imageUrl,
    required String coverImageUrl,
  }) async {
    // UserModel userModel;
    emit(UpdateChangesLoading());
    var currentUsedUid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(currentUsedUid).update(
      {
        'name': name,
        'phone': phone,
        'bio': bio,
        'coverImage': profileCoverImageUrl ?? coverImageUrl,
        'image': profileImageUrl ?? imageUrl
/*        'coverImage': profileCoverImageUrl ??
            'https://image.freepik.com/free-vector/gradient-metaverse-background_23-2149263788.jpg?w=996',
        'image': profileImageUrl ??
            'https://image.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740',*/
      },
    ).then((value) {
      print('Updated Success');
      emit(UpdateChangesSuccess());
    }).catchError(
      (error) {
        print('Error while update data $error');
        emit(UpdateChangesFail());
      },
    );
  }
}
