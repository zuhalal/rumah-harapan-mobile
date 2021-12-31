import 'dart:convert';

List<GetArtikel> getKritikSaranFromJson(String str) =>
    List<GetArtikel>.from(
        json.decode(str).map((x) => GetArtikel.fromJson(x)));

String getKritikSaranToJson(List<GetArtikel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetArtikel {
  GetArtikel({
    required this.model,
    required this.fields,
    required this.pk,
  });

  String model;
  Fields fields;
  int pk;

  factory GetArtikel.fromJson(Map<String, dynamic> json) => GetArtikel(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  Fields({
    required this.author,
    required this.title,
    required this.body,
    required this.date,
  });

  String author;
  String title;
  String body;
  String date;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    author: json["author"],
    title: json["title"],
    body: json["body"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "title": title,
    "body": body,
    "date": date,
  };
}