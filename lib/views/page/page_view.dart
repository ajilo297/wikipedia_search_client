import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:stacked/stacked.dart';
import 'page_view_model.dart';

class PageView extends StatelessWidget {
  final String url;
  final String title;

  PageView({
    @required this.url,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PageViewModel>.reactive(
      builder: (BuildContext context, PageViewModel viewModel, Widget _) {
        return WebviewScaffold(
          appBar: AppBar(
            title: Text(title ?? 'Wikipedia'),
          ),
          url: url ?? 'about:blank',
          initialChild: Center(child: CircularProgressIndicator()),
        );
      },
      viewModelBuilder: () => PageViewModel(),
    );
  }
}
