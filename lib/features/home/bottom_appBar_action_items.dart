import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/features/core/profile_avatar.dart';
import 'package:simba/models/post_store.dart';
import 'package:simba/models/route_provider.dart';
import 'package:simba/models/user_model.dart';
import 'package:simba/routes.dart';
import 'package:simba/theme/colors.dart';

import 'widgets/settings_bottom_sheet.dart';

const _iconAssetLocation = 'assets/new/reply/icons';

class BottomAppBarActionItems extends StatelessWidget {
  const BottomAppBarActionItems({
    required this.drawerController,
    required this.drawerVisible,
  });

  final AnimationController drawerController;
  final bool drawerVisible;

  @override
  Widget build(BuildContext context) {
    return Consumer<PostStore>(
      builder: (context, model, child) {
        final onMailView = model.onPostView;
        var radius = const Radius.circular(12);
        final modalBorder = BorderRadius.only(
          topRight: radius,
          topLeft: radius,
        );
        Color? starIconColor;

        if (onMailView) {
          var currentEmailStarred = false;

          if (model.posts[model.currentlySelectedInFuture]!.isNotEmpty) {
            currentEmailStarred = model.isPostStarred(
              model.posts[model.currentlySelectedInFuture]!
                  .elementAt(model.currentlySelectedEmailId),
            );
          }

          starIconColor = currentEmailStarred
              ? Theme.of(context).colorScheme.secondary
              : ReplyColors.white50;
        }

        return drawerVisible
            ? Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: IconButton(
                  icon: const Icon(Icons.search),
                  color: ReplyColors.white50,
                  onPressed: () {
                    Provider.of<RouterProvider>(
                      context,
                      listen: false,
                    ).routePath = const SimbaSearchPath();
                  },
                ),
              )
            : onMailView
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: ImageIcon(
                          const AssetImage(
                            '$_iconAssetLocation/twotone_star.png',
                          ),
                          color: starIconColor,
                        ),
                        onPressed: () {
                          // model.starEmail(
                          //   model.currentlySelectedInbox,
                          //   model.currentlySelectedEmailId,
                          // );
                          // if (model.currentlySelectedInbox == 'Starred') {
                          //   mobileMailNavKey.currentState!.pop();
                          //   model.currentlySelectedEmailId = -1;
                          // }
                        },
                        color: ReplyColors.white50,
                      ),
                      IconButton(
                        icon: const ImageIcon(
                          AssetImage(
                            '$_iconAssetLocation/twotone_delete.png',
                          ),
                        ),
                        onPressed: () {
                          // model.deleteEmail(
                          //   model.currentlySelectedInbox,
                          //   model.currentlySelectedEmailId,
                          // );

                          // mobileMailNavKey.currentState!.pop();
                          // model.currentlySelectedEmailId = -1;
                        },
                        color: ReplyColors.white50,
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                        color: ReplyColors.white50,
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: IconButton(
                          icon: ProfileAvatar(
                            avatar: Provider.of<UserM>(context).profilePic,
                          ),
                          color: ReplyColors.white50,
                          onPressed: () {
                            Provider.of<RouterProvider>(
                              context,
                              listen: false,
                            ).routePath = const SimbaProfilPath();
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: IconButton(
                          icon: const Icon(Icons.settings),
                          color: ReplyColors.white50,
                          onPressed: () async {
                            drawerController.reverse();
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: modalBorder,
                              ),
                              builder: (context) => const SettingsBottomSheet(),
                            );
                          },
                        ),
                      )
                    ],
                  );
      },
    );
  }
}
