import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          emit(PleaseVerifyYourAccountState());
        } else {
          emit(RegisterSuccessState());
        }
        _addUser(
          uid: value.user!.uid,
          name: name,
          phone: phone,
          email: email,
          emailVerification: value.user!.emailVerified,
        );
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

  _addUser(
      {required name,
      required email,
      required phone,
      required uid,
      required emailVerification}) async {
    try {
      emit(CreateUserLoadingState());

      FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'name': name,
          'email': email,
          'phone': phone,
          'uId': uid,
          'emailVerification': emailVerification,
        },
      );
      emit(CreateUserSuccessState());
    } catch (e) {
      print(e);
      emit(CreateUserFailState());
    }
  }
}
