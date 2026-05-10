import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. إضافة الـ Import
import 'theme_provider.dart'; // 2. استيراد الملف الجديد
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/themes_screen.dart';

void main() {
  runApp(
    // 3. تغليف التطبيق بالكامل بالـ Provider
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const DailyKnowledgeApp(),
    ),
  );
}

class DailyKnowledgeApp extends StatelessWidget {
  const DailyKnowledgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Knowledge App',
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/themes': (context) => const ThemesScreen(),
      },
    );
  }
}
