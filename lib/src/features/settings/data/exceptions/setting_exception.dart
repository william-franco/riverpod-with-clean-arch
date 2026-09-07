class SettingException implements Exception {
  final String message;

  const SettingException(this.message);

  @override
  String toString() => 'SettingException: $message';
}
