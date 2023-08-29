// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

import 'post_model.dart';

class PostStore with ChangeNotifier {
  Map<String, Set<Post>> categories;
  // final _categories = <String, Set<Post>>{
  //   'A venir': {},
  //   'Passées': _paste,
  // };

  // static final _future = <Post>{
  //   Post(
  //     id: 'id 1',
  //     title: 'title 1',
  //     link: 'link 1',
  //     description: 'Cucumber Mask Facial has shipped.\n\n'
  //         'Keep an eye out for a package to arrive between this Thursday and next Tuesday. If for any reason you don\'t receive your package before the end of next week, please reach out to us for details on your shipment.\n\n'
  //         'As always, thank you for shopping with us and we hope you love our specially formulated Cucumber Mask!',
  //     communityName: 'communityName 1',
  //     date: DateTime.utc(2023, 9, 4),
  //     heure: '12:30',
  //     adresse: 'adresse 1',
  //     adresseMap: AdresseMap(latitude: 14.54542, longitude: -17.54542),
  //     username: 'username 1',
  //     uid: 'uid 1',
  //     userAvatar: 'assets/new/reply/avatars/avatar_express.png',
  //     createdAt: DateTime.now(),
  //     messages: {
  //       'id 1': [DateTime.utc(2023, 8, 25), 'Hello', 'uid 1'],
  //       'id 2': [DateTime.utc(2023, 8, 25), 'Yup 🧐', 'uid 2'],
  //     },
  //     galerie: {},
  //   ),
  // };

  // static final _paste = <Post>{
  //   Post(
  //     id: 'id 2',
  //     title: 'title 2',
  //     link: 'link 2',
  //     description: 'Here are some great shots from my trip...',
  //     communityName: 'communityName 2',
  //     date: DateTime.utc(2023, 8, 25),
  //     heure: '15:45',
  //     adresse: 'adresse 2',
  //     adresseMap: AdresseMap(latitude: 14.54542, longitude: -17.54542),
  //     username: 'username 2',
  //     uid: 'uid 2',
  //     userAvatar: 'assets/new/reply/avatars/avatar_express.png',
  //     createdAt: DateTime.utc(2023, 8, 23),
  //     messages: {},
  //     galerie: {},
  //   ),
  //   Post(
  //     id: 'id 3',
  //     title: 'title 3',
  //     link: 'link 3',
  //     description:
  //         'Thought we might be able to go over some details about our upcoming vacation.\n\n'
  //         'I\'ve been doing a bit of research and have come across a few paces in Northern Brazil that I think we should check out. '
  //         'One, the north has some of the most predictable wind on the planet. ',
  //     communityName: 'communityName 3',
  //     date: DateTime.utc(2023, 8, 24),
  //     heure: '10:15',
  //     adresse: 'adresse 3',
  //     adresseMap: AdresseMap(latitude: 14.54542, longitude: -17.54542),
  //     username: 'username 3',
  //     uid: 'uid 3',
  //     userAvatar: 'assets/new/reply/avatars/avatar_express.png',
  //     createdAt: DateTime.utc(2023, 8, 20),
  //     messages: {},
  //     galerie: {},
  //   ),
  // };

  int _currentlySelectedPageInPost = -1;
  int _currentlySelectedPostId = -1;
  String _currentlySelectedInFuture = 'A venir';
  bool _onCompose = false;
  bool _addMessage = false;
  bool _bottomDrawerVisible = false;
  ThemeMode _currentTheme = ThemeMode.system;
  PostStore({
    required this.categories,
  });
  // SlowMotionSpeedSetting _currentSlowMotionSpeed =
  //     SlowMotionSpeedSetting.normal;

  Map<String, Set<Post>> get posts =>
      Map<String, Set<Post>>.unmodifiable(categories);

  bool get bottomDrawerVisible => _bottomDrawerVisible;
  int get currentlySelectedPageInPost => _currentlySelectedPageInPost;
  int get currentlySelectedEmailId => _currentlySelectedPostId;
  String get currentlySelectedInFuture => _currentlySelectedInFuture;
  bool get onMessageView => _currentlySelectedPageInPost == 0;
  bool get onGalerieView => _currentlySelectedPageInPost == 2;
  bool get onPostView => _currentlySelectedPostId > -1;
  bool get onCompose => _onCompose;
  bool get addMessage => _addMessage;
  ThemeMode get themeMode => _currentTheme;
  // SlowMotionSpeedSetting get slowMotionSpeed => _currentSlowMotionSpeed;

  bool isPostStarred(Post post) {
    // return _categories['A venir']!.contains(post);
    return false;
  }

  set bottomDrawerVisible(bool value) {
    _bottomDrawerVisible = value;
    notifyListeners();
  }

  set currentlySelectedPageInPost(int value) {
    _currentlySelectedPageInPost = value;
    notifyListeners();
  }

  set currentlySelectedPostId(int value) {
    _currentlySelectedPostId = value;
    notifyListeners();
  }

  set currentlySelectedInFuture(String inbox) {
    _currentlySelectedInFuture = inbox;
    notifyListeners();
  }

  set themeMode(ThemeMode theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  // set slowMotionSpeed(SlowMotionSpeedSetting speed) {
  //   _currentSlowMotionSpeed = speed;
  //   timeDilation = slowMotionSpeed.value;
  // }

  set addMessage(bool value) {
    _addMessage = value;
    notifyListeners();
  }

  set onCompose(bool value) {
    _onCompose = value;
    notifyListeners();
  }

  set addPost(Post post) {
    // _future.add(post);
    categories['A venir']!.add(post);
    notifyListeners();
  }

  newMessage(List message, String idPost) {
    // String id = const Uuid().v1();
    // for (var e in _future) {
    //   if (e.id == idPost) {
    //     e.messages[id] = message;
    //     notifyListeners();
    //     return;
    //   }
    // }
    // for (var e in _paste) {
    //   if (e.id == idPost) {
    //     e.messages[id] = message;
    //     notifyListeners();
    //     return;
    //   }
    // }
  }
}
