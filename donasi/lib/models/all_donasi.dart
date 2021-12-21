// To parse this JSON data, do
//
//     final allDonasi = allDonasiFromJson(jsonString);

import 'dart:convert';

List<AllDonasi> allDonasiFromJson(String str) => List<AllDonasi>.from(json.decode(str).map((x) => AllDonasi.fromJson(x)));

String allDonasiToJson(List<AllDonasi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllDonasi {
  AllDonasi({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory AllDonasi.fromJson(Map<String, dynamic> json) => AllDonasi(
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
    required this.deskripsi,
    required this.image,
    required this.penggalang,
    required this.penerima,
    required this.target,
    required this.dueDate,
    required this.linkDonasi,
  });

  int author;
  String title;
  String deskripsi;
  String image;
  String penggalang;
  String penerima;
  int target;
  String dueDate;
  String linkDonasi;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    author: json["author"],
    title: json["title"],
    deskripsi: json["deskripsi"],
    image: json["image"],
    penggalang: json["penggalang"],
    penerima: json["penerima"],
    target: json["target"],
    dueDate: json["due_date"],
    linkDonasi: json["link_donasi"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "title": title,
    "deskripsi": deskripsi,
    "image": image,
    "penggalang": penggalang,
    "penerima": penerima,
    "target": target,
    "due_date": dueDate,
    "link_donasi": linkDonasi,
  };
}
