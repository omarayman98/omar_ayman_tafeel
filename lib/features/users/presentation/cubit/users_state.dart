part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class GetUsersSuccess extends UsersState {
  final UsersResponse response;

  GetUsersSuccess(this.response);
}

final class GetUsersFailed extends UsersState {
  final String error;

  GetUsersFailed({required this.error});
}
