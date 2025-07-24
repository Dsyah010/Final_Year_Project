import 'package:flutter/material.dart';

class SepakTakrawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sepak Takraw Training App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Settings(),
    );
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Container
          Container(
            width: MediaQuery.of(context).size.width,
            height: 128,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main Settings Content
          Expanded(
            child: ListView(
              children: [
                // Profile Section with Reduced Padding
                SettingsSection(
                  title: 'Profile Settings',
                  padding: const EdgeInsets.only(top: 0.0), // Reduced padding
                  children: [
                    SettingsTile(
                      title: 'Profile Picture',
                      onTap: () {},
                    ),
                    SettingsTile(
                      title: 'Name',
                      onTap: () {},
                    ),
                    SettingsTile(
                      title: 'Email',
                      onTap: () {},
                    ),
                    SettingsTile(
                      title: 'Password',
                      onTap: () {},
                    ),
                  ],
                ),
                SettingsSection(
                  title: 'Training Preferences',
                  children: [
                    SettingsTile(
                      title: 'Skill Level',
                      onTap: () {},
                    ),
                    SettingsTile(
                      title: 'Training Focus',
                      onTap: () {},
                    ),
                    SettingsTile(
                      title: 'Notifications',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const SettingsSection({
    required this.title,
    required this.children,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0), // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
          Divider(),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}