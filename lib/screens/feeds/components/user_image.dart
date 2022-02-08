import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/shared/config/components.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    Key? key,
    required this.width,
    required this.profileImage,
    this.inComment = false,
    this.profileImageFile,
    // this.profileImage,
  }) : super(key: key);

  final double width;
  final String profileImage;
  final bool inComment;
  final File? profileImageFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: profileImageFile != null
          ? Image.file(
              profileImageFile as File,
              width: width,
              fit: BoxFit.cover,
              height: double.infinity,
            )
          : CachedNetworkImage(
              width: width,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return CachedNetworkImageProgressIndicator(
                  downloadProgress: downloadProgress,
                );
              },
              errorWidget: (context, url, error) {
                return const CachedNetworkImageErrorWidget();
              },
              imageUrl: profileImage,
            ),
    );
  }
}
