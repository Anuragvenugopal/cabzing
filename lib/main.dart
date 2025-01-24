import 'package:cabzing/screens/home_page.dart';
import 'package:cabzing/screens/login_page.dart';
import 'package:cabzing/utils/contanst.dart';
import 'package:cabzing/utils/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Box? box;

Future<Box?> _openBox({required String boxName}) async {
  var dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  box = await Hive.openBox(
    boxName,
  );
  return box;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBox(boxName: Constants.BOX_NAME);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: AppHive().getIsUserLoggedIn()==true ? HomePage() : LoginPage(),
    );
  }
}
