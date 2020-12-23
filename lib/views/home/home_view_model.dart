import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wikipedia_search/core/logger.dart';
import 'package:wikipedia_search/core/router_constants.dart';
import 'package:wikipedia_search/core/services/http_service.dart';

class HomeViewModel extends BaseViewModel {
  final HttpService httpService;
  final NavigationService navigationService;

  Logger log;

  HomeViewModel({
    @required this.httpService,
    @required this.navigationService,
  }) {
    this.log = getLogger(this.runtimeType.toString());
  }

  void showSearchView() {
    navigationService.navigateTo(searchViewRoute);
  }
}
