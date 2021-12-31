import 'dart:convert';

List<AllKontak> allKontakFromJson(String str) =>
    List<AllKontak>.from(json.decode(str).map((x) => AllKontak.fromJson(x)));

String allKontakToJson(List<AllKontak> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllKontak {
  AllKontak({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory AllKontak.fromJson(Map<String, dynamic> json) => AllKontak(
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
    //required this.author,
    required this.region,
    required this.provinsi,
    required this.kategori,
    required this.kota,
    required this.namakontak,
    required this.nomorkontak,
    required this.alamatkontak,
    required this.keterangan,
  });

  //int author;
  String region;
  String provinsi;
  String kategori;
  String kota;
  String namakontak;
  String nomorkontak;
  String alamatkontak;
  String keterangan;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        //author: json["author"],
        region: json["region"],
        provinsi: json["provinsi"],
        kategori: json["link_gambar"],
        kota: json["kota"],
        namakontak: json["namakontak"],
        nomorkontak: json["nomorkontak"],
        alamatkontak: json["due_date"],
        keterangan: json["link_Kontak"],
      );

  Map<String, dynamic> toJson() => {
        //"author": author,
        "region": region,
        "provinsi": provinsi,
        "kategori": kategori,
        "kota": kota,
        "nama_kontak": namakontak,
        "nomor_kontak": nomorkontak,
        "alamat_kontak": alamatkontak,
        "keterangan": keterangan,
      };
}
