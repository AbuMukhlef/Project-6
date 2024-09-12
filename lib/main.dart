import 'package:flutter/material.dart';
import 'package:tickets_app/screens/splash_screen.dart';
import 'package:tickets_app/services/di_container.dart';
//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIContainer.setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
