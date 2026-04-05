import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.white, // هماهنگی رنگ بدنه
      ),
      home: const KhanoumiStyleLauncher(),
    );
  }
}

class KhanoumiStyleLauncher extends StatefulWidget {
  const KhanoumiStyleLauncher({super.key});

  @override
  State<KhanoumiStyleLauncher> createState() => _KhanoumiStyleLauncherState();
}

class _KhanoumiStyleLauncherState extends State<KhanoumiStyleLauncher> {
  @override
  void initState() {
    super.initState();
    // فراخوانی مرورگر بلافاصله بعد از ساخته شدن فریم اول
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchInAppBrowser();
    });
  }

  Future<void> _launchInAppBrowser() async {
    final Uri url = Uri.parse('https://www.khanoumi.com/');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          // باز شدن به سبک In-App Browser (مشابه عکس ارسالی)
          mode: LaunchMode.inAppBrowserView,
          browserConfiguration: const BrowserConfiguration(showTitle: true),
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // صفحه کاملاً خالی و سفید برای حذف لودینگ
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(),
    );
  }
}
