import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../bindings/controller.dart';
import '../view/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    return GetMaterialApp(
        initialBinding: ControllerBindings(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          hintColor: Colors.grey,

            progressIndicatorTheme:
                ProgressIndicatorThemeData(color: Colors.black),
            fontFamily: 'font',
            iconTheme: const IconThemeData(color: Colors.black),
            appBarTheme: const AppBarTheme(
                color: Colors.white,
                titleTextStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.black, size: 22)),
            scaffoldBackgroundColor: const Color(0xffffffff),
            textTheme:
                Theme.of(context).textTheme.apply(bodyColor: Colors.black)),
        darkTheme: ThemeData(
          hintColor: Colors.grey,
          
            progressIndicatorTheme:
                ProgressIndicatorThemeData(color: Colors.white),
            fontFamily: 'font',
            iconTheme: const IconThemeData(color: Colors.white),
            appBarTheme: const AppBarTheme(color: Colors.black),
            scaffoldBackgroundColor: const Color(0x00000000),
            textTheme:
                Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
        home: Container(
            color: brightness == Brightness.light ? Colors.white : Colors.black,
            child: SafeArea(child: Home())));
  }
}
