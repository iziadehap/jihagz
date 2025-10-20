import 'package:flutter/material.dart';
import 'package:jihagz/core/appRoutes.dart';
import 'package:jihagz/features/settings/data/data_source/setting_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/appCore.dart';

const supabaseUrl = 'https://paejvnjgxbfbbtofyslr.supabase.co';
const supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBhZWp2bmpneGJmYmJ0b2Z5c2xyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA3ODk3MjQsImV4cCI6MjA2NjM2NTcyNH0.tRswptP0-W1Sfeo0flebkTjAz7zUDBYvdgPe8IidF6Y';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  Get.put(SettingController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AppCore appCore = AppCore();

    return GetMaterialApp(
      title: 'Jihagz',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
          seedColor: appCore.primaryColor,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: appCore.backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: appCore.surfaceColor,
          foregroundColor: appCore.primaryColor,
        ),
      ),
      initialRoute: _checkIfUserIsLoggedIn() ? AppRoutes.HOME : AppRoutes.LOGIN,
      getPages: getPages,
    );
  }

  bool _checkIfUserIsLoggedIn() {
    final user = Supabase.instance.client.auth.currentUser;
    return user != null;
  }
}
