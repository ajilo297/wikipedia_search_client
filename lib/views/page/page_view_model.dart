import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:wikipedia_search/core/logger.dart';

class PageViewModel extends BaseViewModel {
  Logger log;

  PageViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
