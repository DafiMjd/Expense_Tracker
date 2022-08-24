import 'package:expense_tracker/models/user.dart';
import 'package:hive/hive.dart';

class AuthService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('userBox');

    await _users.clear();
    print('finish user hive');

    await _users.add(User('dafi', 'dafi'));
    await _users.add(User('majid', 'majid'));

    print('finish add user hive');

  }

  Future<String?> authUser(final String username, final String password) async {
    final success = await _users.values.any((element) =>
        element.username == username && element.password == password);

    if (success) {
      return username;
    } else {
      return null;
    }
  }
}
