import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static String baseUrl = dotenv.env['BASE_URL'] ?? "";
  static String baseDomain = dotenv.env['BASE_DOMAIN'] ?? "";
}
