// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simba/models/post_model.dart';

class PostGalerie extends StatelessWidget {
  Post post;
  PostGalerie({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Image.asset(
          'assets/new/reply/attachments/paris_${index + 1}.jpg',
          gaplessPlayback: true,
          fit: BoxFit.fill,
        );
      },
    );
  }
}
