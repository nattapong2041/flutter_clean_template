import 'package:flutter/material.dart';

@immutable
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  const AppTextTheme({
    required this.kanitNormalText,
    required this.kanitBoldText,
  });

  final TextStyle? kanitNormalText;
  final TextStyle? kanitBoldText;

  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? kanitNormalText,
    TextStyle? kanitBoldText,
  }) {
    return AppTextTheme(
      kanitNormalText: kanitNormalText ?? this.kanitNormalText,
      kanitBoldText: kanitBoldText ?? this.kanitBoldText,
    );
  }

  @override
  ThemeExtension<AppTextTheme> lerp(
      ThemeExtension<AppTextTheme>? other, double t) {
    if (other is! AppTextTheme) {
      return this;
    }
    return AppTextTheme(
      kanitNormalText:
          TextStyle.lerp(kanitNormalText, other.kanitNormalText, t),
      kanitBoldText: TextStyle.lerp(kanitBoldText, other.kanitBoldText, t),
    );
  }
}
