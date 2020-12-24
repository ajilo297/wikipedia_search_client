import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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
      throw Exception('Could not fetch data. Please try again later');
    }

    log.i('response: ${response.body}');

    SearchResponseModel responseModel = SearchResponseModel.fromJson(
      response.body,
    );

    return responseModel;
  }
}

class WikiException implements Exception {
  String message;

  WikiException(message);
}
