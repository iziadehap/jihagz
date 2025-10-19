import 'package:flutter/material.dart';
import 'package:jihagz/core/appRoutes.dart';
import 'package:jihagz/features/settings/Controller/setting_controller.dart';
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
