import 'package:firebase_auth/firebase_auth.dart';

class UserDetails {
  final String id; // Unique identifier for the user
  final String username;
  final String email;
  String? firstName; // Optional first name
  String? lastName; // Optional last name
  String? profileImageUrl; // Optional profile image URL

  UserDetails({
    required this.id,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.profileImageUrl,
  });
  // Factory constructor for creating a User object from a Map (e.g., JSON data)
  factory UserDetails.fromFirebaseUser(User user) => UserDetails(
        id: user.uid,
        username: user.displayName ?? "no name",
        email: user.email ?? "no email",
        firstName: "no firstName",
        lastName: "no lastName",
        profileImageUrl: user.displayName ?? " ",
      );

  // Factory constructor for creating a User object from a Map (e.g., JSON data)
  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json['id'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        profileImageUrl: json['profileImageUrl'] as String?,
      );

  // Method to convert the User object to a Map (e.g., for serialization)
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
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
}
