part of 'single_user_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class GetUsersSuccess extends UsersState {
  final SingleUserResponse response;

  GetUsersSuccess(this.response);
}

final class GetUsersFailed extends UsersState {
  final String error;

  GetUsersFailed({required this.error});
}
