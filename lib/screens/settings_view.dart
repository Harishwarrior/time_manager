import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:time_manager/utils/theme/theme.dart';
import 'package:time_manager/utils/theme/theme_notifier.dart';
import 'package:time_manager/utils/theme/theme_shared_pref.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.brush_outlined),
            title: Text('Theme'),
            contentPadding: const EdgeInsets.all(16.0),
            trailing: DayNightSwitcher(
              isDarkModeEnabled: _darkTheme,
              onStateChanged: (val) {
                setState(() {
                  _darkTheme = val;
                });
                onThemeChanged(val, themeNotifier);
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Nothing to see here')));
            },
          ),
        ],
      ),
    );
  }
}
