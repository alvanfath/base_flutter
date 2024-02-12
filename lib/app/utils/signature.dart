import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_cubit/app/constants/app_constants.dart';

class Signature {
  String getSignature(Map<String, dynamic> payload) {
    final jwt = JWT(payload);
    final  tokenJwt = jwt.sign(
      SecretKey(AppConstants.secretKey),
      noIssueAt: true,
    );
    return tokenJwt.split('.')[2];
  }
}
