import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade200,
        colorScheme: .fromSeed(seedColor: Colors.purpleAccent),
        fontFamily: 'Lato',
        textTheme: AppTypography.textTheme,
      ),
      routerConfig: AppRouter.router,
      // home: HomeScreen(),
    );
  }
}
