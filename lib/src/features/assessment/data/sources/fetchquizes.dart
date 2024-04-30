import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class QuizApiFetch {
  static Future<List<ParseObject>?> getAllquizes() async {
    final queryinstitutiondata = QueryBuilder<ParseObject>(ParseObject('Quiz'))
      ..orderByDescending('updatedAt')
      ..includeObject(['coursename']);

    try {
      final response = await queryinstitutiondata.query<ParseObject>();
      return response.result;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
