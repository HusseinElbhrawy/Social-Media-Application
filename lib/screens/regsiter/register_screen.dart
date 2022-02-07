import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/screens/home/home_screen.dart';
import 'package:social_media_app/screens/login/components/custom_button.dart';
import 'package:social_media_app/screens/login/components/custom_text_form_filed.dart';
import 'package:social_media_app/shared/config/components.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/register_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static final formKey = GlobalKey<FormState>();
  static final emailController = TextEditingController();
  static final userNameController = TextEditingController();
  static final passwordController = TextEditingController();
  static final phoneController = TextEditingController();

  void clearController() {
    emailController.clear();
    userNameController.clear();
    passwordController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Form(
      key: formKey,
      child: BlocProvider(
        create: (BuildContext context) => RegisterBloc(),
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: kDefaultPadding * 2,
                    top: kDefaultPadding * 4,
                  ),
                  child: Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'firecode',
                        ),
                  ),
                ),
                const Divider(color: Colors.white),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: kDefaultPadding * 2,
                  ),
                  child: Text(
                    'Register now to communicate with friends',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontFamily: 'firecode'),
                  ),
                ),
                const Divider(color: Colors.white),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding * 2),
                  child: CustomTextFormFiled(
                    validateMessage: 'User Name must not be empty',
                    keyboardType: TextInputType.name,
                    controller: userNameController,
                    prefixIcon: Icons.person_outlined,
                    hintLabel: 'User Name',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding * 2),
                  child: CustomTextFormFiled(
                    validateMessage: 'Email Address must not be empty',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    prefixIcon: Icons.email_outlined,
                    hintLabel: 'Email Address',
                  ),
                ),
                BlocConsumer<RegisterBloc, SocialAppStates>(
                  listener: (BuildContext context, state) {},
                  builder: (BuildContext context, Object? state) {
                    var registerCubit = RegisterBloc.object(context);

                    return Padding(
                      padding: const EdgeInsets.all(kDefaultPadding * 2),
                      child: CustomTextFormFiled(
                        validateMessage: 'Password must not be empty',
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: registerCubit.isPasswordHidden,
                        suffixIcon: IconButton(
                          onPressed: () {
                            registerCubit.changePasswordState();
                          },
                          icon: registerCubit.isPasswordHidden
                              ? const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black,
                                ),
                        ),
                        controller: passwordController,
                        prefixIcon: Icons.lock_outlined,
                        hintLabel: 'Password',
                      ),
                    );
                  },
                ),
                BlocConsumer<RegisterBloc, SocialAppStates>(
                  listener: (BuildContext context, state) {},
                  builder: (BuildContext context, Object? state) {
                    return Padding(
                      padding: const EdgeInsets.all(kDefaultPadding * 2),
                      child: CustomTextFormFiled(
                        keyboardType: TextInputType.phone,
                        validateMessage: 'Phone number not must be empty',
                        controller: phoneController,
                        prefixIcon: Icons.phone_outlined,
                        hintLabel: 'Phone',
                        onFieldSubmitted: (newValue) {
                          validateAndRegister(
                            RegisterBloc.object(context),
                            email: emailController.text,
                            password: passwordController.text,
                            name: userNameController.text,
                            phone: phoneController.text,
                          );
                        },
                      ),
                    );
                  },
                ),
                Divider(
                  color: Colors.black,
                  indent: width / 25,
                  endIndent: width / 25,
                ),
                BlocConsumer<RegisterBloc, SocialAppStates>(
                  listener: (BuildContext context, state) {
                    if (state is PleaseVerifyYourAccountState) {
                      Navigator.popUntil(
                        context,
                        (_) => !Navigator.canPop(context),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const HomeScreen(),
                        ),
                      );
                    } else if (state is RegisterFailState) {
                      errorMotionToast(state.messageError.toString())
                          .show(context);
                    }
                  },
                  builder: (BuildContext context, Object? state) {
                    return state is CreateUserLoadingState ||
                            state is RegisterLoadingState
                        ? const Center(child: LinearProgressIndicator())
                        : CustomButton(
                            title: 'register',
                            width: width,
                            email: emailController.text,
                            password: passwordController.text,
                            onPressed: () {
                              validateAndRegister(
                                RegisterBloc.object(context),
                                password: passwordController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                name: userNameController.text,
                              );
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateAndRegister(RegisterBloc registerCubit,
      {required email, required password, required name, required phone}) {
    if (formKey.currentState!.validate()) {
      registerCubit.registerWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
    }
  }
}
