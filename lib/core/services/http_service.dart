import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';
import 'package:wikipedia_search/core/base/base_service.dart';
import 'package:wikipedia_search/core/constants.dart';
import 'package:wikipedia_search/core/models/search_response_model.dart';

class HttpService extends BaseService {
  final http.Client client = http.Client();

  Future<SearchResponseModel> search({
    @required String query,
    int offset = 0,
  }) async {
    log.i('search: $query');

    Map<String, String> params = {
      'action': 'query',
      'format': 'json',
      'prop': 'pageterms%7Cinfo%7Cpageimages',
      'generator': 'prefixsearch',
      'formatversion': '2',
      'wbptterms': 'alias%7Clabel%7Cdescription',
      'inprop': 'url',
      'inlinkcontext': 'Main%20Page',
      'piprop': 'thumbnail%7Cname%7Coriginal',
      'pithumbsize': '70',
      'gpssearch': '${query.replaceAll(' ', '+')}',
      'gpslimit': '20',
      'gpsoffset': '$offset',
      'uselang': 'en',
      'titles': 'London',
    };

    String paramsString = params.entries.fold('', (previousValue, element) {
      return previousValue += '&${element.key}=${element.value}';
    });

    String uri = '${Constants.WIKI_URL}?$paramsString';
    http.Response response;
    try {
      response = await client.get(uri);
    } catch (error) {
      log.e('search: error: $error');
      throw WikiException('Could not fetch data. Please try again later');
    }

    log.i('search: statusCode: ${response.statusCode}');

    SearchResponseModel responseModel = SearchResponseModel.fromJson(
      response.body,
    );

    return responseModel;
  }

  Future getFeaturedFeed() async {
    log.i('getFeaturedFeed');
    final Map<String, String> params = {
      'action': 'featuredfeed',
      'format': 'json',
      'feedformat': 'rss',
      'feed': 'featured',
    };

    String paramsString = params.entries.fold('', (previousValue, element) {
      return previousValue += '&${element.key}=${element.value}';
    });

    String uri = '${Constants.WIKI_URL}?$paramsString';
    http.Response response;
    try {
      response = await client.get(uri);
    } catch (error) {
      log.e('search: error: $error');
      throw WikiException('Could not fetch data. Please try again later');
    }

    log.i('getFeaturedFeed: statusCode: ${response.statusCode}');

    RssFeed feed;
    try {
      feed = RssFeed.parse(response.body);
    } on ArgumentError catch (error) {
      log.e('getFeaturedFeed: argumentError: $error');
      throw WikiException('Invalid data');
    } catch (error) {
      log.e('getFeaturedFeed: error: $error');
      throw WikiException('Could not fetch data. Please try again later');
    }
    return feed;
  }
}

class WikiException implements Exception {
  String message;

  WikiException(message);
}
