import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

///Keep all app setting in the app
class AppSetting {
  late final SharedPreferences _prefs;

  /// Add some variable that use in app eg. user, language, ...
  late final currentLocale = ValueNotifier<String?>(null);
  bool isJailBroken = false;
  bool canMockLocation = false;
  bool isRealDevice = false;
  bool isOnExternalStorage = false;
  bool isSafeDevice = false;
  bool isDevelopmentModeEnabled = false;

  //TODO: init all app setting here
  /// Initial all app setting
  Future<void> init() async {
    final ImagePickerPlatform imagePickerImplementation =
        ImagePickerPlatform.instance;
    if (imagePickerImplementation is ImagePickerAndroid) {
      imagePickerImplementation.useAndroidPhotoPicker = true;
    }
    _prefs = await SharedPreferences.getInstance();
    currentLocale.value = _prefs.getString('currentLocale') ?? 'th';
    // FlutterNativeSplash.remove();
  }

  /// Change app language
  Future<void> changeLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    await _prefs.setString('currentLocale', value.languageCode);
  }

  /// Clear all app setting
  Future<void> clear() async {
    await _prefs.clear();
  }
}
