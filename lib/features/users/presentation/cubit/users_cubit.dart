import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:omar_ayman_tafeel/features/users/data/users_provider.dart';
import 'package:omar_ayman_tafeel/features/users/models/users_response.dart';

import '../../../../core/network/network_service.dart';
import '../../../single_user/models/single_user_response.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  static UsersCubit get(context) => BlocProvider.of(context);

  UsersCubit() : super(UsersInitial());
  List<UserData> users = [];
  UsersProvider provider = UsersProvider();
  bool isLastPage = false;
  int pageNum = 0;

  getUsers(context, {required int pageNumber}) async {
    if (pageNumber == 0) emit(UsersLoading());
    try {
      final response = await provider.getUsers(pageNum);
      log('response ${response.data.length}');
              users.addAll(response.data);

      if (response.page == pageNumber) {
        isLastPage = true;
      } else {
        isLastPage = false;
        users.addAll(response.data);
        log('requests length is ${users.length}');
        log(' isLastPage $isLastPage');
      }
      emit(GetUsersSuccess(response));
    } on DioException catch (e) {
      log('get all users error $e');
      Exception error = parseExceptionAndHandle(e);
      String fullError =
          '${'$error\n' + e.response?.data['message']}\n${e.response!.statusCode}';
      emit(GetUsersFailed(error: fullError));
    }
  }
}
