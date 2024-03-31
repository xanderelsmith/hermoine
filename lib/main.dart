import 'package:flutter/material.dart';
import 'package:hermione/src/core/keys/backendkeys.dart';
import 'package:hermione/src/core/routes/routes.dart';
import 'package:hermione/src/core/services/api_services.dart';
import 'package:hermione/src/core/theme/theme.dart';
import 'package:hermione/src/features/auth/presentation/pages/login.dart';
import 'package:hermione/src/features/home/presentation/pages/homepage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'src/features/auth/presentation/pages/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse()
      .initialize(
          appName: 'Spark',
          appVersion: '1.0',
          ApiPrivateKeys.kappId,
          ApiPrivateKeys.keyParseServerUrl,
          clientKey: ApiPrivateKeys.kclientKey,
          debug: true,
          autoSendSessionId: true)
      .then((value) async {
    ///has the current user and bool islogin data
    final Map loginData = (await ApiService.hasUserLoggedIn().timeout(
      const Duration(seconds: 7),
      onTimeout: () => {
        'currentUser': null,
        'isLoggedIn': false,
      },
    ));
    runApp(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router(loginData),
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          title: 'Spark',
          theme: lightTheme,
        ),
      ),
    );
  });
}
