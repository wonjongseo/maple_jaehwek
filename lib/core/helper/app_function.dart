import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFunction {
  static void copy({required String text}) {
    Clipboard.setData(ClipboardData(text: text));
  }

  static void scrollGoTo(ScrollController scrollController) {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  static Future<void> openUrl(String? url) async {
    if (url == null || url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw '$urlを開くことができませんでした。';
    }
  }
}
