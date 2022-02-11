import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc/feeds_screen_bloc.dart';
import 'package:social_media_app/shared/cubit/states.dart';

import 'components/custom_cached_network_image.dart';
import 'components/post_widget.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<TextEditingController> _controllers = [];

    return BlocProvider(
      create: (BuildContext context) => FeedsScreenBloc()..getCurrentUserData(),
      child: BlocConsumer<FeedsScreenBloc, SocialAppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var feedsScreenCubit = FeedsScreenBloc.object(context);
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy(
                    'dateTime',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData || state is GetCurrentUserDataLoading) {
                  return const LinearProgressIndicator();
                } else {
                  return Column(
                    children: [
                      Card(
                        elevation: 7.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Visibility(
                              visible: feedsScreenCubit.currentUserData != null,
                              child: CustomCachedNetworkImage(
                                imageUrl: feedsScreenCubit
                                    .currentUserData!['coverImage']
                                    .toString(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.all(kDefaultPadding * 1.5),
                              child: Text(
                                'Communicate With Friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'firecode',
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          _controllers.add(TextEditingController());
                          return PostWidget(
                            commentController: _controllers[index],
                            index: index,
                            postId: snapshot.data!.docs[index].id,
                            postText: snapshot.data!.docs[index]['text'],
                            postDate: snapshot.data!.docs[index]['dateTime'],
                            userName: feedsScreenCubit.currentUserData!['name'],
                            height: height,
                            subImage:
                                feedsScreenCubit.currentUserData!['image'],
                            subImage2: snapshot.data!.docs[index]['postImage'],
                            width: width,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      ),
                    ],
                  );
                }
              });
        },
      ),
    );
  }
}
