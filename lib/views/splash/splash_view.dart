import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wikipedia_search/core/locator.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (BuildContext context, SplashViewModel viewModel, Widget _) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/wiki-image.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Wikipedia',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(
        navigationService: locator(),
        cacheService: locator(),
      ),
    );
  }
}
