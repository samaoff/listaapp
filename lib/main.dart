import 'package:flutter/material.dart';
import 'package:myapp/src/pages/home.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mi Lista App',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}