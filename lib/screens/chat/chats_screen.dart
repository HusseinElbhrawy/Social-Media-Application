import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/screens/chat_details/chat_details_screen.dart';
import 'package:social_media_app/shared/config/components.dart';
import 'package:social_media_app/shared/cubit/bloc/chat_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';

import '../../shared/config/const.dart';
import '../feeds/components/user_image.dart';
import '../feeds/components/user_name_and_date.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (BuildContext context) => ChatScreenBloc()..getAllUsers(),
      child: BlocConsumer<ChatScreenBloc, SocialAppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var chatScreenBloc = ChatScreenBloc.object(context);
          return state is GetAllUsersLoading
              ? const LinearProgressIndicator()
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ChatItemWidget(
                    image:
                        chatScreenBloc.allUsers[index].profileImage.toString(),
                    name: chatScreenBloc.allUsers[index].name.toString(),
                    width: width,
                    onTap: () {
                      navigateTo(
                        context: context,
                        nextPage: ChatDetailsScreen(
                          userModel: chatScreenBloc.allUsers[index],
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: chatScreenBloc.allUsers.length,
                );
        },
      ),
    );
  }
}

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({
    Key? key,
    required this.width,
    required this.onTap,
    required this.name,
    required this.image,
  }) : super(key: key);

  final double width;
  final Function onTap;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding * 1.5),
      child: InkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            UserImage(
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? width / 6
                  : width / 15,
              profileImage: image,
            ),
            const SizedBox(width: 15),
            UserNameAndDate(
              hidePostDate: true,
              width: width,
              userName: name,
            ),
          ],
        ),
      ),
    );
  }
}
