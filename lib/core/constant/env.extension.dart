import 'package:flutter_dotenv/flutter_dotenv.dart';

extension EnvConstantExtension on String {
  /// Retrieves the value of the environment variable
  /// corresponding to the given [key].
  ///
  /// Returns `'-'` when the variable is missing or empty.
  String get env => dotenv.env[this] ?? '-';
}
