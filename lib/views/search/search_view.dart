import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wikipedia_search/core/locator.dart';
import 'package:wikipedia_search/core/models/search_response_model.dart'
    as response;
import 'package:wikipedia_search/widgets/dumb_widgets/search_bar/search_bar_widget.dart';
import 'search_view_model.dart';

class SearchView extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (BuildContext context, SearchViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: buildSearchBar(viewModel),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: viewModel.itemCount,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            itemBuilder: (context, index) {
              response.Page page =
                  viewModel.searchResponseModel.query.pages.elementAt(index);
              return buildSearchResult(context, page);
            },
          ),
        );
      },
      viewModelBuilder: () => SearchViewModel(
        httpService: locator(),
        navigationService: locator(),
      ),
    );
  }

  Widget buildSearchBar(SearchViewModel viewModel) {
    return Builder(builder: (context) {
      return SearchBarWidget(
        onChanged: (searchString) {
          viewModel.search(searchString);
        },
      );
    });
  }

  Widget buildSearchResult(BuildContext context, response.Page page) {
    String description;

    if (page.terms?.description != null && page.terms.description.isNotEmpty) {
      description = page.terms.description.fold<String>(null, (value, element) {
        return '${value ?? ''}${value == null ? '' : '\n'}$element';
      });
    }

    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2),
            color: Theme.of(context).shadowColor.withAlpha(10),
          )
        ],
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            page.title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (page.thumbnail?.source != null)
                CachedNetworkImage(
                  imageUrl: page.thumbnail.source,
                  imageBuilder: (context, provider) {
                    return CircleAvatar(
                      backgroundImage: provider,
                      radius: 30,
                    );
                  },
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              if (page.thumbnail?.source != null) SizedBox(width: 16),
              if (description != null)
                Expanded(
                  child: Text(description),
                )
            ],
          ),
        ],
      ),
    );
  }
}
