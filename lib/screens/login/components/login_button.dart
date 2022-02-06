import 'package:flutter/material.dart';
import 'package:social_media_app/shared/cubit/bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.width,
    required this.password,
    required this.email,
  }) : super(key: key);

  final double width;
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: width / 20,
        end: width / 20,
      ),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: () {
          //ToDo:Login Validate and login to app
          if (Form.of(context)!.validate()) {
            LoginBloc.object(context).loginWithEmailAndPassword(
              email: email,
              password: password,
            ) /*
                .then((value) {
              print(value);
            }).catchError((error) {
              print('Error While sign in $error');
            })*/
                ;
          }
        },
        child: const Text('LOGIN'),
      ),
    );
  }
}
