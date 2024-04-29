import 'package:hermione/src/features/auth/data/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserNotifier extends StateNotifier<UserDetails?> {
  UserNotifier() : super(null);

  assignUserData(UserDetails userdata) {
    state = userdata;
  }

  copyWithXp(String xp) {
    UserDetails userdata = state!;
    state = userdata.copyWith(xp: xp);
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, UserDetails?>((ref) => UserNotifier());
