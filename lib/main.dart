import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rumour/core/modules/locator_config.dart';
import 'package:rumour/core/modules/module.dart';
import 'package:rumour/core/presentations/screens/splash_screen.dart';
import 'package:rumour/core/theme/theme_data.dart';
import 'package:rumour/core/utilities/navigation/app_router.dart';
import 'package:rumour/firebase_options.dart';

Future<void> main()async {
  sl.registerMany(modules);
   WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
       theme: AppTheme.darkTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.dark,
      onGenerateRoute: AppRouter().onGenerateRoute,
      
      home: const SplashScreen(),
    );
  }
}

