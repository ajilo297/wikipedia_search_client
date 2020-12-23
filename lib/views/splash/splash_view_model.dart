import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wikipedia_search/core/logger.dart';
import 'package:wikipedia_search/core/router_constants.dart';

class SplashViewModel extends FutureViewModel {
  final NavigationService navigationService;
  Logger log;

  SplashViewModel({@required this.navigationService}) {
    log = getLogger(this.runtimeType.toString());
  }

  @override
  Future futureToRun() async {
    await Future.delayed(Duration(seconds: 2));
    navigationService.replaceWith(homeViewRoute);
  }
}
