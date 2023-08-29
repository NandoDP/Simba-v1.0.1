import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/features/core/utils.dart';
import 'package:simba/features/post/add/add_post_page.dart';
import 'package:simba/models/post_store.dart';

class ReplyFab extends StatefulWidget {
  const ReplyFab();

  @override
  ReplyFabState createState() => ReplyFabState();
}

class ReplyFabState extends State<ReplyFab>
    with SingleTickerProviderStateMixin {
  static const double _mobileFabDimension = 56;
  File? image;

  void addImage() async {
    final res = await pickImage();
    // final user = ref.read(userProvider)!;
    if (res != null) {
      setState(() {
        image = File(res.files.first.path!);
      });
      // ref.read(postControllerProvider.notifier).shareImage(
      //       context: context,
      //       post: post,
      //       uid: user.uid,
      //       file: image,
      //     );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const circleFabBorder = CircleBorder();

    return Selector<PostStore, List<bool>>(
      selector: (context, emailStore) => [
        emailStore.onPostView,
        emailStore.onMessageView,
        emailStore.onGalerieView,
      ],
      builder: (context, allView, child) {
        final onPostView = allView[0];
        final onMessageView = allView[1];
        final onGalerieView = allView[2];
        final fabSwitcher = (!onPostView || onMessageView)
            ? const Icon(
                Icons.create,
                color: Colors.black,
              )
            : onGalerieView
                ? const Icon(
                    Icons.add,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.reply_all,
                    color: Colors.black,
                  );
        final tooltip = !onPostView
            ? 'Poster'
            : allView[1]
                ? 'Message'
                : allView[2]
                    ? 'Ajouter'
                    : 'Retour';

        return Material(
          color: theme.colorScheme.secondary,
          shape: circleFabBorder,
          child: Tooltip(
            message: tooltip,
            child: InkWell(
              customBorder: circleFabBorder,
              onTap: () {
                if (onPostView) {
                  if (onMessageView) {
                    Provider.of<PostStore>(
                      context,
                      listen: false,
                    ).addMessage = true;
                  } else if (onGalerieView) {
                    addImage();
                  } else {
                    Provider.of<PostStore>(
                      context,
                      listen: false,
                    ).currentlySelectedPostId = -1;
                    // Navigator.pop(context);
                  }
                } else {
                  Provider.of<PostStore>(
                    context,
                    listen: false,
                  ).onCompose = true;

                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (
                        BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return const AddPostPage();
                      },
                    ),
                  );
                }
              },
              child: SizedBox(
                height: _mobileFabDimension,
                width: _mobileFabDimension,
                child: Center(
                  child: fabSwitcher,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
