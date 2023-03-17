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
    required this.baseShimmer,
    required this.highlightShimmer,
  });

  final Color baseShimmer;
  final Color highlightShimmer;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? baseShimmer,
    Color? highlightShimmer,
  }) {
    return AppColors(
      baseShimmer: baseShimmer ?? this.baseShimmer,
      highlightShimmer: highlightShimmer ?? this.highlightShimmer,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      baseShimmer: Color.lerp(baseShimmer, other.baseShimmer, t)!,
      highlightShimmer:
          Color.lerp(highlightShimmer, other.highlightShimmer, t)!,
    );
  }

  // Optional
  @override
  String toString() =>
      'MyColors(baseShimmer: $baseShimmer, highlightShimmer: $highlightShimmer)';
}
