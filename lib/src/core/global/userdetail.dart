import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserDetails {
  UserDetails({
    required this.user,
  });
  final ParseUser user;
  UserDetails copyWith({required final ParseUser user}) {
    return UserDetails(
      user: user,
    );
  }
}
