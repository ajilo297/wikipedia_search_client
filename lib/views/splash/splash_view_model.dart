import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wikipedia_search/core/logger.dart';
import 'package:wikipedia_search/core/router_constants.dart';
import 'package:wikipedia_search/core/services/cachedService.dart';

class SplashViewModel extends FutureViewModel {
  final NavigationService navigationService;
  final CacheService cacheService;
  Logger log;

  SplashViewModel({
    @required this.navigationService,
    @required this.cacheService,
  }) {
    log = getLogger(this.runtimeType.toString());
  }

  @override
  Future futureToRun() async {
    await cacheService.initialize();
    navigationService.replaceWith(homeViewRoute);
  }
}
