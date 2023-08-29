import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/features/core/utils.dart';
import 'package:simba/models/post_model.dart';
import 'package:simba/models/post_store.dart';

import '../../../theme/colors.dart';
import '../home.dart';
import '../../post/view/post_view_page.dart';
import '../../core/profile_avatar.dart';

class MailPreviewCard extends StatelessWidget {
  const MailPreviewCard({
    Key? key,
    required this.id,
    required this.post,
    required this.onDelete,
    required this.onStar,
  }) : super(key: key);

  final int id;
  final Post post;
  final VoidCallback onDelete;
  final VoidCallback onStar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final currentPostInFuture = Provider.of<PostStore>(
      context,
      listen: false,
    ).isPostStarred(post);

    final colorScheme = theme.colorScheme;
    final mailPreview = _MailPreview(
      id: id,
      post: post,
      onStar: onStar,
      onDelete: onDelete,
    );
    final onStarredInbox = Provider.of<PostStore>(
          context,
          listen: false,
        ).currentlySelectedInFuture ==
        'A venir';

    return Material(
      color: theme.cardColor,
      child: InkWell(
        onTap: () {
          Provider.of<PostStore>(
            context,
            listen: false,
          ).currentlySelectedPostId = id;

          Provider.of<PostStore>(
            context,
            listen: false,
          ).currentlySelectedPageInPost = 1;

          mobileMailNavKey.currentState!.push(
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return PageViewPage(id: id, post: post);
              },
            ),
          );
        },
        child: Dismissible(
          key: ObjectKey(post),
          dismissThresholds: const {
            DismissDirection.startToEnd: 0.8,
            DismissDirection.endToStart: 0.4,
          },
          onDismissed: (direction) {
            switch (direction) {
              case DismissDirection.endToStart:
                if (onStarredInbox) {
                  onStar();
                }
                break;
              case DismissDirection.startToEnd:
                onDelete();
                break;
              default:
            }
          },
          background: _DismissibleContainer(
            icon: 'twotone_delete',
            backgroundColor: colorScheme.error,
            iconColor: ReplyColors.blue50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsetsDirectional.only(start: 20),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              if (onStarredInbox) {
                return true;
              }
              onStar();
              return false;
            } else {
              return true;
            }
          },
          secondaryBackground: _DismissibleContainer(
            icon: 'twotone_star',
            backgroundColor: currentPostInFuture
                ? colorScheme.secondary
                : theme.scaffoldBackgroundColor,
            iconColor: currentPostInFuture
                ? colorScheme.onSecondary
                : colorScheme.onBackground,
            alignment: Alignment.centerRight,
            padding: const EdgeInsetsDirectional.only(end: 20),
          ),
          child: mailPreview,
        ),
      ),
    );
  }
}

// TODO: Add Container Transform transition from email list to email detail page (Motion)

class _DismissibleContainer extends StatelessWidget {
  const _DismissibleContainer({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.alignment,
    required this.padding,
  });

  final String icon;
  final Color backgroundColor;
  final Color iconColor;
  final Alignment alignment;
  final EdgeInsetsDirectional padding;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: alignment,
      color: backgroundColor,
      curve: standardEasing,
      duration: kThemeAnimationDuration,
      padding: padding,
      child: Material(
        color: Colors.transparent,
        child: ImageIcon(
          AssetImage(
            'assets/new/reply/icons/$icon.png',
          ),
          size: 36,
          color: iconColor,
        ),
      ),
    );
  }
}

class _MailPreview extends StatelessWidget {
  const _MailPreview({
    required this.id,
    required this.post,
    this.onStar,
    this.onDelete,
  });

  final int id;
  final Post post;
  final VoidCallback? onStar;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${post.username} - ${post.date.day.toString().padLeft(2, '0')} ${monthInLetter(post.date.month)} ${post.date.year}',
                            style: textTheme.bodySmall,
                          ),
                          const SizedBox(height: 4),
                          Text(post.title, style: textTheme.headlineSmall),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    _MailPreviewActionBar(
                      avatar: post.userAvatar,
                    ),
                  ],
                ),
                if (post.description != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 20,
                    ),
                    child: Text(
                      post.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                // if (email.containsPictures) ...[
                //   Flexible(
                //     fit: FlexFit.loose,
                //     child: Column(
                //       children: const [
                //         SizedBox(height: 20),
                //         _PicturePreview(),
                //       ],
                //     ),
                //   ),
                // ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PicturePreview extends StatelessWidget {
  const _PicturePreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 4),
            child: Image.asset(
              'assets/new/reply/attachments/paris_${index + 1}.jpg',
              gaplessPlayback: true,
            ),
          );
        },
      ),
    );
  }
}

class _MailPreviewActionBar extends StatelessWidget {
  const _MailPreviewActionBar({
    required this.avatar,
    // required this.isStarred,
    // this.onStar,
    // this.onDelete,
  });

  final String avatar;
  // final bool isStarred;
  // final VoidCallback? onStar;
  // final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(avatar: avatar),
      ],
    );
  }
}
