abstract class SocialAppStates {}

class InitialState extends SocialAppStates {}

class RegisterInitialState extends SocialAppStates {}

class ChangeLoginPasswordStateFromShowToHidden extends SocialAppStates {}

class ChangeRegisterPasswordStateFromShowToHidden extends SocialAppStates {}

class LoginLoadingState extends SocialAppStates {}

class PleaseVerifyYourAccountState extends SocialAppStates {}

class LoginSuccessState extends SocialAppStates {
  final bool isEmailVerified;

  LoginSuccessState(this.isEmailVerified);
}

class LoginFailState extends SocialAppStates {
  final String messageError;

  LoginFailState(this.messageError);
}

class RegisterLoadingState extends SocialAppStates {}

class RegisterSuccessState extends SocialAppStates {}

class RegisterFailState extends SocialAppStates {
  final String messageError;

  RegisterFailState(this.messageError);
}

class CreateUserLoadingState extends SocialAppStates {}

class CreateUserSuccessState extends SocialAppStates {}

class CreateUserFailState extends SocialAppStates {
  // final String messageError;
  //
  // CreateUserFailState(this.messageError);
}
