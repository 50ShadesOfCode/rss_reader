import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  final String url;

  const NewsPage({Key? key, required this.url}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Новости АльфаБанк"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => {},
                child: const Icon(
                  CupertinoIcons.arrow_down_to_line,
                  size: 26.0,
                ),
              ),
            )
          ],
        ),
        body: WebView(
          initialUrl: widget.url,
        ),
      ),
    );
  }
}
