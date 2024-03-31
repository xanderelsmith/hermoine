import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserDetails {
  UserDetails({
    required this.user,
    required this.institutionDetails,
  });
  final ParseUser user;
  final ParseObject? institutionDetails;
    UserDetails copyWith(
      {required final ParseUser user, final ParseObject? institutionDetails}) {
    return UserDetails(
      institutionDetails: institutionDetails,
      user: user,
    );
  }
}
