import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:omar_ayman_tafeel/features/single_user/models/user_response.dart';

part 'single_user_state.dart';

class SingleUserCubit extends Cubit<UsersState> {
  SingleUserCubit() : super(UsersInitial());
}
