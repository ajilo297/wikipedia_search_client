import 'dart:convert';

class SearchResponseModel {
  SearchResponseModel({
    this.batchcomplete,
    this.searchResponseModelContinue,
    this.query,
  });

  final bool batchcomplete;
  final Continue searchResponseModelContinue;
  final Query query;

  SearchResponseModel copyWith({
    bool batchcomplete,
    Continue searchResponseModelContinue,
    Query query,
  }) =>
      SearchResponseModel(
        batchcomplete: batchcomplete ?? this.batchcomplete,
        searchResponseModelContinue:
            searchResponseModelContinue ?? this.searchResponseModelContinue,
        query: query ?? this.query,
      );

  factory SearchResponseModel.fromJson(String str) =>
      SearchResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchResponseModel.fromMap(Map<String, dynamic> json) =>
      SearchResponseModel(
        batchcomplete:
            json["batchcomplete"] == null ? null : json["batchcomplete"],
        searchResponseModelContinue: json["continue"] == null
            ? null
            : Continue.fromMap(json["continue"]),
        query: json["query"] == null ? null : Query.fromMap(json["query"]),
      );

  Map<String, dynamic> toMap() => {
        "batchcomplete": batchcomplete == null ? null : batchcomplete,
        "continue": searchResponseModelContinue == null
            ? null
            : searchResponseModelContinue.toMap(),
        "query": query == null ? null : query.toMap(),
      };
}

class Query {
  Query({
    this.pages,
  });

  final List<Page> pages;

  Query copyWith({
    List<Page> pages,
  }) =>
      Query(
        pages: pages ?? this.pages,
      );

  factory Query.fromJson(String str) => Query.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Query.fromMap(Map<String, dynamic> json) => Query(
        pages: json["pages"] == null
            ? null
            : List<Page>.from(json["pages"].map((x) => Page.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "pages": pages == null
            ? null
            : List<dynamic>.from(pages.map((x) => x.toMap())),
      };
}

class Page {
  Page({
    this.pageid,
    this.ns,
    this.title,
    this.index,
    this.thumbnail,
    this.terms,
  });

  final int pageid;
  final int ns;
  final String title;
  final int index;
  final Thumbnail thumbnail;
  final Terms terms;

  Page copyWith({
    int pageid,
    int ns,
    String title,
    int index,
    Thumbnail thumbnail,
    Terms terms,
  }) =>
      Page(
        pageid: pageid ?? this.pageid,
        ns: ns ?? this.ns,
        title: title ?? this.title,
        index: index ?? this.index,
        thumbnail: thumbnail ?? this.thumbnail,
        terms: terms ?? this.terms,
      );

  factory Page.fromJson(String str) => Page.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Page.fromMap(Map<String, dynamic> json) => Page(
        pageid: json["pageid"] == null ? null : json["pageid"],
        ns: json["ns"] == null ? null : json["ns"],
        title: json["title"] == null ? null : json["title"],
        index: json["index"] == null ? null : json["index"],
        thumbnail: json["thumbnail"] == null
            ? null
            : Thumbnail.fromMap(json["thumbnail"]),
        terms: json["terms"] == null ? null : Terms.fromMap(json["terms"]),
      );

  Map<String, dynamic> toMap() => {
        "pageid": pageid == null ? null : pageid,
        "ns": ns == null ? null : ns,
        "title": title == null ? null : title,
        "index": index == null ? null : index,
        "thumbnail": thumbnail == null ? null : thumbnail.toMap(),
        "terms": terms == null ? null : terms.toMap(),
      };
}

class Terms {
  Terms({
    this.description,
  });

  final List<String> description;

  Terms copyWith({
    List<String> description,
  }) =>
      Terms(
        description: description ?? this.description,
      );

  factory Terms.fromJson(String str) => Terms.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Terms.fromMap(Map<String, dynamic> json) => Terms(
        description: json["description"] == null
            ? null
            : List<String>.from(json["description"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "description": description == null
            ? null
            : List<dynamic>.from(description.map((x) => x)),
      };
}

class Thumbnail {
  Thumbnail({
    this.source,
    this.width,
    this.height,
  });

  final String source;
  final int width;
  final int height;

  Thumbnail copyWith({
    String source,
    int width,
    int height,
  }) =>
      Thumbnail(
        source: source ?? this.source,
        width: width ?? this.width,
        height: height ?? this.height,
      );

  factory Thumbnail.fromJson(String str) => Thumbnail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Thumbnail.fromMap(Map<String, dynamic> json) => Thumbnail(
        source: json["source"] == null ? null : json["source"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
      );

  Map<String, dynamic> toMap() => {
        "source": source == null ? null : source,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
      };
}

class Continue {
  Continue({
    this.gpsoffset,
    this.continueContinue,
  });

  final int gpsoffset;
  final String continueContinue;

  Continue copyWith({
    int gpsoffset,
    String continueContinue,
  }) =>
      Continue(
        gpsoffset: gpsoffset ?? this.gpsoffset,
        continueContinue: continueContinue ?? this.continueContinue,
      );

  factory Continue.fromJson(String str) => Continue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Continue.fromMap(Map<String, dynamic> json) => Continue(
        gpsoffset: json["gpsoffset"] == null ? null : json["gpsoffset"],
        continueContinue: json["continue"] == null ? null : json["continue"],
      );

  Map<String, dynamic> toMap() => {
        "gpsoffset": gpsoffset == null ? null : gpsoffset,
        "continue": continueContinue == null ? null : continueContinue,
      };
}
