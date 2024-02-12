import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_cubit/app/constants/app_constants.dart';
import 'package:flutter_cubit/app/utils/hash_data.dart';
import 'package:flutter_cubit/app/utils/signature.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class UserRepository {
  String loginUrl = '${AppConstants.mainUrl}/api/borroweruser/v2/user/login';

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final hash = HashData();
  late Dio _dio;

  UserRepository() {
    _dio = Dio();
    _dio.options.validateStatus = (int? status) {
      return status! >= 200 && status < 500;
    };
  }

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    return value != null;
  }

  Future<void> storeToken(String token) async {
    final encryptedToken = hash.encrypt(token);
    print('ini enkripsi token: ${encryptedToken.base64}');
    await storage.write(key: 'token', value: encryptedToken.base64);
  }

  Future<String?> getToken() async {
    final token = await storage.read(key: 'token');
    if (token != null) {
      print(token);
      final encryptedToken = Encrypted.fromBase64(token);
      final decryptedToken = hash.decrypt(encryptedToken);
      return decryptedToken;
    }
    return null;
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    await storage.deleteAll();
  }

  Future<Response> login(String email, String password) async {
    print(loginUrl);
    final dateNow = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
    final payload = {
      'request': {'email': email, 'password': password},
      'timestamp': dateNow,
    };
    final String signature = Signature().getSignature(payload);
    Response response = await _dio.postUri(
      Uri.parse(loginUrl),
      options: Options(headers: {
        'golang-auth': 'golang123',
        'api-key': signature,
        'timestamps': dateNow,
      }),
      data: payload,
    );
    print('datanya bang: ${response.data}');
    return response;
  }
}
