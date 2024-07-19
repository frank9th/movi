import 'package:flutter/material.dart';
import 'package:movi/constants.dart';
import 'package:movi/screens/home_screen.dart';
import 'package:movi/screens/movie_provider.dart';
import 'package:movi/screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: MaterialApp(
        title: 'Movit',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: SplashScreen(),
      ),
    );
  }
}
