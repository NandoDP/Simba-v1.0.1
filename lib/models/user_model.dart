import 'package:flutter/foundation.dart';

class UserM {
  final String name;
  final String profilePic;
  // final String banner;
  final String uid;
  final bool isAuthenticated;
  final List<String> communities;
  UserM({
    required this.name,
    required this.profilePic,
    // required this.banner,
    required this.uid,
    required this.isAuthenticated,
    required this.communities,
  });

  UserM copyWith({
    String? name,
    String? profilePic,
    // String? banner,
    String? uid,
    bool? isAuthenticated,
    List<String>? communities,
  }) {
    return UserM(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      // banner: banner ?? this.banner,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      communities: communities ?? this.communities,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      // 'banner': banner,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
      'communities': communities,
    };
  }

  factory UserM.fromMap(Map<String, dynamic> map) {
    return UserM(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      // banner: map['banner'] ?? '',
      uid: map['uid'] ?? '',
      isAuthenticated: map['isAuthenticated'] ?? false,
      communities: List<String>.from(map['communities']),
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, uid: $uid, isAuthenticated: $isAuthenticated, communities: $communities)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserM &&
        other.name == name &&
        other.profilePic == profilePic &&
        // other.banner == banner &&
        other.uid == uid &&
        other.isAuthenticated == isAuthenticated &&
        listEquals(other.communities, communities);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePic.hashCode ^
        // banner.hashCode ^
        uid.hashCode ^
        isAuthenticated.hashCode ^
        communities.hashCode;
  }
}
