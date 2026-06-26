class AppVersionConfigModel {
  const AppVersionConfigModel({
    required this.android,
    required this.ios,
  });

  factory AppVersionConfigModel.fromJson(Map<String, dynamic> json) {
    return AppVersionConfigModel(
      android: PlatformVersionConfigModel.fromJson(
        json['android'] as Map<String, dynamic>? ?? const {},
      ),
      ios: PlatformVersionConfigModel.fromJson(
        json['ios'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  final PlatformVersionConfigModel android;
  final PlatformVersionConfigModel ios;
}

class PlatformVersionConfigModel {
  const PlatformVersionConfigModel({
    required this.versionCode,
    required this.isForced,
    this.versionName,
  });

  factory PlatformVersionConfigModel.fromJson(Map<String, dynamic> json) {
    return PlatformVersionConfigModel(
      versionCode: json['versionCode'] as int? ?? 0,
      isForced: json['isForced'] as bool? ?? false,
      versionName: json['versionName'] as String?,
    );
  }

  final int versionCode;
  final bool isForced;
  final String? versionName;
}
