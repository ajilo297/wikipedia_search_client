import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:wikipedia_search/core/locator.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (viewModel) {
        viewModel.loadFeed();
      },
      builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
        print('Title: ${viewModel.rssFeed?.title}');
        return Scaffold(
          appBar: AppBar(
            title: Text('Wikipedia'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: viewModel.showSearchView,
              )
            ],
          ),
          body: viewModel.isBusy && viewModel.rssFeed == null
              ? Center(child: CircularProgressIndicator())
              : viewModel.rssFeed == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Could not load feed.'),
                          FlatButton.icon(
                            label: Text('Reload'),
                            icon: Icon(Icons.refresh),
                            textColor: Theme.of(context).accentColor,
                            onPressed: viewModel.loadFeed,
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        viewModel.loadFeed();
                      },
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          RssItem item =
                              viewModel.rssFeed.items.elementAt(index);
                          return buildFeedItem(context, item, viewModel);
                        },
                        itemCount: viewModel.rssFeed?.items?.length ?? 0,
                      ),
                    ),
        );
      },
      viewModelBuilder: () => HomeViewModel(
        httpService: locator(),
        navigationService: locator(),
        cacheService: locator(),
      ),
    );
  }

  Widget buildFeedItem(
    BuildContext context,
    RssItem item,
    HomeViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          viewModel.loadPage(item.link, 'Featured Article');
        },
        child: Material(
          elevation: 3,
          shadowColor: Theme.of(context).shadowColor.withAlpha(20),
          color: Theme.of(context).cardColor,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                HtmlWidget(
                  item.description,
                  onTapUrl: (uri) {
                    viewModel.loadPage('https://en.wikipedia.org$uri');
                  },
                  enableCaching: true,
                  hyperlinkColor: Theme.of(context).accentColor,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
