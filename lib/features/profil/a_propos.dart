// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

class APropos extends StatelessWidget {
  APropos({super.key});

  Map<String, HighlightedWord> words = {
    "Simba": HighlightedWord(
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w600,
        fontSize: 17,
        letterSpacing: 1,
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
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
          'A propos',
          style: TextStyle(
            color: Theme.of(context).textTheme.headlineSmall!.color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 15, 48, 74),
                      Colors.blue,
                    ],
                  ).createShader(bounds),
                  child: const Text(
                    'Simba',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  'v1.0.1',
                  style: TextStyle(
                    // color: currentTheme.disabledColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextHighlight(
              text:
                  "Bienvenue sur Simba, l'application qui vous connecte avec des"
                  " événements sociaux passionnants en fonction de vos centres d'intérêt uniques.", // You need to pass the string you want the highlights
              words: words,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            TextHighlight(
              text: "Simba réinvente la manière dont vous découvrez"
                  " et participez à des événements, en mettant en avant"
                  " vos passions personnelles.", // You need to pass the string you want the highlights
              words: words,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            TextHighlight(
              text: "Une utilisation fluide, avec les meilleurs"
                  " fonctionnalités pour faciliter la planification et la participation.", // You need to pass the string you want the highlights
              words: words,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            TextHighlight(
              text: "Qu'il s'agisse d'activitées religieuses,"
                  " de rencontres sportives ou de séances de networking,"
                  " Simba rassemble des événements variés pour chaque passion.", // You need to pass the string you want the highlights
              words: words,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            TextHighlight(
              text: "Organisateurs, faites entendre votre voix!"
                  " Créez et partagez facilement vos événements spéciaux"
                  " avec une communauté de passionnés.", // You need to pass the string you want the highlights
              words: words,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

Absolument, voici une présentation concise de 10 phrases pour votre application 
Simba, un réseau social dédié à l'annonce d'événements sociaux liés à divers centres d'intérêt :

1. Bienvenue sur Simba, l'application qui vous connecte avec des événements 
sociaux passionnants en fonction de vos centres d'intérêt uniques.
2. Simba réinvente la manière dont vous découvrez et participez à des événements, 
en mettant en avant vos passions personnelles.
3. Explorez un monde d'opportunités sociales en rejoignant Simba, où vous pourrez 
trouver des événements alignés sur vos hobbies et passions.
4. Qu'il s'agisse d'ateliers artistiques, de rencontres sportives ou de séances 
de networking, Simba rassemble des événements variés pour chaque passion.
5. Ne manquez plus jamais un événement pertinent ! Simba vous envoie des 
recommandations personnalisées en fonction de vos goûts et préférences.
6. Organisateurs, faites entendre votre voix ! Créez et partagez facilement 
vos événements spéciaux avec une communauté de passionnés.
7. L'expérience sociale de Simba ne se limite pas à l'événement lui-même. 
Connectez-vous avec d'autres participants partageant vos intérêts et faites de nouvelles rencontres.
8. Grâce à la convivialité de Simba, vous pourrez étendre votre cercle social 
en participant à des événements qui stimulent votre curiosité.
9. Trouvez l'inspiration et élargissez vos horizons en explorant des événements 
que vous n'auriez peut-être pas découverts autrement, tout cela grâce à Simba.
10. Plongez dans une expérience sociale dynamique et vibrante avec Simba, 
l'application qui fait de chaque événement une opportunité de créer des souvenirs mémorables.

N'hésitez pas à personnaliser ces phrases selon les valeurs uniques de votre 
application Simba et les avantages qu'elle offre aux utilisateurs.

*/


// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   bool _hasCallSupport = false;
//   Future<void>? _launched;
//   String _phone = '';

//   @override
//   void initState() {
//     super.initState();
//     // Check for phone call support.
//     canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
//       setState(() {
//         _hasCallSupport = result;
//       });
//     });
//   }

//   Future<void> _launchInBrowser(Uri url) async {
//     if (!await launchUrl(
//       url,
//       mode: LaunchMode.externalApplication,
//     )) {
//       throw Exception('Could not launch $url');
//     }
//   }

//   Future<void> _launchInWebViewOrVC(Uri url) async {
//     if (!await launchUrl(
//       url,
//       mode: LaunchMode.inAppWebView,
//       webViewConfiguration: const WebViewConfiguration(
//           headers: <String, String>{'my_header_key': 'my_header_value'}),
//     )) {
//       throw Exception('Could not launch $url');
//     }
//   }

//   Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
//     if (!await launchUrl(
//       url,
//       mode: LaunchMode.inAppWebView,
//       webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
//     )) {
//       throw Exception('Could not launch $url');
//     }
//   }

//   Future<void> _launchInWebViewWithoutDomStorage(Uri url) async {
//     if (!await launchUrl(
//       url,
//       mode: LaunchMode.inAppWebView,
//       webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
//     )) {
//       throw Exception('Could not launch $url');
//     }
//   }

//   Future<void> _launchUniversalLinkIos(Uri url) async {
//     final bool nativeAppLaunchSucceeded = await launchUrl(
//       url,
//       mode: LaunchMode.externalNonBrowserApplication,
//     );
//     if (!nativeAppLaunchSucceeded) {
//       await launchUrl(
//         url,
//         mode: LaunchMode.inAppWebView,
//       );
//     }
//   }

//   Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
//     if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else {
//       return const Text('');
//     }
//   }

//   Future<void> _makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launchUrl(launchUri);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // onPressed calls using this URL are not gated on a 'canLaunch' check
//     // because the assumption is that every device can launch a web URL.
//     final Uri toLaunch =
//         Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('title'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                     onChanged: (String text) => _phone = text,
//                     decoration: const InputDecoration(
//                         hintText: 'Input the phone number to launch')),
//               ),
//               ElevatedButton(
//                 onPressed: _hasCallSupport
//                     ? () => setState(() {
//                           _launched = _makePhoneCall(_phone);
//                         })
//                     : null,
//                 child: _hasCallSupport
//                     ? const Text('Make phone call')
//                     : const Text('Calling not supported'),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(toLaunch.toString()),
//               ),
//               ElevatedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInBrowser(toLaunch);
//                 }),
//                 child: const Text('Launch in browser'),
//               ),
//               const Padding(padding: EdgeInsets.all(16.0)),
//               ElevatedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInWebViewOrVC(toLaunch);
//                 }),
//                 child: const Text('Launch in app'),
//               ),
//               ElevatedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInWebViewWithoutJavaScript(toLaunch);
//                 }),
//                 child: const Text('Launch in app (JavaScript OFF)'),
//               ),
//               ElevatedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInWebViewWithoutDomStorage(toLaunch);
//                 }),
//                 child: const Text('Launch in app (DOM storage OFF)'),
//               ),
//               const Padding(padding: EdgeInsets.all(16.0)),
//               ElevatedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchUniversalLinkIos(toLaunch);
//                 }),
//                 child: const Text(
//                     'Launch a universal link in a native app, fallback to Safari.(Youtube)'),
//               ),
//               const Padding(padding: EdgeInsets.all(16.0)),
//               ElevatedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInWebViewOrVC(toLaunch);
//                   Timer(const Duration(seconds: 5), () {
//                     closeInAppWebView();
//                   });
//                 }),
//                 child: const Text('Launch in app + close after 5 seconds'),
//               ),
//               const Padding(padding: EdgeInsets.all(16.0)),
//               Link(
//                 uri: Uri.parse(
//                     'https://pub.dev/documentation/url_launcher/latest/link/link-library.html'),
//                 target: LinkTarget.blank,
//                 builder: (BuildContext ctx, FollowLink? openLink) {
//                   return TextButton.icon(
//                     onPressed: openLink,
//                     label: const Text('Link Widget documentation'),
//                     icon: const Icon(Icons.read_more),
//                   );
//                 },
//               ),
//               const Padding(padding: EdgeInsets.all(16.0)),
//               FutureBuilder<void>(future: _launched, builder: _launchStatus),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


/*

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Présentation de Mon Application Mobile</title>
<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f0f0f0;
    text-align: center;
  }
  header {
    background-color: #3498db;
    color: white;
    padding: 1rem;
  }
  .container {
    max-width: 800px;
    margin: 2rem auto;
    padding: 2rem;
    background-color: white;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
  }
  h1 {
    color: #3498db;
  }
  p {
    line-height: 1.6;
  }
</style>
</head>
<body>
  <header>
    <h1>Présentation de Mon Application Mobile</h1>
  </header>
  <div class="container">
    <h2>Bienvenue sur Mon Application Mobile</h2>
    <p>Bienvenue sur la page de présentation de Mon Application Mobile. Cette application révolutionnaire vous permet de...</p>
    
    <h2>Fonctionnalités Principales</h2>
    <ul>
      <li>Fonctionnalité 1: Lorem ipsum dolor sit amet, consectetur adipiscing elit.</li>
      <li>Fonctionnalité 2: Suspendisse vel felis quis tortor varius feugiat.</li>
      <li>Fonctionnalité 3: Proin vel ligula vel erat congue sagittis.</li>
    </ul>

    <h2>Captures d'Écran</h2>
    <img src="screenshot1.jpg" alt="Capture d'écran 1">
    <img src="screenshot2.jpg" alt="Capture d'écran 2">
    <img src="screenshot3.jpg" alt="Capture d'écran 3">

    <h2>Téléchargement</h2>
    <p>Pour profiter de toutes ces fonctionnalités incroyables, téléchargez l'application dès aujourd'hui!</p>
    <a href="lien_de_telechargement" target="_blank"><button>Télécharger</button></a>
  </div>
</body>
</html>


*/