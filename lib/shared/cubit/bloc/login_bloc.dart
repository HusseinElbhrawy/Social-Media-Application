import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      print(value);
      emit(LoginSuccessState());
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
}
