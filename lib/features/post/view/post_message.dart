// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/features/core/profile_avatar.dart';
import 'package:simba/features/core/utils.dart';
import 'package:simba/models/post_model.dart';
import 'package:simba/models/post_service.dart';
import 'package:simba/models/post_store.dart';
import 'package:simba/models/user_model.dart';
import 'package:uuid/uuid.dart';

class PostViewMsg extends StatefulWidget {
  Post post;
  PostViewMsg({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostViewMsg> createState() => _PostViewMsgState();
}

class _PostViewMsgState extends State<PostViewMsg> {
  @override
  Widget build(BuildContext context) {
    var post = widget.post;
    final textTheme = Theme.of(context).textTheme;
    final user = Provider.of<UserM>(context);
    final messages = post.messages.reversed.toList();
    return Stack(
      children: [
        ListView(
          reverse: true,
          children: [
            const SizedBox(height: 70),
            for (var i = 0; i < messages.length; i++)
              Column(
                children: [
                  if (((i != messages.length - 1) &&
                          ("${messages[i].date.day} ${messages[i].date.month} ${messages[i].date.year}" !=
                              "${messages[i + 1].date.day} ${messages[i + 1].date.month} ${messages[i + 1].date.year}")) ||
                      (i == messages.length - 1)) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${messages[i].date.day} ${monthInLetter(messages[i].date.month)}",
                          style: textTheme.bodySmall!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.64),
                          ),
                        ),
                      ],
                    ),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: user.uid == messages[i].userId
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (user.uid != messages[i].userId)
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          child: ProfileAvatar(
                            avatar: post.userAvatar,
                            radius: 12,
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.all(3),
                        padding: const EdgeInsets.all(10),
                        width: (messages[i].message.length > 26) &&
                                (MediaQuery.of(context).size.width < 700)
                            ? MediaQuery.of(context).size.width / 2 + 20
                            : null,
                        decoration: BoxDecoration(
                          color: user.uid == messages[i].userId
                              ? Colors.blue[700]
                              : Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10).copyWith(
                            topRight: user.uid == messages[i].userId
                                ? const Radius.circular(-10)
                                : null,
                            topLeft: user.uid != messages[i].userId
                                ? const Radius.circular(-10)
                                : null,
                          ),
                        ),
                        child: Text(
                          messages[i].message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ],
        ),
        if (Provider.of<PostStore>(
          context,
          listen: true,
        ).addMessage)
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFieldMessage(post: post),
            ],
          )
      ],
    );
  }
}

class TextFieldMessage extends StatefulWidget {
  Post post;
  TextFieldMessage({
    super.key,
    required this.post,
  });

  @override
  State<TextFieldMessage> createState() => _TextFieldMessageState();
}

class _TextFieldMessageState extends State<TextFieldMessage> {
  var messageController = TextEditingController();

  void sendMsg(String uid) async {
    if (messageController.text.isNotEmpty) {
      String id = const Uuid().v1();
      widget.post.messages.add(
        Message(
          id: id,
          userId: uid,
          message: messageController.text.trim(),
          date: DateTime.now(),
        ),
      );
      // [id] = [
      //   DateTime.now(),
      //   messageController.text.trim(),
      //   uid,
      // ];
      // print('object');
      await PostService().updatePost(widget.post);
      // Provider.of<PostStore>(
      //   context,
      //   listen: false,
      // ).newMessage(
      //   [
      //     DateTime.now(),
      //     messageController.text.trim(),
      //     'uid 1',
      //   ],
      //   widget.post.id,
      // );
    }

    Provider.of<PostStore>(
      context,
      listen: false,
    ).addMessage = false;

    messageController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = Provider.of<UserM>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Provider.of<PostStore>(
                context,
                listen: false,
              ).addMessage = false;
            },
            icon: Icon(
              Icons.close,
              color: colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              maxLines: 1,
              autofocus: false,
              style: theme.textTheme.titleLarge,
              decoration: InputDecoration.collapsed(
                hintText: 'Message',
                hintStyle: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.5),
                ),
              ),
            ),
          ),
          // if (messageController.text.isNotEmpty)
          IconButton(
            onPressed: () => sendMsg(user.uid),
            icon: const Icon(
              Icons.send_outlined,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
