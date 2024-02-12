import 'package:encrypt/encrypt.dart';
import 'package:flutter_cubit/app/constants/app_constants.dart';

class HashData {
  final Key key;
  final Encrypter encrypter;

  HashData()
      : key = Key.fromUtf8(AppConstants.key32),
        encrypter = Encrypter(
          AES(
            Key.fromUtf8(AppConstants.key32),
            mode: AESMode.cbc,
          ),
        );

  Encrypted encrypt(String token) {
    final iv = IV.fromLength(16);
    return encrypter.encrypt(token, iv: iv);
  }

  dynamic decrypt(Encrypted data) {
    final iv = IV.fromLength(16);
    return encrypter.decrypt(data, iv: iv);
  }
}
