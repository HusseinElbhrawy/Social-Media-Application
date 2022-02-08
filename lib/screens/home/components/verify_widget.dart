import 'package:flutter/material.dart';

class VerifyWarningWidget extends StatelessWidget {
  const VerifyWarningWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child: ListTile(
        leading: const Icon(
          Icons.info,
          color: Colors.black,
        ),
        title: Text(
          'Please log in again to Verify Your account',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'firecode',
              ),
        ),
        trailing: TextButton(
          onPressed: () => onTap(),
          child: Text('Done'.toUpperCase()),
        ),
      ),
    );
  }
}
