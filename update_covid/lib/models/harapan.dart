import 'dart:convert';

List<Harapan> harapanFromJson(String str) => List<Harapan>.from(json.decode(str).map((x) => Harapan.fromJson(x)));

String harapanToJson(List<Harapan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Harapan {
    Harapan({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Harapan.fromJson(Map<String, dynamic> json) => Harapan(
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
        required this.message,
        required this.publishedDate,
        required this.like,
    });

    int author;
    String message;
    DateTime publishedDate;
    List<int> like;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        author: json["Author"],
        message: json["Message"],
        publishedDate: DateTime.parse(json["published_date"]),
        like: List<int>.from(json["like"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Author": author,
        "Message": message,
        "published_date": publishedDate.toIso8601String(),
        "like": List<dynamic>.from(like.map((x) => x)),
    };
}
