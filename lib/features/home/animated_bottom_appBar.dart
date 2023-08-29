import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/models/post_store.dart';
import 'package:simba/theme/colors.dart';
import './bottom_appBar_action_items.dart';
import './widgets/waterfall_notched_rectangle.dart';

class AnimatedBottomAppBar extends StatelessWidget {
  const AnimatedBottomAppBar({
    required this.bottomAppBarController,
    required this.bottomAppBarCurve,
    required this.bottomDrawerVisible,
    required this.drawerController,
    required this.dropArrowCurve,
    required this.toggleBottomDrawerVisibility,
  });

  final AnimationController bottomAppBarController;
  final Animation<double> bottomAppBarCurve;
  final bool bottomDrawerVisible;
  final AnimationController drawerController;
  final Animation<double> dropArrowCurve;
  final VoidCallback toggleBottomDrawerVisibility;

  @override
  Widget build(BuildContext context) {
    var fadeOut = Tween<double>(begin: 1, end: -1).animate(
      drawerController.drive(CurveTween(curve: standardEasing)),
    );

    return Selector<PostStore, bool>(
      selector: (context, emailStore) => emailStore.onPostView,
      builder: (context, onMailView, child) {
        bottomAppBarController.forward();

        return SizeTransition(
          sizeFactor: bottomAppBarCurve,
          axisAlignment: -1,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 2),
            child: BottomAppBar(
              shape: const WaterfallNotchedRectangle(),
              notchMargin: 6,
              child: Container(
                color: Colors.transparent,
                height: kToolbarHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      onTap: toggleBottomDrawerVisibility,
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          RotationTransition(
                            turns: Tween(
                              begin: 0.0,
                              end: 1.0,
                            ).animate(dropArrowCurve),
                            child: const Icon(
                              Icons.arrow_drop_up,
                              color: ReplyColors.white50,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const _ReplyLogo(),
                          const SizedBox(width: 10),
                          onMailView
                              ? const SizedBox(width: 48)
                              : FadeTransition(
                                  opacity: fadeOut,
                                  child: Selector<PostStore, String>(
                                    selector: (context, postStore) =>
                                        postStore.currentlySelectedInFuture,
                                    builder: (
                                      context,
                                      currentlySelectedInFuture,
                                      child,
                                    ) {
                                      return Text(
                                        currentlySelectedInFuture,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: ReplyColors.white50,
                                            ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: BottomAppBarActionItems(
                          drawerController: drawerController,
                          drawerVisible: bottomDrawerVisible,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ReplyLogo extends StatelessWidget {
  const _ReplyLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      AssetImage('assets/new/reply/replylogo.png'),
      size: 32,
      color: ReplyColors.white50,
    );
  }
}
