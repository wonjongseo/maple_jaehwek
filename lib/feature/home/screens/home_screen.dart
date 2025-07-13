import 'package:every_maple/feature/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // authController.fetchUserByCharName(charName: '코마후쿠');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (controller) {
        return SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  authController.fetchCharDetailByUid();
                },
                child: Text('캐릭 디테일'),
              ),
              if (controller.charModel != null)
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 1, color: const Color(0xFFB4570)),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0x0ffb8da0),
                        Color(0x0ffb4570),
                      ],
                    ),
                  ),
                  child: Image.network(
                    controller!.charModel!.characterImage!,
                    fit: BoxFit.fill,
                  ),
                ),
              // Image(
              //   image: CachedNetworkImageProvider(
              //       controller.charModel!.characterImage!),
              // ),
            ],
          ),
        ));
      }),
    );
  }
}
