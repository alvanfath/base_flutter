import 'package:flutter_cubit/app/utils/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginData {
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();
  final emailErrorController = BehaviorSubject<String?>();
  final passwordErrorController = BehaviorSubject<String?>();
  final isLoading = BehaviorSubject<bool>.seeded(false);
  //stream
  Stream<String> get emailStream => emailController.stream;
  Stream<String> get passwordStream => passwordController.stream;

  //error
  Stream<String?> get emailErrorStream => emailErrorController.stream;
  Stream<String?> get passwordErrorStream => passwordErrorController.stream;

  Stream<bool> get isLoadingStream => isLoading.stream;
  Stream<bool> get isValidButton => Rx.combineLatest2(
        emailStream,
        passwordStream,
        (String? email, String? password) {
          return email != null && Validator.isValidEmail(email);
        },
      ).shareValueSeeded(false);


  //login
  LoginData() {
    emailController.listen((email) {
      if (!Validator.isValidEmail(email)) {
        emailErrorController.add('Email tidak valid');
      } else {
        emailErrorController.add(null);
      }
    });

    passwordController.listen((password) {
      if (!Validator.isValidPassword(password)) {
        passwordErrorController.add('Password tidak valid');
      } else {
        passwordErrorController.add(null);
      }
    });
  }
}
