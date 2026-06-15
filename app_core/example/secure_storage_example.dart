// ignore_for_file: avoid_print

import 'package:app_core/app_core.dart';
import 'example_di.dart';

/// Secure Storage Service Example
///
/// This example demonstrates how to use the Secure Storage Service
/// for storing sensitive data securely across all platforms.
///
/// Run this example:
/// ```bash
/// dart run example/secure_storage_example.dart
/// ```

Future<void> main() async {
  print('=================================================');
  print('   Secure Storage Service Example');
  print('=================================================\n');

  // Setup
  await setup();

  // Run examples
  await basicExample();
  await authenticationExample();
  await platformSpecificExample();
  await errorHandlingExample();
  await advancedExample();

  print('\n=================================================');
  print('   All Examples Completed!');
  print('=================================================');
}

/// Setup dependencies
Future<void> setup() async {
  print('📦 Setting up dependencies...\n');

  // Register secure storage service
  getIt.registerLazySingleton<SecureStorageService>(
    () => FlutterSecureStorageServiceImpl(
      options: SecureStorageOptions.balanced(),
    ),
  );

  print('✅ Dependencies registered\n');
}

/// Example 1: Basic Operations
Future<void> basicExample() async {
  print('─────────────────────────────────────────────────');
  print('Example 1: Basic Operations');
  print('─────────────────────────────────────────────────\n');

  final secureStorage = getIt<SecureStorageService>();

  // Write
  print('📝 Writing data...');
  final writeResult = await secureStorage.write(
    key: 'example_key',
    value: 'example_secret_value',
  );

  writeResult.fold(
    (failure) => print('❌ Write failed: $failure'),
    (_) => print('✅ Write successful'),
  );

  // Read
  print('\n📖 Reading data...');
  final readResult = await secureStorage.read(key: 'example_key');

  readResult.fold(
    (failure) => print('❌ Read failed: $failure'),
    (value) => print('✅ Read successful: $value'),
  );

  // Check if exists
  print('\n🔍 Checking if key exists...');
  final existsResult = await secureStorage.containsKey(key: 'example_key');

  existsResult.fold(
    (failure) => print('❌ Check failed: $failure'),
    (exists) => print('✅ Key exists: $exists'),
  );

  // Delete
  print('\n🗑️  Deleting data...');
  final deleteResult = await secureStorage.delete(key: 'example_key');

  deleteResult.fold(
    (failure) => print('❌ Delete failed: $failure'),
    (_) => print('✅ Delete successful'),
  );

  print('');
}

/// Example 2: Authentication Flow
Future<void> authenticationExample() async {
  print('─────────────────────────────────────────────────');
  print('Example 2: Authentication Flow');
  print('─────────────────────────────────────────────────\n');

  final secureStorage = getIt<SecureStorageService>();

  // Simulate login - save tokens
  print('🔐 Simulating login...');

  await secureStorage.write(
    key: SecureStorageConstants.authToken,
    value: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.example',
  );

  await secureStorage.write(
    key: SecureStorageConstants.refreshToken,
    value: 'refresh_token_example',
  );

  await secureStorage.write(
    key: SecureStorageConstants.userId,
    value: 'user_123',
  );

  print('✅ Login tokens saved');

  // Check if logged in
  print('\n🔍 Checking if user is logged in...');
  final isLoggedInResult = await secureStorage.containsKey(
    key: SecureStorageConstants.authToken,
  );

  final isLoggedIn = isLoggedInResult.fold(
    (failure) => false,
    (exists) => exists,
  );

  print('✅ User is logged in: $isLoggedIn');

  // Get auth token
  print('\n🎫 Getting auth token...');
  final tokenResult = await secureStorage.read(
    key: SecureStorageConstants.authToken,
  );

  tokenResult.fold(
    (failure) => print('❌ Failed to get token: $failure'),
    (token) {
      if (token != null) {
        final preview =
            token.length > 50 ? '${token.substring(0, 50)}...' : token;
        print('✅ Auth token: $preview');
      }
    },
  );

  // Get all auth keys
  print('\n📋 Getting all stored keys...');
  final keysResult = await secureStorage.getAllKeys();

  keysResult.fold(
    (failure) => print('❌ Failed to get keys: $failure'),
    (keys) => print('✅ Stored keys: $keys'),
  );

  // Simulate logout
  print('\n👋 Simulating logout...');
  for (final key in SecureStorageConstants.authKeys) {
    await secureStorage.delete(key: key);
  }
  await secureStorage.delete(key: SecureStorageConstants.userId);

  print('✅ Logout successful (all tokens deleted)');

  // Verify logged out
  final stillLoggedInResult = await secureStorage.containsKey(
    key: SecureStorageConstants.authToken,
  );

  final stillLoggedIn = stillLoggedInResult.fold(
    (failure) => false,
    (exists) => exists,
  );

  print('✅ User is still logged in: $stillLoggedIn');

  print('');
}

