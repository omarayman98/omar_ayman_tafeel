import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:omar_ayman_tafeel/features/users/models/users_response.dart';
import 'package:sizer/sizer.dart';

import '../../../../single_user/models/single_user_response.dart';
import '../../../../single_user/presentation/view/user_details_screen.dart';

class UserListItem extends StatelessWidget {
  final UserData user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'tag',
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: user.avatar,
            width: 30.sp,
            height: 30.sp,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Icon(Icons.person, color: Colors.grey.shade200),
          ),
        ),
      ),
      title: Text(
        '${user.firstName} ${user.lastName}',
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        user.email,
        style: TextStyle(fontSize: 16.sp, color: Colors.blue.shade700),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsScreen(user: user),
          ),
        );
      },
    );
  }
}
