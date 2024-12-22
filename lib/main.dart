import 'package:fampay/Hive_Boxes/HiveBoxes.dart';
import 'package:fampay/global/constants.dart';
import 'package:fampay/models/DeltedItems.dart';
import 'package:fampay/screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveBoxes.initHive();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        scrollBehavior: CupertinoScrollBehavior(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: AppBarTheme().copyWith(backgroundColor: Colors.white),
          scaffoldBackgroundColor: Constants.hexToColorWithAlpha("#F7F6F3"),
          useMaterial3: true,
        ),
        home: HomeScreen());
  }
}
