import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/shared/cached/cached_helper.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class LoginBloc extends Cubit<SocialAppStates> {
  LoginBloc() : super(InitialState());

  static LoginBloc object(context) => BlocProvider.of(context);

  bool isPasswordHidden = true;

  changePasswordState() {
    isPasswordHidden = !isPasswordHidden;
    emit(ChangeLoginPasswordStateFromShowToHidden());
  }

  String messageError = '';
  loginWithEmailAndPassword({required email, required password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      if (value.user!.emailVerified) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .update(
          {
            'emailVerification': value.user!.emailVerified,
          },
        );
        emit(LoginSuccessState(value.user!.emailVerified));
      } else {
        emit(PleaseVerifyYourAccountState());
      }
      await CachedHelper.setData(
        key: kLoginUid,
        value: value.user!.uid.toString(),
      );
    }).catchError((error) {
      if (error.code == 'user-not-found') {
        messageError = 'No user found for that email.';
      } else if (error.code == 'wrong-password') {
        messageError = 'The email or password is invalid.';
      } else {
        messageError = error.message;
      }
      emit(LoginFailState(messageError));
    });
  }

  Future<UserCredential> _signInWithGoogleMethod() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signInWithGoogle() {
    emit(LoginLoadingState());
    _signInWithGoogleMethod().then((value) async {
      print(value.user!.uid);
      await CachedHelper.setData(
        key: kLoginUid,
        value: value.user!.uid.toString(),
      );
      emit(LoginSuccessState(value.user!.emailVerified));
    }).catchError((error) {
      print(error.message);
      emit(LoginFailState(error.message));
    });
  }
}
