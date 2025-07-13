import 'package:every_maple/core/network/dio_client.dart';
import 'package:every_maple/feature/home/screens/home_screen.dart';
import 'package:every_maple/feature/main/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
      initialBinding: InitBinding(),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DioClient());
  }
}
