import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserDetails {
  UserDetails({
    required this.user,
    required this.emailaddress,
  });
  final ParseUser user;
  final String? emailaddress;
  UserDetails copyWith(
      {required final ParseUser user, final String? emailaddress}) {
    return UserDetails(
      emailaddress: emailaddress,
      user: user,
    );
  }
}
