import 'package:flutter/material.dart';
import 'package:social_media_app/shared/config/const.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.width,
    required this.password,
    required this.email,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final double width;
  final String email;
  final String password;
  final Function onPressed;
  final String title;

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
          onPressed: () => onPressed(),
          child: Text(title.toUpperCase()),
        ),
      ),
    );
  }
}
