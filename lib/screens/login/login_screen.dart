import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/login_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';

import 'components/custom_text_form_filed.dart';
import 'components/don_not_have_account_widget.dart';
import 'components/login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding),
                    child: Text(
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  const Divider(color: Colors.white),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding),
                    child: Text(
                      'Login now to communicate with friends',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  const Divider(color: Colors.white),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: CustomTextFormFiled(
                      validateMessage: 'Email must not be empty',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      prefixIcon: Icons.email_outlined,
                      hintLabel: 'Email Address',
                    ),
                  ),
                  BlocConsumer<LoginBloc, SocialAppStates>(
                    listener: (BuildContext context, state) {},
                    builder: (BuildContext context, Object? state) {
                      var loginCubit = LoginBloc.object(context);

                      return Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: CustomTextFormFiled(
                          validateMessage: 'Password must not be empty',
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: loginCubit.isPasswordHidden,
                          controller: passwordController,
                          prefixIcon: Icons.lock_outlined,
                          hintLabel: 'Password',
                          onFieldSubmitted: (value) {},
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginCubit.changePasswordState();
                            },
                            icon: loginCubit.isPasswordHidden
                                ? const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.black,
                    indent: width / 25,
                    endIndent: width / 25,
                  ),
                  LoginButton(
                    width: width,
                    password: passwordController.text,
                    email: emailController.text,
                  ),
                  const DontHaveAccountAndRegisterWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
