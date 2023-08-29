// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

// import 'package:flutter/foundation.dart';

class Post {
  String id;
  String title;
  String link;
  String? description;
  String communityName;
  DateTime date;
  String heure;
  String adresse;
  AdresseMap adresseMap;
  String username;
  String uid;
  String userAvatar;
  DateTime createdAt;
  List<Message> messages;
  List<Galerie> galerie;
  Post({
    required this.id,
    required this.title,
    required this.link,
    this.description,
    required this.communityName,
    required this.date,
    required this.heure,
    required this.adresse,
    required this.adresseMap,
    required this.username,
    required this.uid,
    required this.userAvatar,
    required this.createdAt,
    required this.messages,
    required this.galerie,
  });

  Post copyWith({
    String? id,
    String? title,
    String? link,
    String? description,
    String? communityName,
    DateTime? date,
    String? heure,
    String? adresse,
    AdresseMap? adresseMap,
    String? username,
    String? uid,
    String? userAvatar,
    DateTime? createdAt,
    List<Message>? messages,
    List<Galerie>? galerie,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      description: description ?? this.description,
      communityName: communityName ?? this.communityName,
      date: date ?? this.date,
      heure: heure ?? this.heure,
      adresse: adresse ?? this.adresse,
      adresseMap: adresseMap ?? this.adresseMap,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      userAvatar: userAvatar ?? this.userAvatar,
      createdAt: createdAt ?? this.createdAt,
      messages: messages ?? this.messages,
      galerie: galerie ?? this.galerie,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'link': link,
      'description': description,
      'communityName': communityName,
      'date': date.millisecondsSinceEpoch,
      'heure': heure,
      'adresse': adresse,
      'username': username,
      'adresseMap': adresseMap.toMap(),
      'uid': uid,
      'userAvatar': userAvatar,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'messages': messages.map((x) => x.toMap()).toList(),
      'galerie': galerie.map((x) => x.toMap()).toList(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      title: map['title'] as String,
      link: map['link'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      communityName: map['communityName'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      heure: map['heure'] as String,
      adresse: map['adresse'] as String,
      adresseMap: AdresseMap.fromMap(map['adresseMap'] as Map<String, dynamic>),
      username: map['username'] as String,
      uid: map['uid'] as String,
      userAvatar: map['userAvatar'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      // messages: [],
      // galerie: [],
      messages: List<Message>.from(
        (map['messages'] as List).map<Message>(
          (x) => Message.fromMap(x as Map<String, dynamic>),
        ),
      ),
      galerie: List<Galerie>.from(
        (map['galerie'] as List).map<Galerie>(
          (x) => Galerie.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, title: $title, link: $link, description: $description, communityName: $communityName, date: $date, heure: $heure, adresse: $adresse, adresseMap: $adresseMap, username: $username, uid: $uid, userAvatar: $userAvatar, createdAt: $createdAt, messages: $messages, galerie: $galerie)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.link == link &&
        other.description == description &&
        other.communityName == communityName &&
        other.date == date &&
        other.heure == heure &&
        other.adresse == adresse &&
        other.adresseMap == adresseMap &&
        other.username == username &&
        other.uid == uid &&
        other.userAvatar == userAvatar &&
        other.createdAt == createdAt &&
        listEquals(other.messages, messages) &&
        listEquals(other.galerie, galerie);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        link.hashCode ^
        description.hashCode ^
        communityName.hashCode ^
        date.hashCode ^
        heure.hashCode ^
        adresse.hashCode ^
        adresseMap.hashCode ^
        username.hashCode ^
        uid.hashCode ^
        userAvatar.hashCode ^
        createdAt.hashCode ^
        messages.hashCode ^
        galerie.hashCode;
  }
}

class Message {
  String id;
  String userId;
  String message;
  DateTime date;
  Message({
    required this.id,
    required this.userId,
    required this.message,
    required this.date,
  });

  Message copyWith({
    String? id,
    String? userId,
    String? message,
    DateTime? date,
  }) {
    return Message(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'message': message,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      userId: map['userId'] as String,
      message: map['message'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, userId: $userId, message: $message, date: $date)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.message == message &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ message.hashCode ^ date.hashCode;
  }
}

class Galerie {
  String id;
  String userId;
  String link;
  DateTime date;
  Galerie({
    required this.id,
    required this.userId,
    required this.link,
    required this.date,
  });

  Galerie copyWith({
    String? id,
    String? userId,
    String? link,
    DateTime? date,
  }) {
    return Galerie(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      link: link ?? this.link,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'link': link,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Galerie.fromMap(Map<String, dynamic> map) {
    return Galerie(
      id: map['id'] as String,
      userId: map['userId'] as String,
      link: map['link'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Galerie.fromJson(String source) =>
      Galerie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Galerie(id: $id, userId: $userId, link: $link, date: $date)';
  }

  @override
  bool operator ==(covariant Galerie other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.link == link &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ link.hashCode ^ date.hashCode;
  }
}

class AdresseMap {
  double latitude;
  double longitude;
  AdresseMap({
    required this.latitude,
    required this.longitude,
  });

  AdresseMap copyWith({
    double? latitude,
    double? longitude,
  }) {
    return AdresseMap(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AdresseMap.fromMap(Map<String, dynamic> map) {
    return AdresseMap(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdresseMap.fromJson(String source) =>
      AdresseMap.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AdresseMap(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant AdresseMap other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
