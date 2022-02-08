import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/shared/cached/cached_helper.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class RegisterBloc extends Cubit<SocialAppStates> {
  RegisterBloc() : super(RegisterInitialState());

  static RegisterBloc object(context) => BlocProvider.of(context);
  bool isPasswordHidden = true;
  changePasswordState() {
    isPasswordHidden = !isPasswordHidden;
    emit(ChangeRegisterPasswordStateFromShowToHidden());
  }

  String messageError = '';
  registerWithEmailAndPassword(
      {required email, required password, required name, required phone}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) async {
        print(value);
        if (value.user!.emailVerified == false) {
          try {
            emit(PleaseVerifyYourAccountState());
            await _addUser(
              uid: value.user!.uid,
              name: name,
              phone: phone,
              email: email,
              emailVerification: value.user!.emailVerified,
            );
            /*await CachedHelper.setData(
              key: kLoginUid,
              value: value.user!.uid.toString(),
            );*/
          } catch (e) {
            print(e);
          }
        } else {
          try {
            emit(RegisterSuccessState());
            await _addUser(
              uid: value.user!.uid,
              name: name,
              phone: phone,
              email: email,
              emailVerification: value.user!.emailVerified,
            );
            await CachedHelper.setData(
              key: kLoginUid,
              value: value.user!.uid.toString(),
            );
          } catch (e) {
            print(e);
          }
        }
      },
    ).catchError(
      (error) {
        if (error.code == 'weak-password') {
          messageError = 'The password provided is too weak.';
        } else if (error.code == 'email-already-in-use') {
          messageError = 'The account already exists for that email.';
        } else {
          messageError = error.message;
        }
        emit(RegisterFailState(messageError));
      },
    );
  }

  _addUser({
    required name,
    required email,
    required phone,
    required uid,
    required emailVerification,
  }) async {
    try {
      emit(CreateUserLoadingState());

      UserModel model = UserModel.fromJson({
        'name': name,
        'email': email,
        'phone': phone,
        'uId': uid,
        'image':
            'https://image.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740',
        'emailVerification': emailVerification,
        'bio': 'Write your bio.....',
      });
      FirebaseFirestore.instance.collection('users').doc(uid).set(
            model.toJson(),
          );
      emit(CreateUserSuccessState());
    } catch (e) {
      print(e);
      emit(CreateUserFailState());
    }
  }
}
