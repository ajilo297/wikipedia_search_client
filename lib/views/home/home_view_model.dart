import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:wikipedia_search/core/logger.dart';
import 'package:wikipedia_search/core/router_constants.dart';
import 'package:wikipedia_search/core/services/cachedService.dart';
import 'package:wikipedia_search/core/services/http_service.dart';

class HomeViewModel extends BaseViewModel {
  final HttpService httpService;
  final CacheService cacheService;
  final NavigationService navigationService;

  Logger log;
  RssFeed _rssFeed;

  HomeViewModel({
    @required this.cacheService,
    @required this.httpService,
    @required this.navigationService,
  }) {
    this.log = getLogger(this.runtimeType.toString());
  }

  RssFeed get rssFeed => this._rssFeed;
  set rssFeed(RssFeed value) {
    this._rssFeed = value;
    print('setting rssFeed: $_rssFeed');
    notifyListeners();
  }

  Future loadFeed() async {
    RssFeed feed;
    try {
      setBusy(true);
      feed = await httpService.getFeaturedFeed();
    } on SocketException {
      loadFromCache();
      return;
    } on WikiException catch (error) {
      log.e('loadFeed: error: $error');
      return;
    } catch (error) {
      log.e('loadFeed: error: $error');
      return;
    } finally {
      setBusy(false);
    }

    rssFeed = feed;
  }

  Future loadPage(String url, [String title]) async {
    log.i('loadUrl: $url');
    navigationService.navigateTo(pageViewRoute, arguments: [url, title]);
  }

  void loadFromCache() {
    log.i('loadFromCache');
    RssFeed feed = cacheService.getFeedCache();
    rssFeed = feed;
  }

  void showSearchView() {
    navigationService.navigateTo(searchViewRoute);
  }
}
