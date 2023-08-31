import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String email;
  final String name;
  final String profilePic;
  final String bannerPic;
  final String uid;
  final String bio;
  final bool istwitterblue;
  final List<String> followers;
  final List<String> following;
  const UserModel({
    required this.email,
    required this.name,
    required this.profilePic,
    required this.bannerPic,
    required this.uid,
    required this.bio,
    required this.istwitterblue,
    required this.followers,
    required this.following,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? profilePic,
    String? bannerPic,
    String? uid,
    String? bio,
    bool? istwitterblue,
    List<String>? followers,
    List<String>? following,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      bannerPic: bannerPic ?? this.bannerPic,
      uid: uid ?? this.uid,
      bio: bio ?? this.bio,
      istwitterblue: istwitterblue ?? this.istwitterblue,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'profilePic': profilePic});
    result.addAll({'bannerPic': bannerPic});
    result.addAll({'bio': bio});
    result.addAll({'istwitterblue': istwitterblue});
    result.addAll({'followers': followers});
    result.addAll({'following': following});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      bannerPic: map['bannerPic'] ?? '',
      uid: map['\$id'] ?? '',
      bio: map['bio'] ?? '',
      istwitterblue: map['istwitterblue'] ?? false,
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.name == name &&
        other.profilePic == profilePic &&
        other.bannerPic == bannerPic &&
        other.uid == uid &&
        other.bio == bio &&
        other.istwitterblue == istwitterblue &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        profilePic.hashCode ^
        bannerPic.hashCode ^
        uid.hashCode ^
        bio.hashCode ^
        istwitterblue.hashCode ^
        followers.hashCode ^
        following.hashCode;
  }
}
