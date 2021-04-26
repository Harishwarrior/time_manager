import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_manager/utils/theme/theme.dart';
import 'package:time_manager/utils/theme/theme_notifier.dart';

void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
  (value)
      ? themeNotifier.setTheme(darkTheme)
      : themeNotifier.setTheme(lightTheme);
  var prefs = await SharedPreferences.getInstance();
  await prefs.setBool('darkMode', value);
}
