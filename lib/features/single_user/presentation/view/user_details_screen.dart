import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_ayman_tafeel/features/single_user/models/single_user_response.dart';
import 'package:sizer/sizer.dart';

import '../cubit/single_user_cubit.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserData user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              children: [
                Hero(
                  tag: 'tag',
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user.avatar,
                      width: 30.w,
                      height: 30.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.blue.shade700,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'ID: ${user.id}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // BlocProvider(
          //   create: (context) =>
          //       SingleUserCubit()..getSingleUser(context, id: this.user.id),
          //   child: BlocBuilder<SingleUserCubit, SingleUserState>(
          //     builder: (context, state) {
          //       if (state is SingleUserLoading) {
          //         return LinearProgressIndicator();
          //       } else if (state is GetSingleUserFailed) {
          //         return Text(
          //           state.error,
          //           style: TextStyle(color: Colors.red, fontSize: 14.sp),
          //         );
          //       } else if (state is GetSingleUserSuccess) {
          //         UserData user = user;
          //         return Padding(
          //           padding: EdgeInsets.all(16.sp),
          //           child: Column(
          //             children: [
          //               Hero(
          //                 tag: 'tag',
          //                 child: ClipOval(
          //                   child: CachedNetworkImage(
          //                     imageUrl: user.avatar,
          //                     width: 30.w,
          //                     height: 30.w,
          //                     fit: BoxFit.cover,
          //                     placeholder: (context, url) =>
          //                         CircularProgressIndicator(),
          //                     errorWidget: (context, url, error) =>
          //                         const Icon(Icons.error, color: Colors.red),
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(height: 2.h),
          //               Text(
          //                 '${user.firstName} ${user.lastName}',
          //                 style: TextStyle(
          //                   fontSize: 20.sp,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               SizedBox(height: 1.h),
          //               Text(
          //                 user.email,
          //                 style: TextStyle(
          //                   fontSize: 16.sp,
          //                   color: Colors.blue.shade700,
          //                 ),
          //               ),
          //               SizedBox(height: 1.h),
          //               Text(
          //                 'ID: ${user.id}',
          //                 style: TextStyle(
          //                   fontSize: 12.sp,
          //                   color: Colors.grey.shade600,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       } else {
          //         return Center();
          //       }
          //     },
          //   ),
          // ),
        ),
      ),
    );
  }
}
