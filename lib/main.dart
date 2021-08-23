import 'package:flutter/material.dart';
import 'package:pandora/theme.dart';
import '../screen/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Pandora Chat App',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      home:  const HomeScreen(),
    );
  }
}

