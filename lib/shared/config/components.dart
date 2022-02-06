import 'dart:io';

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

navigateTo({required context, required nextPage}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );

navigateToWithReplacement({required context, required nextPage}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => nextPage,
      ),
    );

var information = Platform.localeName.characters.toList();
String lang = '${information[0]}${information[1]}';

class CachedNetworkImageErrorWidget extends StatelessWidget {
  const CachedNetworkImageErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.error,
      color: Colors.blue,
    );
  }
}

class CachedNetworkImageProgressIndicator extends StatelessWidget {
  const CachedNetworkImageProgressIndicator({
    Key? key,
    required this.downloadProgress,
  }) : super(key: key);
  final downloadProgress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
      ),
    );
  }
}

MotionToast errorMotionToast(state) {
  return MotionToast.error(
    title: const Text("Error"),
    description: Text(state.messageError),
    position: MOTION_TOAST_POSITION.top,
    animationType: ANIMATION.fromTop,
    toastDuration: const Duration(seconds: 1, milliseconds: 500),
  );
}

MotionToast warningMotionToast() {
  return MotionToast.warning(
    title: const Text("Warning"),
    description: const Text(
        'We sent a email verification, Please verify your account to be able to sign in '),
    position: MOTION_TOAST_POSITION.top,
    animationType: ANIMATION.fromTop,
    toastDuration: const Duration(seconds: 1, milliseconds: 1000),
  );
}
