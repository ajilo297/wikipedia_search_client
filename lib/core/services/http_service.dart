import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wikipedia_search/core/base/base_service.dart';
import 'package:wikipedia_search/core/constants.dart';
import 'package:wikipedia_search/core/models/search_response_model.dart';

class HttpService extends BaseService {
  final http.Client client = http.Client();

  Future<SearchResponseModel> search({@required String query}) async {
    log.i('search: $query');

    Map<String, String> params = {
      'action': 'query',
      'format': 'json',
      'prop': 'pageimages|pageterms',
      'generator': 'prefixsearch',
      'redirects': '1',
      'formatversion': '2',
      'piprop': 'thumbnail',
      'pithumbsize': '200',
      'pilimit': '10',
      'wbptterms': 'description',
      'gpssearch': '${query.replaceAll(' ', '+')}',
      'gpslimit': '10',
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
