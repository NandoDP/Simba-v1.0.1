import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:simba/models/destination.dart';
import 'package:simba/models/post_store.dart';
import './animated_bottom_appBar.dart';
import './bottom_drawer_destinations.dart';
import './reply_fab.dart';

import 'widgets/bottom_drawer.dart';
import '../post/mail_view_router.dart';

const _iconAssetLocation = 'assets/new/reply/icons';
final mobileMailNavKey = GlobalKey<NavigatorState>();
const double _kFlingVelocity = 2.0;
const _kAnimationDuration = Duration(milliseconds: 300);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _drawerController;
  late final AnimationController _dropArrowController;
  late final AnimationController _bottomAppBarController;
  late final Animation<double> _drawerCurve;
  late final Animation<double> _dropArrowCurve;
  late final Animation<double> _bottomAppBarCurve;

  final _bottomDrawerKey = GlobalKey(debugLabel: 'Bottom Drawer');
  final _navigationDestinations = const <Destination>[
    Destination(
      name: 'A venir',
      icon: '$_iconAssetLocation/twotone_inbox.png',
      index: 0,
    ),
    Destination(
      name: 'Passées',
      icon: '$_iconAssetLocation/twotone_star.png',
      index: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _drawerController = AnimationController(
      duration: _kAnimationDuration,
      value: 0,
      vsync: this,
    )..addListener(() {
        if (_drawerController.status == AnimationStatus.dismissed &&
            _drawerController.value == 0) {
          Provider.of<PostStore>(
            context,
            listen: false,
          ).bottomDrawerVisible = false;
        }

        if (_drawerController.value < 0.01) {
          setState(() {});
        }
      });

    _dropArrowController = AnimationController(
      duration: _kAnimationDuration,
      vsync: this,
    );

    _bottomAppBarController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 250),
    );

    _drawerCurve = CurvedAnimation(
      parent: _drawerController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _dropArrowCurve = CurvedAnimation(
      parent: _dropArrowController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _bottomAppBarCurve = CurvedAnimation(
      parent: _bottomAppBarController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );
  }

  @override
  void dispose() {
    _drawerController.dispose();
    _dropArrowController.dispose();
    _bottomAppBarController.dispose();
    super.dispose();
  }

  void _onDestinationSelected(String destination) {
    var emailStore = Provider.of<PostStore>(
      context,
      listen: false,
    );

    if (emailStore.onPostView) {
      emailStore.currentlySelectedPostId = -1;
    }

    if (emailStore.currentlySelectedInFuture != destination) {
      emailStore.currentlySelectedInFuture = destination;
    }

    setState(() {});
  }

  bool get _bottomDrawerVisible {
    final status = _drawerController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBottomDrawerVisibility() {
    if (_drawerController.value < 0.4) {
      Provider.of<PostStore>(
        context,
        listen: false,
      ).bottomDrawerVisible = true;
      _drawerController.animateTo(0.4, curve: standardEasing);
      _dropArrowController.animateTo(0.35, curve: standardEasing);
      return;
    }

    _dropArrowController.forward();
    _drawerController.fling(
      velocity: _bottomDrawerVisible ? -_kFlingVelocity : _kFlingVelocity,
    );

    // final ValueChanged<String> updateMailbox = _onDestinationSelected;
    // showModalBottomSheet(
    //   context: context,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(12),
    //       topRight: Radius.circular(12),
    //     ),
    //   ),
    //   builder: (context) => ListView(
    //     padding: const EdgeInsets.all(12),
    //     children: [
    //       const SizedBox(height: 28),
    //       BottomDrawerDestinations(
    //         destinations: _navigationDestinations,
    //         drawerController: _drawerController,
    //         dropArrowController: _dropArrowController,
    //         onItemTapped: updateMailbox,
    //       ),
    //     ],
    //   ),
    // );
  }

  double get _bottomDrawerHeight {
    final renderBox =
        _bottomDrawerKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _drawerController.value -= details.primaryDelta! / _bottomDrawerHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_drawerController.isAnimating ||
        _drawerController.status == AnimationStatus.completed) {
      return;
    }

    final flingVelocity =
        details.velocity.pixelsPerSecond.dy / _bottomDrawerHeight;

    if (flingVelocity < 0.0) {
      _drawerController.fling(
        velocity: math.max(_kFlingVelocity, -flingVelocity),
      );
    } else if (flingVelocity > 0.0) {
      _dropArrowController.forward();
      _drawerController.fling(
        velocity: math.min(-_kFlingVelocity, -flingVelocity),
      );
    } else {
      if (_drawerController.value < 0.6) {
        _dropArrowController.forward();
      }
      _drawerController.fling(
        velocity:
            _drawerController.value < 0.6 ? -_kFlingVelocity : _kFlingVelocity,
      );
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        switch (notification.direction) {
          case ScrollDirection.forward:
            _bottomAppBarController.forward();
            break;
          case ScrollDirection.reverse:
            _bottomAppBarController.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final drawerSize = constraints.biggest;
    final drawerTop = drawerSize.height;
    final ValueChanged<String> updateMailbox = _onDestinationSelected;

    final drawerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, drawerTop + 500, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_drawerCurve);

    return Stack(
      clipBehavior: Clip.none,
      key: _bottomDrawerKey,
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: _MailRouter(
            drawerController: _drawerController,
          ),
        ),
        GestureDetector(
          onTap: () {
            _drawerController.reverse();
            _dropArrowController.reverse();
          },
          child: Visibility(
            maintainAnimation: true,
            maintainState: true,
            visible: _bottomDrawerVisible,
            child: FadeTransition(
              opacity: _drawerCurve,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).bottomSheetTheme.modalBackgroundColor,
              ),
            ),
          ),
        ),
        PositionedTransition(
          rect: drawerAnimation,
          child: Visibility(
            visible: _bottomDrawerVisible,
            child: BottomDrawer(
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              leading: BottomDrawerDestinations(
                destinations: _navigationDestinations,
                drawerController: _drawerController,
                dropArrowController: _dropArrowController,
                onItemTapped: updateMailbox,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool addMessage = Provider.of<PostStore>(
      context,
      listen: true,
    ).addMessage;
    return Scaffold(
      extendBody: true,
      body: LayoutBuilder(
        builder: _buildStack,
      ),
      bottomNavigationBar: addMessage
          ? null
          : AnimatedBottomAppBar(
              bottomAppBarController: _bottomAppBarController,
              bottomAppBarCurve: _bottomAppBarCurve,
              bottomDrawerVisible: _bottomDrawerVisible,
              drawerController: _drawerController,
              dropArrowCurve: _dropArrowCurve,
              toggleBottomDrawerVisibility: _toggleBottomDrawerVisibility,
            ),
      floatingActionButton: (_bottomDrawerVisible || addMessage)
          ? null
          : const Padding(
              padding: EdgeInsetsDirectional.only(bottom: 8),
              child: ReplyFab(),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _MailRouter extends StatelessWidget {
  const _MailRouter({required this.drawerController});

  final AnimationController drawerController;

  @override
  Widget build(BuildContext context) {
    final RootBackButtonDispatcher backButtonDispatcher =
        Router.of(context).backButtonDispatcher as RootBackButtonDispatcher;

    return Router(
      routerDelegate:
          PageViewRouterDelegate(drawerController: drawerController),
      backButtonDispatcher: ChildBackButtonDispatcher(backButtonDispatcher)
        ..takePriority(),
    );
  }
}
