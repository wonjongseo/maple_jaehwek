import 'package:every_maple/core/network/dio_client.dart';
import 'package:every_maple/feature/main/screen/main_screen.dart';
import 'package:every_maple/feature/notices/controller/notice_controller.dart';
import 'package:every_maple/feature/notices/repository/notice_repository.dart';
import 'package:every_maple/feature/record/controllers/record_controller.dart';
import 'package:every_maple/feature/record/models/record_model.dart';
import 'package:every_maple/feature/record/repositories/record_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecordModelAdapter());
  await Hive.openBox<RecordModel>('records'); // Box 이름 자유롭게
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: const MainScreen(),
      locale: Locale(Get.deviceLocale.toString()),
      initialBinding: InitBinding(),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(DioClient());
    Get.lazyPut(() => NoticeRepository(Get.find()));

    Get.lazyPut(() => NoticeController(Get.find()));
    Get.lazyPut(() => RecordRepository(Hive.box<RecordModel>('records')));
    Get.lazyPut(() => RecordController(Get.find()));

    // ② RecordRepository를 putAsync로 등록하면서
    //    완료 시점에 Controller도 함께 주입
    // Get.putAsync<RecordRepository>(() async {
    //   final box = await Hive.openBox<RecordModel>('records');
    //   final repo = RecordRepository(box);

    //   // repo가 준비된 '지금 이 순간'에 Controller 주입
    //   Get.put(RecordController(repo), permanent: true);
    //   return repo;
    // });
  }
}
// flutter pub run build_runner build --delete-conflicting-outputs
