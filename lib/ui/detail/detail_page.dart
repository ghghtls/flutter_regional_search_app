import 'package:flutter/material.dart';
import 'package:flutter_regional_search_app/data/model/location.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final Location location;
  DetailPage(this.location, {super.key});
  String _sanitizeUrl(String url) {
    if (!url.startsWith('http')) {
      return 'https://$url';
    }
    return url;
  }

  // http 링크 여부 판별 함수
  bool isHttpLink(String? link) {
    if (link == null || link.trim().isEmpty) return false;
    return link.trim().toLowerCase().startsWith('http://');
  }

  @override
  Widget build(BuildContext context) {
    final url = location.link;
    if (url == null || url.trim().isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('잘못된 링크')),
        body: Center(child: Text('링크가 존재하지 않거나 열 수 없습니다.')),
      );
    }
    // HTTP 링크는 외부 브라우저로 열고, 이 화면은 자동 닫음
    if (isHttpLink(url)) {
      Future.microtask(() async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('외부 브라우저를 열 수 없습니다.')));
        }
        Navigator.pop(context); // 현재 화면 닫기
      });

      return Scaffold(
        appBar: AppBar(title: Text(location.title)),
        body: Center(child: Text('http 링크는 외부 브라우저로 열립니다')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(location.title)),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(_sanitizeUrl(url))),
        initialSettings: InAppWebViewSettings(
          userAgent:
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',
        ),
      ),
    );
  }
}
