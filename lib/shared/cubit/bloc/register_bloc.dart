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

  /*Future<UserCredential> registerWithEmailAndPassword(
      {required email, required password}) async {
    try {
      _userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return_userCredential;
  }*/

  registerWithEmailAndPassword({required email, required password}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        print(value);
        emit(RegisterSuccessState());
      },
    ).catchError(
      (error) {
        if (error.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (error.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        } else {
          print(error.message);
        }
        emit(RegisterFailState());
      },
    );
  }
}
