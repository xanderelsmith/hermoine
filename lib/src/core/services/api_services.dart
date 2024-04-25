import 'dart:developer';
import 'package:hermione/src/features/auth/data/models/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

///get userdetails and his insitutiondetails

///class created for auth puposes by xander

class ApiService {
  ApiService();

  static Future<UserDetails> getUserDetails() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    log(currentUser!.toJson().toString());
    String institutionId = currentUser['institution'] != null
        ? currentUser['institution']['objectId']
        : 'doesnotexist';
    log(institutionId);
    ParseResponse? institutionDetails;
    if (institutionId != 'doesnotexist') {
      final queryUserInstitutionData =
          QueryBuilder<ParseObject>(ParseObject('Institutions'))
            ..whereEqualTo('objectId', institutionId);
      institutionDetails = await queryUserInstitutionData.query();

      log(institutionDetails.result.toString());
    }

    return UserDetails.fromParseUSer(currentUser);
  }

  static Future<ParseUser> getUser() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser!;
  }

  static clearUser() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null && currentUser['firstname'] != null) {
      await currentUser.logout();
    }
  }

  ///checks if user has logged in
  static Future<bool> hasUserLoggedIn() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    return true;
    // final ParseResponse? parseResponse =
    //     await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    // if (parseResponse?.success == null || !parseResponse!.success) {
    //   return false;
    // } else {
    //   return true;
    // }
  }

  static Future<ParseResponse> doEmailVerification(
      {required String useremail, required String username}) async {
    final user = ParseUser(username.trim(), null, useremail.trim());

    ParseResponse response = await user.verificationEmailRequest();
    log(response.toString());
    return response;
  }

// code to push institutions(already done, do not utilize except in dire situations)
  static Future<ParseResponse> doUserLogOut(
      {required String useremail, required String username}) async {
    final currentUser = ParseUser(
      username,
      null,
      useremail,
    );

    ParseResponse response = await currentUser.logout();
    await currentUser.logout();
    return response;
  }

  static Future<ParseResponse> dopasswordReset({
    required String useremail,
  }) async {
    final user = ParseUser(null, null, useremail.trim());

    ParseResponse response = await user.requestPasswordReset();
    return response;
  }

  static Future<ParseResponse> doUsersignUp({
    required String username,
    required String password,
    required String emailadress,
  }) async {
    final user =
        ParseUser(username.trim(), password.trim(), emailadress.trim());

    ParseResponse response = await user.signUp();

    return response;
  }

  static Future<ParseResponse> doUserLogin({
    required String username,
    required String password,
  }) async {
    final user = ParseUser(username.trim(), password.trim(), null);
    ParseResponse response = await user.login();
    return response;
  }
}
