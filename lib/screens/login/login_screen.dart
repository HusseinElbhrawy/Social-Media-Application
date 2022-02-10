import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:social_media_app/screens/home/home_screen.dart';
import 'package:social_media_app/shared/config/components.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/login_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';

import 'components/custom_button.dart';
import 'components/custom_text_form_filed.dart';
import 'components/don_not_have_account_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final formKey = GlobalKey<FormState>();

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }

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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: const Svg('assets/images/authentication.svg'),
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? height / 5
                          : height / 2,
                  fit: BoxFit.cover,
                ),
                Divider(color: Colors.white, height: height / 12),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding * 2),
                  child: CustomTextFormFiled(
                    validateMessage: 'Email must not be empty',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    prefixIcon: Icons.email_outlined,
                    hintLabel: 'Type Your Email Address',
                  ),
                ),
                BlocConsumer<LoginBloc, SocialAppStates>(
                  listener: (BuildContext context, state) {},
                  builder: (BuildContext context, Object? state) {
                    var loginCubit = LoginBloc.object(context);

                    return Padding(
                      padding: const EdgeInsets.all(kDefaultPadding * 2),
                      child: CustomTextFormFiled(
                        validateMessage: 'Password must not be empty',
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: loginCubit.isPasswordHidden,
                        controller: passwordController,
                        prefixIcon: Icons.lock_outlined,
                        hintLabel: 'Password',
                        onFieldSubmitted: (newValue) {
                          if (formKey.currentState!.validate()) {
                            LoginBloc.object(context).loginWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
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
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password ? '),
                    )
                  ],
                ),
                Divider(
                  color: Colors.black,
                  indent: width / 25,
                  endIndent: width / 25,
                ),
                BlocConsumer<LoginBloc, SocialAppStates>(
                  listener: (BuildContext context, state) async {
                    if (state is LoginFailState) {
                      errorMotionToast(state.messageError.toString())
                          .show(context);
                    } else if (state is LoginSuccessState) {
                      if (state.isEmailVerified) {
                        //ToDo: Go To Home Screen
                        navigateToWithReplacement(
                          context: context,
                          nextPage: const HomeScreen(),
                        );
                        clearController();
                      }
                    } else if (state is PleaseVerifyYourAccountState) {
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null && !user.emailVerified) {
                        await user.sendEmailVerification().then((value) {
                          return value;
                        }).catchError((error) {
                          print(error);
                        });
                      }
                      warningMotionToast().show(context);
                    }
                  },
                  builder: (BuildContext context, Object? state) {
                    if (state is LoginLoadingState) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(kDefaultPadding),
                          child: LinearProgressIndicator(),
                        ),
                      );
                    } else {
                      return CustomButton(
                        title: 'login',
                        width: width,
                        password: passwordController.text,
                        email: emailController.text,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            LoginBloc.object(context).loginWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      );
                    }
                  },
                ),
                const DontHaveAccountAndRegisterWidget(),
                const Divider(color: Colors.white),
                Text(
                  'Or Login With',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.grey),
                ),
                const Divider(color: Colors.white),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(kDefaultPadding * 2),
                    child: SignInButton(
                      Buttons.Google,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        LoginBloc.object(context).signInWithGoogle();
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
