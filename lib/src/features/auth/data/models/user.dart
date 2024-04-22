import 'package:firebase_auth/firebase_auth.dart';

class UserDetails {
  final String id; // Unique identifier for the user
  final String username;
  final String email;
  String? name; // Optional first name
  String? gender; // Optional last name
  String? age; // Optional last name
  String? bio; // Optional last name
  String? profileImageUrl; // Optional profile image URL
  bool? isTutor;
  UserDetails({
    required this.id,
    required this.username,
    required this.email,
    this.name,
    this.gender,
    this.isTutor,
    this.age,
    this.bio,
    this.profileImageUrl,
  });
  // Factory constructor for creating a User object from a Map (e.g., JSON data)
  factory UserDetails.fromFirebaseUser(User user) => UserDetails(
        id: user.uid,
        isTutor: true,
        username: user.displayName ?? "no name",
        email: user.email ?? "no email",
        name: user.displayName,
        age: "no age",
        gender: "no gender",
        bio: "no bio",
        profileImageUrl: " ",
      );
  // Factory constructor for creating a User object from a Map (e.g., JSON data)
  factory UserDetails.fromFirebaseData(Map<String, dynamic> userData) =>
      UserDetails(
        isTutor: userData['isTutor'] ?? true,
        id: userData['id'] ?? "",
        username: userData['username'] ?? "no name",
        email: userData['email'] ?? "no email",
        name: userData['name'] ?? "no name",
        age: userData['age'] ?? "no age",
        gender: userData['gender'] ?? "no gender",
        bio: userData['bio'] ?? "no bio",
        profileImageUrl: userData['profileImageUrl'] ?? " ",
      );

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json['id'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        name: json['name'] as String?,
        gender: json['gender'] as String?,
        age: json['age'] as String?,
        bio: json['gender'] as String?,
        profileImageUrl: json['profileImageUrl'] as String?,
      );
  // Method to convert the User object to a Map (e.g., for serialization)
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'name': name,
        'age': age,
        'gender': gender,
        'bio': bio,
        'profileImageUrl': profileImageUrl,
      };

  // Optional methods for equality comparison and hashcode generation
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetails &&
        other.id == id &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ email.hashCode;

  // New copyWith method
  UserDetails copyWith({
    String? id,
    String? username,
    String? email,
    String? name,
    String? gender,
    String? age,
    String? bio,
    String? profileImageUrl,
    bool? isTutor,
  }) {
    return UserDetails(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isTutor: isTutor ?? this.isTutor,
    );
  }
}
