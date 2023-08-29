// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/features/core/utils.dart';
import 'package:simba/models/post_model.dart';
import 'package:simba/models/post_store.dart';

import '../../core/profile_avatar.dart';
import 'post_galerie.dart';
import 'post_home.dart';
import 'post_message.dart';

class PageViewPage extends StatelessWidget {
  const PageViewPage({Key? key, required this.id, required this.post})
      : super(key: key);

  final int id;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: double.infinity,
          child: Material(
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(
                top: 42,
                start: 20,
                end: 20,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    _PageViewHeader(post: post),
                    const SizedBox(height: 32),
                    _PageViewBody(post: post),
                    // const SizedBox(height: kToolbarHeight),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PageViewHeader extends StatelessWidget {
  const _PageViewHeader({
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                post.title,
                style: textTheme.headlineMedium!.copyWith(height: 1.1),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: () {
                Provider.of<PostStore>(
                  context,
                  listen: false,
                ).addMessage = false;
                Provider.of<PostStore>(
                  context,
                  listen: false,
                ).currentlySelectedPostId = -1;
                Navigator.pop(context);
              },
              splashRadius: 20,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    '${post.username} - ${post.date.day.toString().padLeft(2, '0')} ${monthInLetter(post.date.month)} ${post.date.year}'),
                const SizedBox(height: 4),
                Text(
                  post.communityName,
                  style: textTheme.bodySmall!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.64),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 4),
              child: ProfileAvatar(avatar: post.userAvatar),
            ),
          ],
        ),
      ],
    );
  }
}

class _PageViewBody extends StatefulWidget {
  final Post post;
  const _PageViewBody({
    required this.post,
  });

  @override
  State<_PageViewBody> createState() => _PageViewBodyState();
}

class _PageViewBodyState extends State<_PageViewBody> {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      width: MediaQuery.of(context).size.width,
      child: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          Provider.of<PostStore>(
            context,
            listen: false,
          ).currentlySelectedPageInPost = index;
        },
        children: [
          PostViewMsg(post: post),
          PostHome(post: post),
          PostGalerie(post: post),
        ],
      ),
    );
  }
}
