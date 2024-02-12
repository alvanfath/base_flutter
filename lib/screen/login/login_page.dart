import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_cubit/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_cubit/repositories/user_repository.dart';
import 'package:flutter_cubit/screen/login/login_data.dart';
import 'package:flutter_cubit/screen/login/login_screen.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login_page';
  final UserRepository userRepository;
  const LoginPage({
    super.key,
    required this.userRepository,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginDatas = LoginData();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(
          userRepository: widget.userRepository,
          authBloc: BlocProvider.of<AuthBloc>(context),
        );
      },
      child: LoginScreen(
        userRepository: widget.userRepository,
        loginDatas: loginDatas,
      ),
    );
  }
}
