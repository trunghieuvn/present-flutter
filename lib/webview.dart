import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:present_flutter/loading.dart';

class WebViewClient extends StatelessWidget {
  final String linkHTML;

  const WebViewClient({Key key, this.linkHTML}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(title: Text('WebView IOS'),),
      url: linkHTML,
      withZoom: false,
      initialChild: Loading(),
    );
  }
}
