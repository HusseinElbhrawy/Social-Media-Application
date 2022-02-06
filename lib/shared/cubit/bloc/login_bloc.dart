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
}
