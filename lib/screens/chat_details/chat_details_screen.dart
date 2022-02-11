import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/shared/cubit/bloc/chat_details_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';
import 'package:social_media_app/shared/styles/IconBroken.dart';

import 'components/appbar_title.dart';
import 'components/message_send_button.dart';
import 'components/receiver_message_widget.dart';
import 'components/sender_message_widget.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;
  static final TextEditingController messageController =
      TextEditingController();
  static final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => ChatDetailsScreenBloc(),
      child: BlocConsumer<ChatDetailsScreenBloc, SocialAppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var chatDetailsScreenCubit = ChatDetailsScreenBloc.object(context);
          print(chatDetailsScreenCubit.currentUserUid);
          print(userModel.uId);
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userModel.uId)
                .collection('chats')
                .doc(chatDetailsScreenCubit.currentUserUid)
                .collection('messages')
                .orderBy('dateTime')
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: AppBarTitle(
                    userImage: userModel.profileImage.toString(),
                    height: height,
                    userName: userModel.name.toString(),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        chatDetailsScreenCubit.scrollDownToEndOfList(
                          scrollController: scrollController,
                        );
                      },
                      icon: const Icon(IconBroken.Arrow___Down_Square),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: snapshot.hasData
                          ? ListView.builder(
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (userModel.uId !=
                                    snapshot.data!.docs[index]
                                        .data()['receiverId']) {
                                  return SenderMessageWidget(
                                    userImage:
                                        userModel.profileImage.toString(),
                                    message: snapshot.data!.docs[index]
                                        .data()['messageText'],
                                  );
                                } else {
                                  return ReceiverMessageWidget(
                                    message: snapshot.data!.docs[index]
                                        .data()['messageText'],
                                  );
                                }
                              },
                              itemCount: snapshot.data!.docs.length,
                            )
                          : const LinearProgressIndicator(),
                    ),
                    MessageAndSendButton(
                      scrollController: scrollController,
                      height: height,
                      width: width,
                      chatDetailsScreenCubit: chatDetailsScreenCubit,
                      userModel: userModel,
                    ),
                  ],
                ),

                // extendBody: true,
              );
            },
          );
        },
      ),
    );
  }
}
