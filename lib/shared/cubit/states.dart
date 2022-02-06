abstract class SocialAppStates {}

class InitialState extends SocialAppStates {}

class RegisterInitialState extends SocialAppStates {}

class ChangeLoginPasswordStateFromShowToHidden extends SocialAppStates {}

class ChangeRegisterPasswordStateFromShowToHidden extends SocialAppStates {}

class LoginLoadingState extends SocialAppStates {}

class LoginSuccessState extends SocialAppStates {}

class LoginFailState extends SocialAppStates {
  final String messageError;

  LoginFailState(this.messageError);
}

class RegisterLoadingState extends SocialAppStates {}

class RegisterSuccessState extends SocialAppStates {}

class RegisterFailState extends SocialAppStates {}
