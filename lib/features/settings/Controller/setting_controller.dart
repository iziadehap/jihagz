import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  RxBool advancedEnabled = false.obs;
  RxBool alwaysAddPlaceVerified = false.obs;

  static const String advancedKey = 'advanced_enabled';
  static const String alwaysAddPlaceKey = 'always_add_place_verified';

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    advancedEnabled.value = prefs.getBool(advancedKey) ?? false;
    alwaysAddPlaceVerified.value = prefs.getBool(alwaysAddPlaceKey) ?? false;
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(advancedKey, advancedEnabled.value);
    await prefs.setBool(alwaysAddPlaceKey, alwaysAddPlaceVerified.value);
  }

  Future<bool> checkAndEnableAdvanced(String password) async {
    if (password == 'Password.jihagz.2006') {
      advancedEnabled.value = true;
      await saveSettings();
      return true;
    }
    return false;
  }

  void setAlwaysAddPlaceVerified(bool value) async {
    alwaysAddPlaceVerified.value = value;
    await saveSettings();
  }
}
