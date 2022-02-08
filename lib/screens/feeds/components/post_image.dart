import 'package:flutter/material.dart';

import 'custom_cached_network_image.dart';

class PostImage extends StatelessWidget {
  const PostImage({
    Key? key,
    required this.subImage2,
    required this.height,
  }) : super(key: key);

  final String subImage2;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: CustomCachedNetworkImage(
        imageUrl: subImage2,
      ),
    );
  }
}
