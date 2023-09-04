import 'dart:convert';
// To parse this JSON data, do

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String title;
  List<RowData> rows;

  Welcome({
    required this.title,
    required this.rows,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        title: json["title"],
        rows: List<RowData>.from(json["rows"].map((x) => RowData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class RowData {
  String? title;
  String? description;
  String? imageHref;

  RowData({
    required this.title,
    required this.description,
    required this.imageHref,
  });

  factory RowData.fromJson(Map<String, dynamic> json) => RowData(
        title: json["title"],
        description: json["description"],
        imageHref: json["imageHref"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "imageHref": imageHref,
      };
}

class Item {
  final String title;

  Item({required this.title});
}
