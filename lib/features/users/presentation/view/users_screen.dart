import 'package:flutter/material.dart';
import 'package:omar_ayman_tafeel/features/users/presentation/view/widgets/user_card.dart';
import 'package:sizer/sizer.dart';

import '../../models/users_response.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            UserListItem(
              user: User(
                id: 1,
                email: 'a@a.com',
                firstName: 'Omar',
                lastName: 'Ayman',
                avatar: 'https://randomuser.me/api/portraits/men/8.jpg',
              ),
            ),
            SizedBox(height: 4),
            UserListItem(
              user: User(
                id: 1,
                email: 'a@a.com',
                firstName: 'Omar',
                lastName: 'Ayman',
                avatar: 'https://www.citypng.com/public/uploads/preview/hd-man-user-illustration-icon-transparent-png-701751694974843ybexneueic.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