/// Example 3: Platform-Specific Options
Future<void> platformSpecificExample() async {
  print('─────────────────────────────────────────────────');
  print('Example 3: Platform-Specific Options');
  print('─────────────────────────────────────────────────\n');

  final secureStorage = getIt<SecureStorageService>();

  // iOS: Save with first unlock accessibility
  print('🍎 iOS Example: First Unlock Accessibility');
  await secureStorage.write(
    key: 'ios_token',
    value: 'token_value',
    options: const SecureStorageOptions(
      accessibility: KeychainAccessibility.firstUnlock,
    ),
  );
  print('✅ Saved with firstUnlock accessibility (good for background tasks)');

  // iOS: Save device-only secret (no iCloud sync)
  print('\n🍎 iOS Example: Device-Only Secret');
  await secureStorage.write(
    key: 'device_secret',
    value: 'device_specific_secret',
    options: const SecureStorageOptions(
      accessibility: KeychainAccessibility.firstUnlockThisDeviceOnly,
      iCloudSync: false,
    ),
  );
  print('✅ Saved as device-only (no iCloud backup)');

  // Android: Using EncryptedSharedPreferences
  print('\n🤖 Android Example: EncryptedSharedPreferences');
  await secureStorage.write(
    key: 'android_data',
    value: 'android_secure_data',
    options: const SecureStorageOptions(
      useEncryptedSharedPreferences: true,
    ),
  );
  print('✅ Saved using EncryptedSharedPreferences');

  // Read back
  print('\n📖 Reading platform-specific data...');
  final iosResult = await secureStorage.read(key: 'ios_token');
  final deviceResult = await secureStorage.read(key: 'device_secret');
  final androidResult = await secureStorage.read(key: 'android_data');

  iosResult.fold(
    (failure) => print('❌ iOS token: failed'),
    (value) => print('✅ iOS token: ${value != null ? "exists" : "null"}'),
  );

  deviceResult.fold(
    (failure) => print('❌ Device secret: failed'),
    (value) => print('✅ Device secret: ${value != null ? "exists" : "null"}'),
  );

  androidResult.fold(
    (failure) => print('❌ Android data: failed'),
    (value) => print('✅ Android data: ${value != null ? "exists" : "null"}'),
  );

  // Cleanup
  await secureStorage.delete(key: 'ios_token');
  await secureStorage.delete(key: 'device_secret');
  await secureStorage.delete(key: 'android_data');

  print('');
}

/// Example 4: Error Handling
Future<void> errorHandlingExample() async {
  print('─────────────────────────────────────────────────');
  print('Example 4: Error Handling');
  print('─────────────────────────────────────────────────\n');

  final secureStorage = getIt<SecureStorageService>();

  // Try to read non-existent key
  print('📖 Reading non-existent key...');
  final result = await secureStorage.read(key: 'non_existent_key');

  result.fold(
    (failure) {
      print('❌ Failed as expected: $failure');

      // Handle specific failure types
      if (failure is SecureStorageKeyNotFoundFailure) {
        print('   → This is a KeyNotFound failure');
      } else if (failure is SecureStorageReadFailure) {
        print('   → This is a generic Read failure');
      } else {
        print('   → Unknown failure type');
      }
    },
    (value) {
      if (value == null) {
        print('✅ Key not found (value is null)');
      } else {
        print('✅ Value: $value');
      }
    },
  );

  // Try to write with invalid key (empty string)
  print('\n📝 Writing with empty key...');
  final invalidResult = await secureStorage.write(
    key: '',
    value: 'some_value',
  );

  invalidResult.fold(
    (failure) {
      print('❌ Failed as expected: $failure');

      if (failure is SecureStorageInvalidKeyFailure) {
        print('   → Invalid key detected!');
      }
    },
    (_) => print('✅ Unexpectedly succeeded'),
  );

  // Proper error handling with fold
  print('\n🛡️  Proper error handling example:');
  final properResult = await secureStorage.read(key: 'some_key');

  properResult.fold(
    (failure) {
      // Log error
      print('   ❌ Error occurred: ${failure.message}');

      // Take appropriate action based on failure type
      if (failure is SecureStorageKeyNotFoundFailure) {
        print('   → Action: Redirect to login');
      } else if (failure is SecureStorageAccessDeniedFailure) {
        print('   → Action: Request permissions');
      } else if (failure is SecureStorageEncryptionFailure) {
        print('   → Action: Clear corrupted data');
      } else {
        print('   → Action: Show generic error');
      }
    },
    (value) {
      if (value != null) {
        print('   ✅ Success: Got value');
      } else {
        print('   ℹ️  Key exists but value is null');
      }
    },
  );

  print('');
}

