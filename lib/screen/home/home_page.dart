import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/app/constants/app_constants.dart';
import 'package:flutter_cubit/app/widgets/button.dart';
import 'package:flutter_cubit/app/widgets/text.dart';
import 'package:flutter_cubit/bloc/auth_bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const TextWidget(
          text: 'Homepage bro',
          fontSize: 16,
          fontWeight: AppConstants.semiBold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              bloc.add(LoggedOut());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: ButtonWidget(
          height: 45,
          color: AppConstants.primaryColor,
          text: 'Check token',
          action: () {
            bloc.add(CheckToken());
          },
          isLoading: false,
          borderColor: AppConstants.primaryColor,
        ),
      ),
    );
  }
}
