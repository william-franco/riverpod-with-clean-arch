class SettingEntity {
  final bool isDarkTheme;

  SettingEntity({this.isDarkTheme = false});

  SettingEntity copyWith({bool? isDarkTheme}) =>
      SettingEntity(isDarkTheme: isDarkTheme ?? this.isDarkTheme);
}
