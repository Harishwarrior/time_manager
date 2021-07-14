import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
            leading: Icon(EvaIcons.brushOutline),
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
            leading: Icon(EvaIcons.infoOutline),
            title: Text('About'),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: Theme.of(context).backgroundColor,
                  title: Text('About'),
                  content: Text('Time manager is a hobby project created by Harish Anbalagan'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('okay'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
