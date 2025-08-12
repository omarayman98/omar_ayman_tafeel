import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:omar_ayman_tafeel/features/single_user/models/single_user_response.dart';

import '../../../../core/network/network_service.dart';
import '../../data/single_user_provider.dart';

part 'single_user_state.dart';

class SingleUserCubit extends Cubit<SingleUserState> {
  static SingleUserCubit get(context) => BlocProvider.of(context);

  SingleUserCubit() : super(SingleUserInitial());
  SingleUserProvider provider = SingleUserProvider();

  getSingleUser(context, {required int id}) async {
    emit(SingleUserLoading());
    try {
      final user = await provider.getUserById(id);

      emit(GetSingleUserSuccess(user));
    } on DioException catch (e) {
      log('get single user error $e');
      Exception error = parseExceptionAndHandle(e);
      String fullError =
          '${'$error\n' + e.response?.data['message']}\n${e.response!.statusCode}';
      emit(GetSingleUserFailed(error: fullError));
    }
  }
}
