import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/app/constants/app_constants.dart';
import 'package:flutter_cubit/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_cubit/repositories/user_repository.dart';
import 'package:flutter_cubit/screen/home/home_page.dart';
import 'package:flutter_cubit/screen/login/login_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('${bloc.runtimeType} $stackTrace');
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  final userRepository = UserRepository();
  runApp(BlocProvider<AuthBloc>(
    create: (context) {
      return AuthBloc(userRepository: userRepository)..add(AppStarted());
    },
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({
    super.key,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('id', 'ID'),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blueGrey,
        primaryColor: AppConstants.primaryColor,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return const HomePage();
          }
          if (state is AuthUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }

          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      routes: {
        LoginPage.routeName: (context) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return LoginPage(userRepository: userRepository);
            },
          );
        },
        HomePage.routeName: (context) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return const HomePage();
            },
          );
        }
      },
    );
  }
}
