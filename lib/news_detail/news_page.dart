import 'package:flutter/material.dart';
import 'package:new_z_tst/entity/models/news_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsModel newsModel;

  const NewsDetailPage({Key key, this.newsModel}) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: WebView(
        initialUrl: widget.newsModel.url,
      ),
    );
  }
}
