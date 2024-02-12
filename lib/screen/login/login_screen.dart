import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/app/constants/app_constants.dart';
import 'package:flutter_cubit/app/widgets/widget.dart';
import 'package:flutter_cubit/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_cubit/repositories/user_repository.dart';
import 'package:flutter_cubit/screen/login/login_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  final UserRepository userRepository;
  final LoginData loginDatas;
  const LoginScreen({
    required this.userRepository,
    required this.loginDatas,
    super.key,
  });

  @override
  // ignore: no_logic_in_create_state
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    final loginData = widget.loginDatas;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          showToastBottom(state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return bodyBuilder(
            bloc,
            loginData,
          );
        },
      ),
    );
  }

  Widget bodyBuilder(LoginBloc bloc, LoginData loginData) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              SvgPicture.asset('assets/images/logo.svg'),
              const SizedBox(height: 40),
              const TextWidget(
                text: 'Login',
                fontSize: 18,
                fontWeight: AppConstants.bold,
                align: TextAlign.center,
              ),
              const SizedBox(height: 8),
              TextWidget(
                text: 'Silakan masuk menggunakan akun Anda',
                fontSize: 14,
                fontWeight: AppConstants.regular,
                align: TextAlign.center,
                color: HexColor('#999999'),
              ),
              const SizedBox(height: 40),
              emailTextField(bloc, loginData),
              const SizedBox(height: 16),
              passwordTextField(bloc, loginData),
              const SizedBox(height: 12),
              forgotPassword(),
              const SizedBox(height: 40),
              buttonLogin(bloc, loginData),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailTextField(LoginBloc bloc, LoginData loginData) {
    return StreamBuilder<String?>(
      stream: loginData.emailErrorStream,
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Email',
              fontSize: 12,
              fontWeight: AppConstants.regular,
              color: Color(0xffAAAAAA),
            ),
            const SizedBox(height: 4),
            Stack(
              alignment: Alignment.topRight,
              children: [
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(
                      fontFamily: 'Poppins', color: Colors.black),
                  onChanged: (String val) {
                    loginData.emailController.add(val);
                  },
                  decoration: inputDecor(
                    context,
                    AppConstants.primaryColor,
                    'Masukkan email',
                    snapshot.hasData,
                  ),
                ),
                if (snapshot.hasData)
                  Padding(
                    padding: const EdgeInsets.only(top: 66),
                    child: TextWidget(
                      text: snapshot.data ?? '',
                      fontSize: 12,
                      fontWeight: AppConstants.regular,
                      color: AppConstants.errorColor,
                    ),
                  )
              ],
            ),
          ],
        );
      },
    );
  }

  Widget passwordTextField(LoginBloc bloc, LoginData loginData) {
    return StreamBuilder<String?>(
      stream: loginData.passwordErrorStream,
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Password',
              fontSize: 12,
              fontWeight: AppConstants.regular,
              color: Color(0xffAAAAAA),
            ),
            const SizedBox(height: 4),
            Stack(
              alignment: Alignment.topRight,
              children: [
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                  onChanged: (String val) {
                    loginData.passwordController.add(val);
                  },
                  obscureText: isHidden,
                  decoration: InputDecoration(
                    errorText: snapshot.hasData ? '' : null,
                    hintText: 'Masukkan password',
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                        () => isHidden = !isHidden,
                      ),
                      icon: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                        color: HexColor('#AAAAAA'),
                      ),
                      iconSize: 18.0,
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xffBEBEBE),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffDDDDDD),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppConstants.errorColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppConstants.primaryColor,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppConstants.errorColor,
                      ),
                    ),
                  ),
                ),
                if (snapshot.hasData)
                  Padding(
                    padding: const EdgeInsets.only(top: 66),
                    child: TextWidget(
                      text: snapshot.data ?? '',
                      fontSize: 12,
                      fontWeight: AppConstants.regular,
                      color: AppConstants.errorColor,
                    ),
                  )
              ],
            ),
          ],
        );
      },
    );
  }

  Widget forgotPassword() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {},
          child: const TextWidget(
            text: 'Lupa Password?',
            fontSize: 12,
            fontWeight: AppConstants.regular,
            color: AppConstants.primaryColor,
            align: TextAlign.end,
          ),
        )
      ],
    );
  }

  Widget buttonLogin(LoginBloc bloc, LoginData loginData) {
    return StreamBuilder<bool>(
      stream: loginData.isLoadingStream,
      builder: (context, snapshot) {
        final isLoading = snapshot.data ?? false;
        return StreamBuilder(
          stream: loginData.isValidButton,
          builder: (context, snapshot) {
            final isValid = snapshot.data ?? false;
            return ButtonWidget(
              height: 45,
              text: 'Login',
              action: () {
                bloc.add(
                  LoginButtonPressed(
                    email: loginData.emailController.value,
                    password: loginData.passwordController.value,
                  ),
                );
              },
              isLoading: isLoading,
              color: isValid
                  ? AppConstants.primaryColor
                  : AppConstants.defaultColor,
              borderColor: isValid
                  ? AppConstants.primaryColor
                  : AppConstants.defaultColor,
              textColor: Colors.white,
            );
          },
        );
      },
    );
  }
}
