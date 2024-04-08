// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hermione/src/core/global/userdetail.dart';
// import 'package:hermione/src/features/auth/presentation/pages/login.dart';
// import 'package:hermione/src/features/auth/presentation/pages/signup.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
//
// import '../../features/home/presentation/pages/homepage.dart';
//
// ///obtains the ref fromthe main,dart and returns it as a getter
// ///operation (abstraction)
// GoRouter router(Map loginData) => GoRouter(
//       initialExtra: loginData['isLoggedIn'] == true
//           ? loginData['currentUser'].toJson()
//           : null,
//       initialLocation:
//           loginData['isLoggedIn'] == true ? '/${HomePage.id}' : Login.id,
//       routes: <GoRoute>[
//         GoRoute(
//           path: SignUp.id,
//           builder: (BuildContext context, GoRouterState state) =>
//               const SignUp(),
//         ),
//         GoRoute(
//           path: Login.id,
//           builder: (BuildContext context, GoRouterState state) => const Login(),
//         ),
//         GoRoute(
//           name: HomePage.id,
//           // redirect: (context, state) {
//           //   print(state.error);
//           //   return isLoggedin == true ? state.path : '/${LogIn.id}';
//           // },
//           path: '/${HomePage.id}',
//           builder: (BuildContext context, GoRouterState state) {
//             Map<String, dynamic> args = state.extra as Map<String, dynamic>;
//             print(args);
//             return HomePage(
//               userDetails: UserDetails(
//                 user: ParseUser.clone(args),
//               ),
//             );
//           },
//         ),
//       ],
//     );