/// Example 5: Advanced Patterns
Future<void> advancedExample() async {
  print('─────────────────────────────────────────────────');
  print('Example 5: Advanced Patterns');
  print('─────────────────────────────────────────────────\n');

  final secureStorage = getIt<SecureStorageService>();

  // Pattern 1: Using Constants
  print('📋 Pattern 1: Using Constants');
  await secureStorage.write(
    key: SecureStorageConstants.authToken,
    value: 'token_123',
  );
  await secureStorage.write(
    key: SecureStorageConstants.refreshToken,
    value: 'refresh_456',
  );
  await secureStorage.write(
    key: SecureStorageConstants.apiKey,
    value: 'api_key_789',
  );
  print('✅ Saved using predefined constants');

  // Pattern 2: Building custom keys
  print('\n🔨 Pattern 2: Building Custom Keys');
  final customAuthKey = SecureStorageConstants.buildAuthKey('custom');
  final customUserKey = SecureStorageConstants.buildUserKey('profile');

  await secureStorage.write(
    key: customAuthKey,
    value: 'custom_auth_value',
  );
  await secureStorage.write(
    key: customUserKey,
    value: 'custom_user_value',
  );
  print('✅ Saved with custom keys: $customAuthKey, $customUserKey');

  // Pattern 3: Batch operations
  print('\n📦 Pattern 3: Read All');
  final allResult = await secureStorage.readAll();

  allResult.fold(
    (failure) => print('❌ Failed to read all: $failure'),
    (allData) {
      print('✅ Total items in secure storage: ${allData.length}');
      allData.forEach((key, value) {
        final preview =
            value.length > 20 ? '${value.substring(0, 20)}...' : value;
        print('   → $key: $preview');
      });
    },
  );

  // Pattern 4: Conditional delete
  print('\n🗑️  Pattern 4: Selective Delete');
  print('   Deleting all auth-related keys...');

  for (final key in SecureStorageConstants.authKeys) {
    await secureStorage.delete(key: key);
  }

  // Also delete custom keys
  await secureStorage.delete(key: customAuthKey);
  await secureStorage.delete(key: customUserKey);

  print('✅ Deleted auth keys');

  // Pattern 5: Key validation
  print('\n✔️  Pattern 5: Key Validation');
  const validKey = 'valid_key_123';
  const invalidKey = 'invalid key with spaces!';

  print('   Validating "$validKey": '
      '${SecureStorageConstants.isValidKey(validKey) ? "✅ Valid" : "❌ Invalid"}');

  print('   Validating "$invalidKey": '
      '${SecureStorageConstants.isValidKey(invalidKey) ? "✅ Valid" : "❌ Invalid"}');

  // Sanitize invalid key
  final sanitized = SecureStorageConstants.sanitizeKey(invalidKey);
  print('   Sanitized: "$invalidKey" → "$sanitized"');

  // Pattern 6: Delete all (cleanup)
  print('\n🧹 Pattern 6: Complete Cleanup');
  await secureStorage.deleteAll();
  print('✅ All secure storage cleared');

  // Verify empty
  final keysAfterClear = await secureStorage.getAllKeys();
  keysAfterClear.fold(
    (failure) => print('❌ Failed to verify: $failure'),
    (keys) => print('✅ Remaining keys: ${keys.isEmpty ? "none" : keys}'),
  );

  print('');
}

/// Helper: Get auth token safely
Future<String?> getAuthTokenSafely(SecureStorageService storage) async {
  final result = await storage.read(
    key: SecureStorageConstants.authToken,
  );

  return result.fold(
    (failure) {
      print('Failed to get token: $failure');
      return null;
    },
    (token) => token,
  );
}

/// Helper: Save multiple auth data
Future<bool> saveAuthData(
  SecureStorageService storage, {
  required String token,
  required String refreshToken,
  required String userId,
}) async {
  final results = await Future.wait([
    storage.write(
      key: SecureStorageConstants.authToken,
      value: token,
    ),
    storage.write(
      key: SecureStorageConstants.refreshToken,
      value: refreshToken,
    ),
    storage.write(
      key: SecureStorageConstants.userId,
      value: userId,
    ),
  ]);

  // Check if all succeeded
  return results.every((result) => result.isRight());
}

/// Helper: Clear all auth data
Future<void> clearAuthData(SecureStorageService storage) async {
  for (final key in [
    ...SecureStorageConstants.authKeys,
    ...SecureStorageConstants.userKeys,
  ]) {
    await storage.delete(key: key);
  }
}
