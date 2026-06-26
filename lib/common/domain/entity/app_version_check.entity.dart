class AppVersionCheckEntity {
  const AppVersionCheckEntity({
    required this.needsUpdate,
    required this.isForceUpdate,
  });

  final bool needsUpdate;
  final bool isForceUpdate;

  static const none = AppVersionCheckEntity(
    needsUpdate: false,
    isForceUpdate: false,
  );
}
