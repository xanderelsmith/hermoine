import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/theme/theme.dart';
import 'package:hermione/src/features/assessment/domain/entities/geminiapihelper.dart';
import 'package:hermione/src/features/auth/presentation/pages/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'firebase_options.dart';
import 'src/core/keys/backendkeys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: GeminiSparkConfig.apiKey);
  await Parse().initialize(
      appName: 'Hermoine',
      appVersion: '1.0',
      ApiPrivateKeys.kappId,
      ApiPrivateKeys.keyParseServerUrl,
      clientKey: ApiPrivateKeys.kclientKey,
      debug: true,
      autoSendSessionId: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ProviderScope(
        child: GetMaterialApp(
          theme: theme,
          title: 'hermoine',
          debugShowCheckedModeBanner: false,
          home: const AuthPage(),
        ),
      );
    });
  }
}
