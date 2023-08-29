import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/models/post_store.dart';

import 'widgets/mail_card_preview.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({required this.destination, Key? key}) : super(key: key);

  final String destination;

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 4.0;

    return Consumer<PostStore>(
      builder: (context, model, child) {
        // final ok = Provider.of<List<Post>?>(context);
        return SafeArea(
          bottom: false,
          child: model.posts[destination]!.isEmpty
              ? Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4.5),
                  alignment: Alignment.center,
                  child: const Column(
                    children: [
                      Text(
                        '😅',
                        style: TextStyle(fontSize: 70),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Aucune activité',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Créez votre activité dès maintenant',
                        style: TextStyle(
                          color: Color.fromARGB(255, 130, 130, 130),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '👇',
                        style: TextStyle(fontSize: 35),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: model.posts[destination]!.length,
                  padding: const EdgeInsetsDirectional.only(
                    start: horizontalPadding,
                    end: horizontalPadding,
                    bottom: kToolbarHeight,
                  ),
                  primary: false,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    return MailPreviewCard(
                      id: index,
                      post: model.posts[destination]!.elementAt(index),
                      onDelete: () {},
                      onStar: () {},
                    );
                  },
                ),
        );
      },
    );
  }
}
