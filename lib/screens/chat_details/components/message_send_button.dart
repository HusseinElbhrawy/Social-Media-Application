import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../shared/config/const.dart';
import '../../../shared/cubit/bloc/chat_details_screen_bloc.dart';
import '../../../shared/styles/IconBroken.dart';

class MessageAndSendButton extends StatelessWidget {
  const MessageAndSendButton({
    Key? key,
    required this.height,
    required this.width,
    required this.chatDetailsScreenCubit,
    required this.userModel,
    required this.scrollController,
  }) : super(key: key);

  final double height;
  final double width;
  final ChatDetailsScreenBloc chatDetailsScreenCubit;
  static final TextEditingController messageController =
      TextEditingController();

  final ScrollController scrollController;
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? height / 8
          : height / 5,
      margin: const EdgeInsetsDirectional.all(kDefaultPadding),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(kDefaultPadding / 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: width / 20),
          Expanded(
            child: TextFormField(
              controller: messageController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Type your message here....',
                hintStyle: TextStyle(
                  fontFamily: 'jannah',
                ),
              ),
            ),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () async {
              chatDetailsScreenCubit.scrollDownToEndOfList(
                  scrollController: scrollController);
              await chatDetailsScreenCubit.sendMessage(
                receiverId: userModel.uId,
                messageText: messageController.text,
                date: DateTime.now().toString(),
              );

              messageController.clear();
              chatDetailsScreenCubit.scrollDownToEndOfList(
                  scrollController: scrollController);
            },
            child: const Icon(IconBroken.Send),
          )
        ],
      ),
    );
  }
}
