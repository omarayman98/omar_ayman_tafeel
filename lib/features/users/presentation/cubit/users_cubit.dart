import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:omar_ayman_tafeel/features/users/models/users_response.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  static UsersCubit get(context) => BlocProvider.of(context);

  UsersCubit() : super(UsersInitial());
  List<User> offers = [];
  // OffersProvidervider provider = OffersProvider();
  bool isLastPage = false;
  int pageNum = 0;}
