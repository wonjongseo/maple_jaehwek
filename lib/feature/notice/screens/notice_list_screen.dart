import 'dart:convert';

import 'package:every_maple/core/constants/api_url.dart';
import 'package:every_maple/core/network/dio_client.dart';
import 'package:every_maple/feature/notice/models/event_model.dart';
import 'package:every_maple/feature/notice/models/notice_model.dart';
import 'package:every_maple/feature/notice/screens/notice_detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeListScreen extends StatefulWidget {
  const NoticeListScreen({super.key});

  @override
  State<NoticeListScreen> createState() => _NoticeListScreenState();
}

class _NoticeListScreenState extends State<NoticeListScreen> {
  List<NoticeModel>? notices;
  @override
  void initState() {
    super.initState();
    getNotices();
  }

  getNotices() async {
    final response = await Get.find<DioClient>().get(ApiUrl.getNotices);
    List<NoticeModel> tempNotice = [];
    for (int i = 0; i < response.data['notice'].length; i++) {
      NoticeModel notice = NoticeModel.fromJson(response.data['notice'][i]);
      tempNotice.add(notice);
    }

    notices = tempNotice;

    setState(() {});
  }

  getEvents() async {
    final response = await Get.find<DioClient>().get(ApiUrl.getEvnets);
    List<NoticeModel> tempNotice = [];
    for (int i = 0; i < response.data['event_notice'].length; i++) {
      NoticeModel notice =
          EventModel.fromJson(response.data['event_notice'][i]);
      tempNotice.add(notice);
    }

    notices = tempNotice;

    setState(() {});
  }

  goToNoticeDetailScreen(String url) async {
    Get.to(() => NoticeDetailScreen(url: url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notices'),
      ),
      body: SafeArea(
        child: Center(
          child: notices == null
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: notices!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => goToNoticeDetailScreen(notices![index].url!),
                      child: Card(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notices![index].title!),
                              Text(notices![index].date!),
                              if (notices![index] is EventModel) ...[
                                Text(
                                  (notices![index] as EventModel).dateEventEnd!,
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
