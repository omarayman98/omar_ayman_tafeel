import 'package:omar_ayman_tafeel/features/users/models/users_response.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/network_service.dart';
import '../models/single_user_response.dart';

class SingleUserProvider {
  Future<SingleUserResponse> getUserById(int id) async {
    var users = await getCallService('${ApiConstants.allUsers}/$id');
    return SingleUserResponse.fromJson(users.data);
  }
}
