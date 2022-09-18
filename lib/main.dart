import 'package:flutter/material.dart';
import 'package:work_options/config/theme.dart';
import 'package:work_options/config/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Work Options',
      theme: AppTheme.lightTheme,
      initialRoute: "/login",
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

