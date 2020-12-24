import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wikipedia_search/core/locator.dart';
import 'package:wikipedia_search/core/models/search_response_model.dart'
    as response;
import 'package:wikipedia_search/widgets/dumb_widgets/search_bar/search_bar_widget.dart';
import 'search_view_model.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  final SearchViewModel viewModel = SearchViewModel(
    httpService: locator(),
    navigationService: locator(),
    cacheService: locator(),
  );
  VoidCallback scrollListener;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    scrollListener = () {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        viewModel.loadMore();
      }
    };
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (BuildContext context, SearchViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: buildSearchBar(viewModel),
          ),
          body: Column(
            children: [
              if (viewModel.busy('search') ?? false)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                Expanded(
                  child: viewModel.pageList == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Could not load results.'),
                              FlatButton.icon(
                                label: Text('Reload'),
                                icon: Icon(Icons.refresh),
                                textColor: Theme.of(context).accentColor,
                                onPressed: () {
                                  return viewModel.search(
                                    viewModel.queryString,
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: viewModel.pageList.length,
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          itemBuilder: (context, index) {
                            response.Page page =
                                viewModel.pageList.elementAt(index);
                            return buildSearchResult(context, page);
                          },
                        ),
                ),
              AnimatedSize(
                vsync: this,
                curve: Curves.elasticOut,
                duration: Duration(milliseconds: 1000),
                child: Offstage(
                  offstage: !(viewModel.busy('loadMore') ?? false),
                  child: LinearProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => viewModel,
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

    return InkWell(
      onTap: () {
        viewModel.loadPage(page);
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            color: Theme.of(context).cardColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      page.title,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),
                    if (description != null)
                      Text(
                        '${description.substring(0, 1).toUpperCase()}${description.substring(1)}',
                        textAlign: TextAlign.justify,
                      ),
                  ],
                ),
              ),
              if (page.thumbnail?.source != null) SizedBox(width: 16),
              if (page.thumbnail?.source != null)
                CachedNetworkImage(
                  imageUrl: page.thumbnail.source,
                  imageBuilder: (context, provider) {
                    return Container(
                      padding: EdgeInsets.all(1),
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: Theme.of(context).accentColor,
                      ),
                      child: CircleAvatar(
                        backgroundImage: provider,
                        radius: 30,
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return CircleAvatar(
                      backgroundColor: Theme.of(context).disabledColor,
                      radius: 30,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.error,
                      size: 30,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
