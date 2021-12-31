import 'dart:convert';

List<Prov> provFromJson(String str) => List<Prov>.from(json.decode(str).map((x) => Prov.fromJson(x)));

String provToJson(List<Prov> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Prov {
    Prov({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Prov.fromJson(Map<String, dynamic> json) => Prov(
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
        required this.kota,
        required this.positif,
        required this.sembuh,
        required this.kematian,
        required this.urutan,
    });

    String kota;
    String positif;
    String sembuh;
    String kematian;
    String urutan;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        kota: json["kota"],
        positif: json["positif"],
        sembuh: json["sembuh"],
        kematian: json["kematian"],
        urutan: json["urutan"],
    );

    Map<String, dynamic> toJson() => {
        "kota": kota,
        "positif": positif,
        "sembuh": sembuh,
        "kematian": kematian,
        "urutan": urutan,
    };
}
