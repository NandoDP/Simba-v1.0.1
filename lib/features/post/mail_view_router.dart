import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/features/core/custom_transition_page.dart';
import 'package:simba/models/post_store.dart';

import '../home/home.dart';
import '../home/inbox.dart';

class PageViewRouterDelegate extends RouterDelegate<void>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  PageViewRouterDelegate({required this.drawerController});

  final AnimationController drawerController;

  @override
  Widget build(BuildContext context) {
    bool handlePopPage(Route<dynamic> route, dynamic result) {
      return false;
    }

    return Selector<PostStore, String>(
      selector: (context, emailStore) => emailStore.currentlySelectedInFuture,
      builder: (context, currentlySelectedInFuture, child) {
        return Navigator(
          key: navigatorKey,
          onPopPage: handlePopPage,
          pages: [
            CustomTransitionPage(
              transitionKey: ValueKey(currentlySelectedInFuture),
              screen: InboxPage(
                destination: currentlySelectedInFuture,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => mobileMailNavKey;

  @override
  Future<bool> popRoute() {
    var postStore =
        Provider.of<PostStore>(navigatorKey.currentContext!, listen: false);
    bool onCompose = postStore.onCompose;

    bool onPostView = postStore.onPostView;

    // Handles the back button press when we are on the HomePage. When the
    // drawer is visible reverse the drawer and do nothing else. If the drawer
    // is not visible then we check if we are on the main mailbox. If we are on
    // main mailbox then our app will close, if not then it will set the
    // mailbox to the main mailbox.
    if (!(onPostView || onCompose)) {
      if (postStore.bottomDrawerVisible) {
        drawerController.reverse();
        return SynchronousFuture<bool>(true);
      }

      if (postStore.currentlySelectedInFuture != 'A venir') {
        postStore.currentlySelectedInFuture = 'A venir';
        return SynchronousFuture<bool>(true);
      }
      return SynchronousFuture<bool>(false);
    }

    // Handles the back button when on the [ComposePage].
    if (onCompose) {
      // TODO: Add Container Transform from FAB to compose email page (Motion)
      postStore.onCompose = false;
      return SynchronousFuture<bool>(false);
    }

    // Handles the back button when the bottom drawer is visible on the
    // MailView. Dismisses the drawer on back button press.
    if (postStore.bottomDrawerVisible && onPostView) {
      drawerController.reverse();
      return SynchronousFuture<bool>(true);
    }

    // Handles the back button press when on the MailView. If there is a route
    // to pop then pop it, and reset the currentlySelectedEmailId to -1
    // to notify listeners that we are no longer on the MailView.
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
      Provider.of<PostStore>(navigatorKey.currentContext!, listen: false)
          .currentlySelectedPostId = -1;
      return SynchronousFuture<bool>(true);
    }

    return SynchronousFuture<bool>(false);
  }

  @override
  Future<void> setNewRoutePath(void configuration) {
    // This function will never be called.
    throw UnimplementedError();
  }
}

// TODO: Add Fade through transition between mailbox pages (Motion)
