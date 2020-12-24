import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:wikipedia_search/core/logger.dart';
import 'package:wikipedia_search/core/router_constants.dart';
import 'package:wikipedia_search/core/services/http_service.dart';

class HomeViewModel extends BaseViewModel {
  final HttpService httpService;
  final NavigationService navigationService;

  Logger log;
  RssFeed _rssFeed;

  HomeViewModel({
    @required this.httpService,
    @required this.navigationService,
  }) {
    this.log = getLogger(this.runtimeType.toString());
  }

  RssFeed get rssFeed => this._rssFeed;
  set rssFeed(RssFeed value) {
    this._rssFeed = value;
    notifyListeners();
  }

  Future loadFeed() async {
    RssFeed feed;
    try {
      setBusy(true);
      feed = await httpService.getFeaturedFeed();
      setBusy(false);
    } on WikiException catch (error) {
      log.e('loadFeed: error: $error');
      return;
    } catch (error) {
      log.e('loadFeed: error: $error');
      return;
    }

    rssFeed = feed;
  }

  Future loadPage(String url, [String title]) async {
    log.i('loadUrl: $url');
    navigationService.navigateTo(pageViewRoute, arguments: [url, title]);
  }

  void showSearchView() {
    navigationService.navigateTo(searchViewRoute);
  }
}
