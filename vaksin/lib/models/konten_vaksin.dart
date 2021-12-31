import 'dart:convert';

List<AllForum> allForumFromJson(String str) =>
    List<AllForum>.from(json.decode(str).map((x) => AllForum.fromJson(x)));

String allDonasiToJson(List<AllForum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllForum {
  AllForum({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory AllForum.fromJson(Map<String, dynamic> json) => AllForum(
        model: json['model'],
        pk: json['pk'],
        fields: Fields.fromJson(json['fields']),
      );

  Map<String, dynamic> toJson() => {
        'model': model,
        'pk': pk,
        'fields': fields.toJson(),
      };
}

class Fields {
  String judul, tanggalPublikasi, konten;
  int penulis;
  Fields(
      {required this.judul,
      required this.penulis,
      required this.tanggalPublikasi,
      required this.konten});

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
      judul: json['judul'],
      penulis: json['penulis'],
      tanggalPublikasi: json['tanggal_publikasi'],
      konten: json['konten']);

  Map<String, dynamic> toJson() => {
        'judul': judul,
        'penulis': penulis,
        'tanggal_publikasi': tanggalPublikasi,
        'konten': konten
      };
}
