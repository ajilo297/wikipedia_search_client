import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wikipedia_search/core/locator.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Wikipedia Search'),
          ),
          body: Center(),
        );
      },
      viewModelBuilder: () => HomeViewModel(
        httpService: locator(),
        navigationService: locator(),
      ),
    );
  }
}
