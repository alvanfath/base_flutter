import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_cubit/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;
  LoginBloc({
    required this.userRepository,
    required this.authBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      print('emit bre');
      try {
        final response = await userRepository.login(
          event.email,
          event.password,
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          print('responsenya: ${response.data}');
          authBloc.add(LoggedIn(token: response.data['data'].toString()));
          emit(LoginInitial());
        } else {
          emit(LoginError(error: response.data['message']));
        }
        print('ini data ${response.data}');
      } catch (e) {
        print('errornya $e');
        emit(LoginError(error: e.toString()));
      }
    });
  }
}
