import 'package:omar_ayman_tafeel/features/users/models/users_response.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/network_service.dart';

class UsersProvider {
  Future<UsersResponse> getUsers(int pageNumber) async {
    var users = await getCallService('users?page=2');
    return UsersResponse.fromJson(users.data);
  }
}
