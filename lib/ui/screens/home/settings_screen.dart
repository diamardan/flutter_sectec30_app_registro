import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  // SettingsScreen({Key key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool useNotificationDotOnAppIcon = true;

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      platform: DevicePlatform.android,
      sections: [
        SettingsSection(
          title: Text('Biometricos'),
          tiles: [
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (_) {},
              title: Text('Firma'),
              leading: Icon(Icons.draw),
            ),
            SettingsTile.switchTile(
              enabled: false,
              initialValue: false,
              onToggle: (value) {
                setState(() {
                  useNotificationDotOnAppIcon = value;
                });
              },
              title: Text('Reconocimiento facial'),
              leading: Icon(Icons.face_outlined),
              description: Text('No disponible en el dispositivo'),
            ),
            SettingsTile.switchTile(
              initialValue: true,
              leading: Icon(Icons.fingerprint),
              onToggle: (_) {},
              title: Text('Huella'),
            ),
            SettingsTile.switchTile(
              initialValue: true,
              leading: Icon(Icons.record_voice_over),
              onToggle: (_) {},
              title: Text('Reconocimiento de voz'),
            ),
          ],
        ),
      ],
    );
  }
}
