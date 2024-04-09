import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CoursesApiFetch {
  static Future<List<ParseObject>?> getAllCoursesCategory() async {
    final queryinstitutiondata =
        QueryBuilder<ParseObject>(ParseObject('Category'));

    try {
      final response = await queryinstitutiondata.query<ParseObject>();
      return response.result;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<List<ParseObject>?> getAllCourses() async {
    final queryinstitutiondata =
        QueryBuilder<ParseObject>(ParseObject('Courses'));

    try {
      final response = await queryinstitutiondata.query<ParseObject>();
      return response.result;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
