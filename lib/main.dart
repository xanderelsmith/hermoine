import 'package:flutter/material.dart';
import 'package:hermione/src/core/keys/backendkeys.dart';
import 'package:hermione/src/core/theme/theme.dart';
import 'package:hermione/src/features/home/presentation/pages/homepage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'src/features/auth/presentation/pages/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
      appName: 'Spark',
      appVersion: '1.0',
      ApiPrivateKeys.kappId,
      ApiPrivateKeys.keyParseServerUrl,
      clientKey: ApiPrivateKeys.kclientKey,
      debug: true,
      autoSendSessionId: true);
  runApp(MaterialApp(
    themeMode: ThemeMode.system,
    darkTheme: darkTheme,
    theme: lightTheme,
    home: const AuthWrapper(),
  ));
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignUp();
  }
}
