import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech/speech_screen.dart';
import 'package:speech/speech_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SpeechScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Voice Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
