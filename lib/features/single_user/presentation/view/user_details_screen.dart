import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserDetailsScreen extends StatelessWidget {
  final int userId;

  const UserDetailsScreen({super.key, required this.userId});

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
                      imageUrl:
                          'https://www.citypng.com/public/uploads/preview/hd-man-user-illustration-icon-transparent-png-701751694974843ybexneueic.png',
                      width: 30.w,
                      height: 30.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Omar Ayman',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'o@a.com',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.blue.shade700,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'ID: 12341',
                  style: TextStyle(fontSize: 9.sp, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
