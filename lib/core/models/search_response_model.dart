// To parse this JSON data, do
//
//     final searchResponseModel = searchResponseModelFromMap(jsonString);

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
            searchResponseModelContinue: searchResponseModelContinue ?? this.searchResponseModelContinue,
            query: query ?? this.query,
        );

    factory SearchResponseModel.fromJson(String str) => SearchResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchResponseModel.fromMap(Map<String, dynamic> json) => SearchResponseModel(
        batchcomplete: json["batchcomplete"] == null ? null : json["batchcomplete"],
        searchResponseModelContinue: json["continue"] == null ? null : Continue.fromMap(json["continue"]),
        query: json["query"] == null ? null : Query.fromMap(json["query"]),
    );

    Map<String, dynamic> toMap() => {
        "batchcomplete": batchcomplete == null ? null : batchcomplete,
        "continue": searchResponseModelContinue == null ? null : searchResponseModelContinue.toMap(),
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
        pages: json["pages"] == null ? null : List<Page>.from(json["pages"].map((x) => Page.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "pages": pages == null ? null : List<dynamic>.from(pages.map((x) => x.toMap())),
    };
}

class Page {
    Page({
        this.pageid,
        this.ns,
        this.title,
        this.index,
        this.terms,
        this.contentmodel,
        this.pagelanguage,
        this.pagelanguagehtmlcode,
        this.pagelanguagedir,
        this.touched,
        this.lastrevid,
        this.length,
        this.fullurl,
        this.editurl,
        this.canonicalurl,
        this.thumbnail,
        this.original,
        this.pageimage,
    });

    final int pageid;
    final int ns;
    final String title;
    final int index;
    final Terms terms;
    final Contentmodel contentmodel;
    final Pagelanguage pagelanguage;
    final Pagelanguage pagelanguagehtmlcode;
    final Pagelanguagedir pagelanguagedir;
    final DateTime touched;
    final int lastrevid;
    final int length;
    final String fullurl;
    final String editurl;
    final String canonicalurl;
    final Original thumbnail;
    final Original original;
    final String pageimage;

    Page copyWith({
        int pageid,
        int ns,
        String title,
        int index,
        Terms terms,
        Contentmodel contentmodel,
        Pagelanguage pagelanguage,
        Pagelanguage pagelanguagehtmlcode,
        Pagelanguagedir pagelanguagedir,
        DateTime touched,
        int lastrevid,
        int length,
        String fullurl,
        String editurl,
        String canonicalurl,
        Original thumbnail,
        Original original,
        String pageimage,
    }) => 
        Page(
            pageid: pageid ?? this.pageid,
            ns: ns ?? this.ns,
            title: title ?? this.title,
            index: index ?? this.index,
            terms: terms ?? this.terms,
            contentmodel: contentmodel ?? this.contentmodel,
            pagelanguage: pagelanguage ?? this.pagelanguage,
            pagelanguagehtmlcode: pagelanguagehtmlcode ?? this.pagelanguagehtmlcode,
            pagelanguagedir: pagelanguagedir ?? this.pagelanguagedir,
            touched: touched ?? this.touched,
            lastrevid: lastrevid ?? this.lastrevid,
            length: length ?? this.length,
            fullurl: fullurl ?? this.fullurl,
            editurl: editurl ?? this.editurl,
            canonicalurl: canonicalurl ?? this.canonicalurl,
            thumbnail: thumbnail ?? this.thumbnail,
            original: original ?? this.original,
            pageimage: pageimage ?? this.pageimage,
        );

    factory Page.fromJson(String str) => Page.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Page.fromMap(Map<String, dynamic> json) => Page(
        pageid: json["pageid"] == null ? null : json["pageid"],
        ns: json["ns"] == null ? null : json["ns"],
        title: json["title"] == null ? null : json["title"],
        index: json["index"] == null ? null : json["index"],
        terms: json["terms"] == null ? null : Terms.fromMap(json["terms"]),
        contentmodel: json["contentmodel"] == null ? null : contentmodelValues.map[json["contentmodel"]],
        pagelanguage: json["pagelanguage"] == null ? null : pagelanguageValues.map[json["pagelanguage"]],
        pagelanguagehtmlcode: json["pagelanguagehtmlcode"] == null ? null : pagelanguageValues.map[json["pagelanguagehtmlcode"]],
        pagelanguagedir: json["pagelanguagedir"] == null ? null : pagelanguagedirValues.map[json["pagelanguagedir"]],
        touched: json["touched"] == null ? null : DateTime.parse(json["touched"]),
        lastrevid: json["lastrevid"] == null ? null : json["lastrevid"],
        length: json["length"] == null ? null : json["length"],
        fullurl: json["fullurl"] == null ? null : json["fullurl"],
        editurl: json["editurl"] == null ? null : json["editurl"],
        canonicalurl: json["canonicalurl"] == null ? null : json["canonicalurl"],
        thumbnail: json["thumbnail"] == null ? null : Original.fromMap(json["thumbnail"]),
        original: json["original"] == null ? null : Original.fromMap(json["original"]),
        pageimage: json["pageimage"] == null ? null : json["pageimage"],
    );

    Map<String, dynamic> toMap() => {
        "pageid": pageid == null ? null : pageid,
        "ns": ns == null ? null : ns,
        "title": title == null ? null : title,
        "index": index == null ? null : index,
        "terms": terms == null ? null : terms.toMap(),
        "contentmodel": contentmodel == null ? null : contentmodelValues.reverse[contentmodel],
        "pagelanguage": pagelanguage == null ? null : pagelanguageValues.reverse[pagelanguage],
        "pagelanguagehtmlcode": pagelanguagehtmlcode == null ? null : pagelanguageValues.reverse[pagelanguagehtmlcode],
        "pagelanguagedir": pagelanguagedir == null ? null : pagelanguagedirValues.reverse[pagelanguagedir],
        "touched": touched == null ? null : touched.toIso8601String(),
        "lastrevid": lastrevid == null ? null : lastrevid,
        "length": length == null ? null : length,
        "fullurl": fullurl == null ? null : fullurl,
        "editurl": editurl == null ? null : editurl,
        "canonicalurl": canonicalurl == null ? null : canonicalurl,
        "thumbnail": thumbnail == null ? null : thumbnail.toMap(),
        "original": original == null ? null : original.toMap(),
        "pageimage": pageimage == null ? null : pageimage,
    };
}

enum Contentmodel { WIKITEXT }

final contentmodelValues = EnumValues({
    "wikitext": Contentmodel.WIKITEXT
});

class Original {
    Original({
        this.source,
        this.width,
        this.height,
    });

    final String source;
    final int width;
    final int height;

    Original copyWith({
        String source,
        int width,
        int height,
    }) => 
        Original(
            source: source ?? this.source,
            width: width ?? this.width,
            height: height ?? this.height,
        );

    factory Original.fromJson(String str) => Original.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Original.fromMap(Map<String, dynamic> json) => Original(
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

enum Pagelanguage { EN }

final pagelanguageValues = EnumValues({
    "en": Pagelanguage.EN
});

enum Pagelanguagedir { LTR }

final pagelanguagedirValues = EnumValues({
    "ltr": Pagelanguagedir.LTR
});

class Terms {
    Terms({
        this.alias,
        this.label,
        this.description,
    });

    final List<String> alias;
    final List<String> label;
    final List<String> description;

    Terms copyWith({
        List<String> alias,
        List<String> label,
        List<String> description,
    }) => 
        Terms(
            alias: alias ?? this.alias,
            label: label ?? this.label,
            description: description ?? this.description,
        );

    factory Terms.fromJson(String str) => Terms.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Terms.fromMap(Map<String, dynamic> json) => Terms(
        alias: json["alias"] == null ? null : List<String>.from(json["alias"].map((x) => x)),
        label: json["label"] == null ? null : List<String>.from(json["label"].map((x) => x)),
        description: json["description"] == null ? null : List<String>.from(json["description"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "alias": alias == null ? null : List<dynamic>.from(alias.map((x) => x)),
        "label": label == null ? null : List<dynamic>.from(label.map((x) => x)),
        "description": description == null ? null : List<dynamic>.from(description.map((x) => x)),
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

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
