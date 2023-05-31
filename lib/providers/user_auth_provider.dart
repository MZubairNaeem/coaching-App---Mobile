import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

final currentUserProvider = StateNotifierProvider((ref) {
  return UserProvider();
});

class UserProvider extends StateNotifier<UserModel?> {
  UserProvider() : super(null);

  void setUser(UserModel? user) {
    state = user;
  }
}
