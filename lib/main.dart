import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gsm_pos/view/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:window_size/window_size.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.openBox('storeinfo');
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('GSM DOCTOR');
    setWindowMinSize(const Size(700, 500));
    setWindowMaxSize(Size.infinite);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gsm Doctor',
      theme: ThemeData.dark().copyWith(),
      home: HomeScreen(),
    );
  }
}
