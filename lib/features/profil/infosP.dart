import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/features/core/profile_avatar.dart';
import 'package:simba/features/core/utils.dart';

import '../../models/user_model.dart';

class InfosP extends StatefulWidget {
  const InfosP({super.key});

  @override
  State<StatefulWidget> createState() => _InfosPState();
}

class _InfosPState extends State<InfosP> {
  final keys = GlobalKey<FormState>();
  File? profilFile;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectProfilImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profilFile = File(res.files.first.path!);
      });
    }
  }

  void save() {
    // ref.read(userProfileControllerProvider.notifier).editProfil(
    //       profileFile: profilFile,
    //       context: context,
    //       name: nameController.text.trim(),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    nameController =
        TextEditingController(text: Provider.of<UserM>(context).name);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.headlineSmall!.color,
          ),
        ),
        title: Text(
          'Données personnelles',
          style: TextStyle(
            color: Theme.of(context).textTheme.headlineSmall!.color,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    if (profilFile != null)
                      CircleAvatar(
                        backgroundImage: FileImage(profilFile!),
                        radius: 50,
                      ),
                    if (profilFile == null)
                      ProfileAvatar(
                        avatar: Provider.of<UserM>(context).profilePic,
                        radius: 50,
                      ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        onPressed: () => selectProfilImage(),
                        icon: const Icon(
                          Icons.mode_edit_outline_outlined,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Expanded(
                    child: TextField(
                      controller: nameController,
                      maxLines: 1,
                      autofocus: true,
                      style: Theme.of(context).textTheme.titleLarge,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Nom complet...',
                        hintStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => save(),
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
                          'Mettre à jour',
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
    );
  }
}
