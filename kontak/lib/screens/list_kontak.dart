//import 'dart:html';
//ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_new
import 'dart:convert';
import 'package:kontak/widgets/search_list.dart';

import '../models/list_all_kontak.dart';

import '../screens/detail_kontak.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'text_section.dart';

class ListContact extends StatefulWidget {
  const ListContact({Key? key}) : super(key: key);

  @override
  _ListContact createState() => _ListContact();
}

class _ListContact extends State<ListContact> {
  List<dynamic> extractedData = [];
  List<Fields> contacts = [];
  String query = '';
  fetchData() async {
    const url = 'http://rumah-harapan.herokuapp.com/kontak/list_kontak';
    try {
      final response = await http.get(Uri.parse(url));
      // print(response.body);
      extractedData = jsonDecode(response.body);
      print(extractedData);
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  @override
  void didChangeDependencies() {
    fetchData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Kontak'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Color.fromRGBO(173, 232, 242, 1),
        body: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                FutureBuilder(
                    future: fetchData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                              child: Text(
                            "Loading...",
                          )),
                        );
                      } else {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          //padding: EdgeInsets.all(20),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          separatorBuilder: (context, _) =>
                              SizedBox(height: 12),
                          itemBuilder: (context, index) =>
                              buildList(contact: snapshot, idx: index),
                        );
                      }
                    }),
              ]))
        ])));
  }

  Fields getField({required AsyncSnapshot contact, required int idx}) => Fields(
      region: contact.data[idx]["fields"]["region"].toString(),
      provinsi: contact.data[idx]["fields"]["provinsi"].toString(),
      kategori: contact.data[idx]["fields"]["kategori"].toString(),
      kota: contact.data[idx]["fields"]["kota"].toString(),
      namakontak: contact.data[idx]["fields"]["namakontak"].toString(),
      nomorkontak: contact.data[idx]["fields"]["nomorkontak"].toString(),
      alamatkontak: contact.data[idx]["fields"]["alamatkontak"].toString(),
      keterangan: contact.data[idx]["fields"]["keterangan"].toString());

  Widget buildList({required AsyncSnapshot contact, required int idx}) =>
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.5,
                offset: Offset(1, 1),
                blurRadius: 2.0,
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: makeHeading(contact: contact, idx: idx),
            title: Text(
              contact.data[idx]["fields"]["kategori"].toString(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Nama: " +
                        contact.data[idx]["fields"]["namakontak"].toString(),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Region: " +
                        contact.data[idx]["fields"]["region"].toString(),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Kota/Kabupaten: " +
                        contact.data[idx]["fields"]["kota"].toString() +
                        ", " +
                        contact.data[idx]["fields"]["provinsi"].toString(),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                  ),
                  //),
                ]),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.black26, size: 30.0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(
                          field: getField(contact: contact, idx: idx))));
            },
          ));

  Container makeHeading({required AsyncSnapshot contact, required int idx}) =>
      Container(
          padding: EdgeInsets.only(right: 0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ((contact.data[idx]["fields"]["kategori"].toString() ==
                    "Hotline COVID-19")
                ? Color.fromRGBO(23, 162, 136, 1)
                : (contact.data[idx]["fields"]["kategori"].toString() ==
                        "Rumah Sakit")
                    ? Color.fromRGBO(108, 117, 125, 1)
                    : (contact.data[idx]["fields"]["kategori"].toString() ==
                            "Ambulans")
                        ? Color.fromRGBO(255, 193, 7, 1)
                        : (contact.data[idx]["fields"]["kategori"].toString() ==
                                "Bank Darah")
                            ? Color.fromRGBO(220, 53, 69, 1)
                            : (contact.data[idx]["fields"]["kategori"]
                                        .toString() ==
                                    "Suplier Alat Kesehatan")
                                ? Color.fromRGBO(13, 110, 253, 1)
                                : Color.fromRGBO(52, 49, 64, 1)),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ((contact.data[idx]["fields"]["kategori"].toString() ==
                    "Hotline COVID-19")
                ? Icon(Icons.local_phone, size: 40, color: Colors.white)
                : (contact.data[idx]["fields"]["kategori"].toString() ==
                        "Rumah Sakit")
                    ? Icon(Icons.local_hospital_rounded,
                        size: 40, color: Colors.white)
                    : (contact.data[idx]["fields"]["kategori"].toString() ==
                            "Ambulans")
                        ? Icon(Icons.add_alert, size: 40, color: Colors.white)
                        : (contact.data[idx]["fields"]["kategori"].toString() ==
                                "Bank Darah")
                            ? Icon(Icons.bloodtype,
                                size: 40, color: Colors.white)
                            : (contact.data[idx]["fields"]["kategori"]
                                        .toString() ==
                                    "Suplier Alkes")
                                ? Icon(Icons.medical_services,
                                    size: 40, color: Colors.white)
                                : Icon(Icons.other_houses,
                                    size: 40, color: Colors.white)),
          ));
}
