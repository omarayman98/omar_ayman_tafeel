import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_ayman_tafeel/features/single_user/models/single_user_response.dart';
import 'package:omar_ayman_tafeel/features/users/presentation/view/widgets/user_card.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/common_widgets/pagination_list.dart';
import '../cubit/users_cubit.dart';

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
        child: BlocProvider(
          create: (context) => UsersCubit()..getUsers(context, pageNumber: 1),
          child: BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) {
              if (state is UsersLoading) {
                return const Center(
                  // child: LoadingWidget(),
                );
              } else if (state is GetUsersFailed) {
                return Center(
                  child: Text(
                    state.error,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                );
              } else if (state is GetUsersSuccess) {
                var cubit=UsersCubit.get(context);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: cubit.users.isEmpty
                          ? Center(child: Text('No Users to View'))
                          : PaginatedListWidget<UserData>(
                              loadingIndicator: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                //      child: Center(child: LoadingWidget()),
                              ),
                              shrinkWrap: true,
                              items: cubit.users,
                              isRecentSearch: false,
                              isLastPage: cubit.isLastPage,
                              onLoadMore: () async {
                                await cubit.getUsers(
                                  context,
                                  pageNumber: ++cubit.pageNum,
                                );
                              },
                              builder: (e, index) => UserListItem(
                                user: cubit.users[index],
                              ),
                            ),
                    ),
                  ],
                );
              } else {
                return const Center();
              }
            },
          ),
        ),
      ),
    );
  }
}
