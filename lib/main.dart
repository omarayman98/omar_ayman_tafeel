import 'package:flutter/material.dart';
import 'package:omar_ayman_tafeel/core/constants/app_colors.dart';
import 'package:omar_ayman_tafeel/features/users/presentation/view/users_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.backgroundColor,
            ),
          ),
          home: UsersScreen(),
        );
      },
    );
  }
}
