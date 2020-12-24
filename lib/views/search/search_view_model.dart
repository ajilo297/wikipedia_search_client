import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wikipedia_search/core/logger.dart';
import 'package:wikipedia_search/core/models/search_response_model.dart';
import 'package:wikipedia_search/core/router_constants.dart';
import 'package:wikipedia_search/core/services/http_service.dart';

class SearchViewModel extends BaseViewModel {
  final HttpService httpService;
  final NavigationService navigationService;

  Logger log;

  List<Page> _pageList = [];
  SearchResponseModel _searchResponseModel;

  String _queryString = '';

  SearchViewModel({
    @required this.httpService,
    @required this.navigationService,
  }) {
    this.log = getLogger(this.runtimeType.toString());
  }

  // SearchResponseModel get searchResponseModel => _searchResponseModel;
  set searchResponseModel(SearchResponseModel searchResponseModel) {
    _searchResponseModel = searchResponseModel;
    notifyListeners();
  }

  List<Page> get pageList => _pageList;
  set pageList(List<Page> pageList) {
    _pageList = pageList.toSet().toList();
    notifyListeners();
  }

  String get queryString => this._queryString;
  set queryString(String query) {
    this._queryString = query;
    notifyListeners();
  }

  Future search(String query, {int page}) async {
    log.i('search: $query');
    if (queryString != query) pageList = [];
    queryString = query;
    if (query.isEmpty) {
      searchResponseModel = null;
      return;
    }
    SearchResponseModel responseModel;
    try {
      setBusyForObject('search', true);
      responseModel = await httpService.search(query: query);
    } on WikiException catch (error) {
      log.e('search: error: ${error.message}');
      // TODO: Display error to user
      return;
    } catch (error) {
      log.e('search: unknown error has occurred: $error');
      // TODO: Display error to user
      return;
    } finally {
      setBusyForObject('search', false);
    }

    searchResponseModel = responseModel;

    pageList = _searchResponseModel.query.pages.map<Page>((entry) {
      return entry;
    }).toList();
  }

  Future loadMore() async {
    log.i('loadMore');
    if (queryString.isEmpty) {
      return;
    }
    SearchResponseModel responseModel;
    try {
      setBusyForObject('loadMore', true);
      responseModel = await httpService.search(
        query: queryString,
        offset: _searchResponseModel.searchResponseModelContinue.gpsoffset,
      );
    } on WikiException catch (error) {
      log.e('loadMore: error: ${error.message}');
      // TODO: Display error to user
      return;
    } catch (error) {
      log.e('loadMore: unknown error has occurred: $error');
      // TODO: Display error to user
      return;
    } finally {
      setBusyForObject('loadMore', false);
    }

    pageList = [...pageList, ...(responseModel.query?.pages ?? [])];
    searchResponseModel = responseModel;
  }

  void loadPage(Page page) {
    log.i('loadPage');
    navigationService.navigateTo(pageViewRoute, arguments: [
      page.fullurl,
      page.title,
    ]);
  }
}
