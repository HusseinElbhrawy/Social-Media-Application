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
}
