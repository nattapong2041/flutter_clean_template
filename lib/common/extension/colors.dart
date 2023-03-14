import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.secondary,
    required this.white,
    required this.black,
    required this.light,
    required this.dark,
    required this.success,
    required this.warning,
    required this.danger,
  });

  final Color? primary;
  final Color? secondary;
  final Color? white;
  final Color? black;
  final Color? light;
  final Color? dark;
  final Color? success;
  final Color? warning;
  final Color? danger;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? white,
    Color? black,
    Color? light,
    Color? dark,
    Color? success,
    Color? warning,
    Color? danger,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      white: white ?? this.white,
      black: black ?? this.black,
      light: light ?? this.light,
      dark: dark ?? this.dark,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      white: Color.lerp(white, other.white, t),
      black: Color.lerp(black, other.black, t),
      light: Color.lerp(light, other.light, t),
      dark: Color.lerp(dark, other.dark, t),
      success: Color.lerp(success, other.success, t),
      warning: Color.lerp(warning, other.warning, t),
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  // Optional
  @override
  String toString() => 'MyColors(brandColor: $primary, danger: $danger)';
}
