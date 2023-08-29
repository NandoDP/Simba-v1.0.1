import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/models/destination.dart';
import 'package:simba/models/post_store.dart';
import 'package:simba/theme/colors.dart';

class BottomDrawerDestinations extends StatelessWidget {
  const BottomDrawerDestinations({
    required this.destinations,
    required this.drawerController,
    required this.dropArrowController,
    required this.onItemTapped,
  });

  final List<Destination> destinations;
  final AnimationController drawerController;
  final AnimationController dropArrowController;
  final ValueChanged<String> onItemTapped;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        for (var destination in destinations)
          InkWell(
            onTap: () {
              onItemTapped(destination.name);
              drawerController.reverse();
              dropArrowController.forward();
            },
            child: Selector<PostStore, String>(
              selector: (context, emailStore) =>
                  emailStore.currentlySelectedInFuture,
              builder: (context, currentlySelectedInbox, child) {
                return ListTile(
                  leading: ImageIcon(
                    AssetImage(
                      destination.icon,
                    ),
                    color: destination.name == currentlySelectedInbox
                        ? theme.colorScheme.secondary
                        : ReplyColors.white50.withOpacity(0.64),
                  ),
                  title: Text(
                    destination.name,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: destination.name == currentlySelectedInbox
                          ? theme.colorScheme.secondary
                          : ReplyColors.white50.withOpacity(0.64),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
