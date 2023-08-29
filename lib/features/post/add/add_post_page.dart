// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/models/post_model.dart';
import 'package:simba/models/post_store.dart';
import 'package:uuid/uuid.dart';

import 'add_post_adresse.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  // void save()async{

  // }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TitleRow(
                    titleController: titleController,
                    dateController: dateController,
                    timeController: timeController,
                    descriptionController: descriptionController,
                  ),
                  const _SectionDivider(),
                  _DateAndTimeRow(
                    dateController: dateController,
                    timeController: timeController,
                  ),
                  const _SectionDivider(),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: descriptionController,
                      minLines: 6,
                      maxLines: 15,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Description...',
                      ),
                      autofocus: false,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (
                              BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                            ) {
                              return AddPostAdresse(
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                                date: dateController.text.trim(),
                                time: timeController.text.trim(),
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: Colors.blue[900],
                      ),
                      child: const Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ajouter',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Icon(Icons.arrow_forward)],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleRow extends StatefulWidget {
  TextEditingController titleController;
  TextEditingController dateController;
  TextEditingController timeController;
  TextEditingController descriptionController;
  _TitleRow({
    Key? key,
    required this.titleController,
    required this.dateController,
    required this.timeController,
    required this.descriptionController,
  }) : super(key: key);
  @override
  _TitleRowState createState() => _TitleRowState();
}

class _TitleRowState extends State<_TitleRow> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    var titleController = widget.titleController;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: TextField(
              controller: titleController,
              maxLines: 1,
              autofocus: false,
              style: theme.textTheme.titleLarge,
              decoration: InputDecoration.collapsed(
                hintText: 'Titre',
                hintStyle: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.5),
                ),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   icon: IconButton(
          //     icon: ImageIcon(
          //       const AssetImage(
          //         'assets/new/reply/icons/twotone_send.png',
          //       ),
          //       color: colorScheme.onSurface,
          //     ),
          //     onPressed: () {
          //       // Provider.of<PostStore>(
          //       //   context,
          //       //   listen: false,
          //       // ).addPost = Post(
          //       //   id: 'id',
          //       //   title: titleController.text.trim(),
          //       //   description: widget.descriptionController.text.trim(),
          //       //   link: 'assets/new/reply/avatars/avatar_express.png',
          //       //   communityName: 'Sport',
          //       //   date: DateTime(
          //       //     int.parse(widget.dateController.text.split('/')[2]),
          //       //     int.parse(widget.dateController.text.split('/')[1]),
          //       //     int.parse(widget.dateController.text.split('/')[0]),
          //       //   ),
          //       //   heure: widget.timeController.text.trim(),
          //       //   adresse: 'Terrain Arrondissement',
          //       //   adresseMap: AdresseMap(latitude: 0, longitude: 0),
          //       //   username: 'Nando',
          //       //   uid: 'uid',
          //       //   userAvatar: 'assets/new/reply/avatars/avatar_express.png',
          //       //   createdAt: DateTime.now(),
          //       //   messages: {},
          //       //   galerie: {},
          //       // );
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _DateAndTimeRow extends StatefulWidget {
  TextEditingController dateController;
  TextEditingController timeController;
  _DateAndTimeRow({
    Key? key,
    required this.dateController,
    required this.timeController,
  }) : super(key: key);
  @override
  _DateAndTimeRowState createState() => _DateAndTimeRowState();
}

class _DateAndTimeRowState extends State<_DateAndTimeRow> {
  void _selectedDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        // _datetime = value!;
        widget.dateController.text =
            "${value!.day}/${value.month}/${value.year}";
      });
    });
  }

  void _selectedTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        widget.timeController.text = value!.format(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.dateController,
              readOnly: true,
              onTap: _selectedDate,
              validator: (value) => value!.isEmpty ? "Choisir une date" : null,
              style: const TextStyle(fontSize: 17),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Date",
                hintStyle: const TextStyle(fontSize: 17),
                suffixIcon: const Icon(Icons.calendar_today_outlined),
                filled: true,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: widget.timeController,
              readOnly: true,
              onTap: _selectedTime,
              validator: (value) => value!.isEmpty ? "Choisir l'heure" : null,
              style: const TextStyle(fontSize: 17),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Heure",
                hintStyle: const TextStyle(fontSize: 17),
                suffixIcon: const Icon(Icons.access_time),
                filled: true,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.1,
      indent: 10,
      endIndent: 10,
    );
  }
}
