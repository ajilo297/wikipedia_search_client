import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wikipedia_search/core/logger.dart';
import 'package:wikipedia_search/core/models/search_response_model.dart';
import 'package:wikipedia_search/core/services/http_service.dart';

class SearchViewModel extends BaseViewModel {
  final HttpService httpService;
  final NavigationService navigationService;

  Logger log;

  SearchResponseModel _searchResponseModel;

  SearchViewModel({
    @required this.httpService,
    @required this.navigationService,
  }) {
    this.log = getLogger(this.runtimeType.toString());
  }

  SearchResponseModel get searchResponseModel => _searchResponseModel;
  set searchResponseModel(SearchResponseModel searchResponseModel) {
    _searchResponseModel = searchResponseModel;
    notifyListeners();
  }

  int get itemCount {
    if (searchResponseModel == null) return 0;
    if (searchResponseModel.query == null) return 0;
    if (searchResponseModel.query.pages == null) return 0;
    return searchResponseModel.query.pages.length;
  }

  Future search(String query) async {
    log.i('search: $query');
    if (query.isEmpty) {
      searchResponseModel = null;
      return;
    }
    SearchResponseModel responseModel;
    try {
      responseModel = await httpService.search(query: query);
    } on WikiException catch (error) {
      log.e('search: error: ${error.message}');
      // TODO: Display error to user
      return;
    } catch (error) {
      log.e('search: unknown error has occurred: $error');
      // TODO: Display error to user
      return;
    }

    searchResponseModel = responseModel;
  }
}
