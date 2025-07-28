import 'package:every_maple/core/enums/enums.dart';
import 'package:every_maple/core/helper/app_function.dart';
import 'package:every_maple/core/utility/utilities.dart';
import 'package:every_maple/feature/notices/controller/notice_controller.dart';
import 'package:every_maple/feature/notices/models/notice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeScreen extends GetView<NoticeController> {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      NoticeType.values.length,
                      (index) {
                        NoticeType noticeType = NoticeType.values[index];
                        bool isSelected =
                            controller.selectedNoticeType.value == noticeType;
                        return InkWell(
                          onTap: () => controller.changeNoticeType(noticeType),
                          child: Container(
                            width:
                                (size.width / (NoticeType.values.length + 1)),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: isSelected
                                    ? const BorderSide(
                                        color: Colors.pinkAccent,
                                        width: 3,
                                      )
                                    : const BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              noticeType.label,
                              style: isSelected
                                  ? const TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : null,
                            )),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.notices.length,
                      itemBuilder: (context, index) {
                        Notice notice = controller.notices[index];
                        return ListTile(
                          onTap: () => AppFunction.openUrl(notice.url),
                          title: Text(
                            notice.title,
                            style: const TextStyle(fontSize: 12),
                          ),
                          // trailing: Text(dateToYYYYMMDD(notice.date)),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
