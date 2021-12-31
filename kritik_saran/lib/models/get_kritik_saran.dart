// To parse this JSON data, do
//
//     final getKritikSaran = getKritikSaranFromJson(jsonString);

import 'dart:convert';

List<GetKritikSaran> getKritikSaranFromJson(String str) =>
    List<GetKritikSaran>.from(
        json.decode(str).map((x) => GetKritikSaran.fromJson(x)));

String getKritikSaranToJson(List<GetKritikSaran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetKritikSaran {
  GetKritikSaran({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory GetKritikSaran.fromJson(Map<String, dynamic> json) => GetKritikSaran(
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
    required this.nama,
    required this.kritikSaran,
    required this.waktuPost,
  });

  String nama;
  String kritikSaran;
  String waktuPost;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        nama: json["nama"],
        kritikSaran: json["kritik_saran"],
        waktuPost: json["waktu_post"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "kritik_saran": kritikSaran,
        "waktu_post": waktuPost,
      };
}
