import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:wikipedia_search/core/base/base_service.dart';

class CacheService extends BaseService {
  Box<Map<String, dynamic>> searchCacheBox;
  Box<String> feedCacheBox;

  Future initialize() async {
    log.i('initialize');
    List<Future<Box>> futureList = [
      Hive.openBox<Map<String, dynamic>>('cachedBox'),
      Hive.openBox<String>('feedBox')
    ];

    List<Box> boxList = await Future.wait(futureList);
    searchCacheBox = boxList.elementAt(0);
    feedCacheBox = boxList.elementAt(1);

    if (searchCacheBox == null) log.e('null searchCacheBox');
    if (feedCacheBox == null) log.e('null feedCacheBox');
  }

  void saveToCacheFor({
    @required String query,
    @required Map<String, dynamic> response,
  }) {
    log.i('saveToCacheFor: $query');
    searchCacheBox.put(query, response);
  }

  void saveToFeedCache(String feed) {
    log.i('saveToFeedCache');
    feedCacheBox.put('feed', feed);
  }

  RssFeed getFeedCache() {
    log.i('getFeedCache');
    String response = feedCacheBox?.get('feed');
    RssFeed feed;
    try {
      feed = RssFeed.parse(response);
    } catch (error) {
      log.e('getFeedCache: error: $error');
      return null;
    }
    return feed;
  }

  Map<String, dynamic> getFromCacheForQuery({@required String query}) {
    log.i('getFromCacheForQuery: $query');
    return searchCacheBox?.get(query);
  }
}
