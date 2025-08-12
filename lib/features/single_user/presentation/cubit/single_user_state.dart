part of 'single_user_cubit.dart';

@immutable
sealed class SingleUserState {}

final class SingleUserInitial extends SingleUserState {}

final class SingleUserLoading extends SingleUserState {}

final class GetSingleUserSuccess extends SingleUserState {
  final SingleUserResponse response;

  GetSingleUserSuccess(this.response);
}

final class GetSingleUserFailed extends SingleUserState {
  final String error;

  GetSingleUserFailed({required this.error});
}
