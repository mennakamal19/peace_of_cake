import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Setting extends StatefulWidget {

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    //final theme = Provider.of<ThemeCtl>(context, listen: false);
    return Scaffold(
      //backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color:Colors.black,size: 18,), onPressed: () { Navigator.pop(context); },),
        title: Text('Setting',style: TextStyle(color: Colors.black),),
        titleSpacing: 0,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: Text('Common'),
              tiles: [
                SettingsTile(
                  title: Text('Language'),
                  value: Text('English'),
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: Text('Dark mode'),
                  leading: Icon(Icons.dark_mode_rounded),
                  initialValue: false,
                  onToggle: (bool value) {

                  },
                ),
              ],
            ),
            SettingsSection(
              title: Text('Account'),
              tiles: [
                SettingsTile(
                  title: Text('phone number'),
                  leading: Icon(Icons.phone),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: Text('Email'),
                  leading: Icon(Icons.email),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: Text('Change password'),
                  leading: Icon(Icons.lock_outline_rounded),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: Text('Sign out'),
                  leading: Icon(Icons.logout),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
            SettingsSection(
              title: Text('Misc'),
              tiles: [
                SettingsTile(
                  title: Text('Terms of Service'),
                  leading: Icon(Icons.sticky_note_2_outlined),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
          ],
        ),
      ) ,
    );
  }
}
