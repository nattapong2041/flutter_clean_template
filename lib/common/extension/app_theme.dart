import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_style.dart';

class AppTheme {
  static get mainTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        extensions: <ThemeExtension<dynamic>>[
          AppColors(
            primary: HexColor.fromHex("#00d1b2"),
            secondary: HexColor.fromHex("#00d1b2"),
            white: HexColor.fromHex("#ffffff"),
            black: HexColor.fromHex("#000000"),
            light: HexColor.fromHex("#f5f5f5"),
            dark: HexColor.fromHex("#363636"),
            success: HexColor.fromHex("#23d160"),
            warning: HexColor.fromHex("#ffdd57"),
            danger: HexColor.fromHex("#ff3860"),
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
            primary: HexColor.fromHex("#00d1b2"),
            secondary: HexColor.fromHex("#00d1b2"),
            white: HexColor.fromHex("#ffffff"),
            black: HexColor.fromHex("#000000"),
            light: HexColor.fromHex("#f5f5f5"),
            dark: HexColor.fromHex("#363636"),
            success: HexColor.fromHex("#23d160"),
            warning: HexColor.fromHex("#ffdd57"),
            danger: HexColor.fromHex("#ff3860"),
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
