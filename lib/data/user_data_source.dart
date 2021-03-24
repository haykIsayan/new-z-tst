import 'package:new_z_tst/entity/user_repository.dart';

class UserDataSource implements UserRepository {
  @override
  Future<String> getUserCountry() async {
    return 'us';
  }
}
