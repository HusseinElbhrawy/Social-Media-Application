import 'package:flutter/material.dart';
import 'package:social_media_app/shared/config/const.dart';
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
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: kDefaultPadding,
        start: kDefaultPadding * 2,
        end: kDefaultPadding * 2,
      ),
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: width / 20,
          end: width / 20,
        ),
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            minimumSize: MaterialStateProperty.all(
              Size(
                width,
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? width / 10
                    : width / 15,
              ),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: () {
            //ToDo:Login Validate and login to app
            if (Form.of(context)!.validate()) {
              LoginBloc.object(context).loginWithEmailAndPassword(
                email: email,
                password: password,
              );
            }
          },
          child: const Text('LOGIN'),
        ),
      ),
    );
  }
}
