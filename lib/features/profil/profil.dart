import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/features/core/profile_avatar.dart';
import 'package:simba/features/core/utils.dart';
import 'package:simba/models/post_store.dart';
import 'package:simba/models/route_provider.dart';
import 'package:simba/models/user_model.dart';
import 'package:simba/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import 'a_propos.dart';
import 'infosP.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Future<void>? _launched;
  void logOut(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Deconnexion'),
        content: const Text('Voulez-vous deconnecter'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // ref.read(authControllerProvider.notifier).logOut();
            },
            child: const Text('Oui'),
          ),
        ],
      ),
    );
  }

  more(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Wrap(
              spacing: 35,
              children: <Widget>[
                ListTile(
                  onTap: () {},
                  title: const Text(
                    'Supprimer mon compte',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                  leading: const Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ),
                ListTile(
                  onTap: () => logOut(context),
                  title: const Text(
                    'Déconnexion',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.blue,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    // color: currentTheme.disabledColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  shareTo(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Wrap(
              spacing: 35,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: 'https://bento/simba',
                    style: const TextStyle(fontSize: 17),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          FlutterClipboard.copy('https://bento/simba').then(
                            (value) => showSnackBar(
                                context, 'text copié dans le papier presse'),
                          );
                        },
                        icon: const Icon(
                          Icons.copy_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Share.share(
                        "Simba est l'application qui vous connecte avec des événements sociaux passionnants en fonction de vos centres d'intérêts uniques.\n\nTélécharger Simba dès maintenant https://bento.me/simba");
                  },
                  title: Text(
                    'Partager sur',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  leading: const Icon(
                    Icons.offline_share,
                    color: Colors.blue,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void toggleTheme() {
    // ref.read(themeNotifierProvider.notifier).toggleTheme();
    ThemeMode theme = Provider.of<PostStore>(context, listen: false).themeMode;
    Provider.of<PostStore>(context, listen: false).themeMode = theme;
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(
      scheme: 'https',
      host: 'mail.google.com',
      path: 'mail/u/0/#inbox?compose=new',
    );
    // Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Provider.of<RouterProvider>(
              context,
              listen: false,
            ).routePath = const SimbaHomePath();
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).textTheme.headlineSmall!.color,
          ),
        ),
        title: Text(
          'Mon compte',
          style: TextStyle(
            color: Theme.of(context).textTheme.headlineSmall!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => more(context),
            icon: Icon(
              Icons.more_horiz_rounded,
              color: Theme.of(context).textTheme.headlineSmall!.color,
              size: 25,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              ProfileAvatar(
                avatar: Provider.of<UserM>(context).profilePic,
                radius: 50,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Provider.of<UserM>(context).name,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.blue,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '1',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                      ),
                      const Text(
                        "events organisés",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "0",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                      ),
                      const Text(
                        "event partagé",
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        onTap: () => newRoute(context, const InfosP()),
                        // {
                        //   Navigator.of(context)
                        //       .push(_createRoute(const InfosP()));
                        // },
                        leading: const Icon(
                          Icons.person_4_outlined,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Information personnelles',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        leading: const Icon(
                          Icons.mode_night_outlined,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Mode sombre',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Switch.adaptive(
                          value: Provider.of<PostStore>(context, listen: true)
                                  .themeMode ==
                              ThemeMode.dark,
                          onChanged: (value) => toggleTheme(),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        onTap: () => shareTo(context),
                        leading: const Icon(
                          Icons.share_outlined,
                          color: Colors.blue,
                        ),
                        title: Text(
                          "Partager l'application",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        onTap: () => setState(() {
                          _launched = _launchInWebViewOrVC(toLaunch);
                        }),
                        leading: const Icon(
                          Icons.help_outline_outlined,
                          color: Colors.blue,
                        ),
                        title: Text(
                          "Besoin d'aide",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        onTap: () => newRoute(context, APropos()),
                        leading: const Icon(
                          Icons.info_outline_rounded,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'A propos',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<void>(future: _launched, builder: _launchStatus),
            ],
          ),
        ),
      ),
    );
  }
}

newRoute(BuildContext context, Widget child) {
  return showDialog(
    useSafeArea: true,
    context: context,
    builder: (context) => child,
  );
}
// newRoute(BuildContext context, Widget child, ThemeData currentTheme) {
//   return showModalBottomSheet(
//       backgroundColor: currentTheme.scaffoldBackgroundColor,
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       builder: (BuildContext context) {
//         return SafeArea(child: child);
//       });
// }

// Route _createRoute(Widget child) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => child,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
