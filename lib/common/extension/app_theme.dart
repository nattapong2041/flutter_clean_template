import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_style.dart';

class AppTheme {
  static get mainTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        extensions: <ThemeExtension<dynamic>>[
          AppColors(
            baseShimmer: Colors.grey[300]!,
            highlightShimmer: Colors.grey[100]!,
          ),
          const AppTextTheme(
            kanitNormalText: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Kanit',
            ),
            kanitBoldText: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Kanit',
            ),
          ),
        ],
      );

  static get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        extensions: <ThemeExtension<dynamic>>[
          AppColors(
            baseShimmer: Colors.grey[300]!,
            highlightShimmer: Colors.grey[100]!,
          ),
          const AppTextTheme(
            kanitNormalText: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Kanit',
            ),
            kanitBoldText: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Kanit',
            ),
          ),
        ],
      );
}
