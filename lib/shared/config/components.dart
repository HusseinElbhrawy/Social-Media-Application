import 'dart:io';

import 'package:flutter/material.dart';

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
