import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class EditScreenBloc extends Cubit<SocialAppStates> {
  EditScreenBloc() : super(EditScreenInitialState());

  static EditScreenBloc object(context) => BlocProvider.of(context);

  File? profileImage, coverImage;
  final ImagePicker _picker = ImagePicker();

  getProfileImage() async {
    emit(PickedProfileImageLoading());

    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      print(profileImage!.path);
      print(profileImage!.absolute);
      print(profileImage!.parent);
      print(profileImage!.uri);
      print(profileImage);
      emit(PickedProfileImageSuccess());
    } else {
      print('No image Selected ');
      emit(PickedProfileImageFail());
    }
  }

  getProfileCover() async {
    emit(PickedProfileCoverLoading());

    final pickedCover = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedCover != null) {
      coverImage = File(pickedCover.path);
      print(profileImage!.path);
      print(profileImage!.absolute);
      print(profileImage!.parent);
      print(profileImage!.uri);
      print(profileImage);
      emit(PickedProfileCoverSuccess());
    } else {
      print('No image Selected ');
      emit(PickedProfileCoverFail());
    }
  }
}
