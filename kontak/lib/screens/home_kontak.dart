//import 'dart:html';
//ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/list_kontak.dart';
import '../screens/detail_kontak.dart';
import '../screens/form.dart';
import '../models/list_all_kontak.dart';
//import 'text_section.dart';

class ListItem {
  final String kategori;
  final String nama;
  final String region;
  final String provinsi;
  final String kota;

  const ListItem({
    required this.kategori,
    required this.nama,
    required this.region,
    required this.provinsi,
    required this.kota,
  });
}

class CardItem {
  final String image;
  final String title;
  final String subtitle;

  const CardItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class ContactHome extends StatefulWidget {
  static const routeName = '/kontak';
  const ContactHome({Key? key}) : super(key: key);

  @override
  _ContactHome createState() => _ContactHome();
}

class _ContactHome extends State<ContactHome> {
  List<CardItem> items = [
    CardItem(
      image: 'assets/images/donasi/covidambulans.png',
      title: 'Nomor call center COVID-19 yang dapat dihubungi kapan saja!',
      subtitle:
          'Untuk menghubungi call center COVID nasional silahkan ketikkan 119 ext 9 pada telepon genggam Anda.',
    ),
    CardItem(
      image: 'assets/images/donasi/covidkominfo.jpeg',
      title: 'Portal informasi satu pintu milik Kominfo, nih!',
      subtitle:
          'Anda bisa mendapatkan informasi yang valid dan terpercaya terkait COVID-19 melalui kontak layanan 112.',
    ),
    CardItem(
      image: 'assets/images/donasi/covidbansos.jpeg',
      title:
          'Cari tahu informasi Bansos melalui hotline terpercaya milik Kemensos!',
      subtitle:
          'Layanan pengaduan bansos dapat Anda akses melalui kontak layanan 157 atau whatsapp dengan nomor 081110-22210.',
    ),
  ];

  List<ListItem> contacts = [
    ListItem(
      kategori: 'Rumah Sakit',
      nama: 'RSU Kota Denpasar',
      region: 'Bali',
      provinsi: 'Bali',
      kota: 'Denpasar',
    ),
    ListItem(
      kategori: 'Ambulans',
      nama: 'Ambulans ni',
      region: 'Jawa',
      provinsi: 'Jawa Barat',
      kota: 'Bandung',
    ),
    ListItem(
      kategori: 'Hotline COVID-19',
      nama: 'COVID Sumbar',
      region: 'Sumatra',
      provinsi: 'Sumatera Barat',
      kota: 'Padang',
    ),
  ];

  List<dynamic> extractedData = [];
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
          title: Text('Kontak'),
        ),
        backgroundColor: Color.fromRGBO(173, 232, 242, 1),
        body: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SizedBox(
            height: 300,
            child: ListView.separated(
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, _) => SizedBox(width: 20),
              itemBuilder: (context, index) => buildCard(item: items[index]),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: 180,
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
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      //textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Container(
                          width: 120,
                          padding: EdgeInsets.only(top: 20, right: 4, left: 12),
                          child: Expanded(
                            child: Image.asset(
                                'assets/images/donasi/callsupport.png',
                                //width: 20,
                                height: 100,
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Text(
                              "Mari ikut serta menambahkan kontak penting dari daerah sekitarmu untuk memudahkan #TemanHarapan mencari kontak darurat.",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ]),
                  Padding(
                    padding: EdgeInsets.only(left: 24, right: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.teal,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: Text('Tambahkan'),
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => AddKontakForm());
                        Navigator.push(context, route);
                        // Navigator.push(
                        //     context, route,
                        //     Route route = MaterialPageRoute(
                        //         builder: (context, route) => AddKontakForm()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4, left: 20),
                child: Text(
                  "Kontak dari #TemanHarapan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4, left: 24, right: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                          color: Colors.teal,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  child: Text('Lihat Semua'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListContact()));
                  },
                ),
              ),
            ],
          ),
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
                    padding: EdgeInsets.all(20),
                    scrollDirection: Axis.vertical,
                    itemCount: 3,
                    separatorBuilder: (context, _) => SizedBox(height: 12),
                    itemBuilder: (context, index) =>
                        buildList(contact: snapshot, idx: index),
                  );
                }
              }),
        ])));
  }

  Widget buildCard({
    required CardItem item,
  }) =>
      Container(
          width: 300,
          //height: 400,
          //color: Colors.red,
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            //Padding(padding: EdgeInsets.all(8)),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20)),
                child: Image.asset(
                  item.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Text(
                item.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4, right: 10, left: 10, bottom: 20),
              child: Text(
                item.subtitle,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
              ),
            ),
          ]));

  // Widget buildList({required AsyncSnapshot contact, required int idx}) =>
  //     Container(
  //         height: 140,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           color: Colors.white,
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Colors.grey,
  //               spreadRadius: 0.5,
  //               offset: Offset(1, 1),
  //               blurRadius: 2.0,
  //             ),
  //           ],
  //         ),
  //         child:
  //             Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
  //           const SizedBox(height: 10),
  //           Padding(
  //             padding: EdgeInsets.only(top: 4, left: 20, bottom: 4),
  //             child: Text(
  //               contact.data[idx]["fields"]["kategori"].toString(),
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(top: 4, left: 20, bottom: 4),
  //             child: Text(
  //               "Nama: " + contact.data[idx]["fields"]["namakontak"].toString(),
  //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(top: 4, left: 20, bottom: 4),
  //             child: Text(
  //               "Region: " + contact.data[idx]["fields"]["region"].toString(),
  //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(top: 4, left: 20, bottom: 4),
  //             child: Text(
  //               "Kota/Kabupaten: " +
  //                   contact.data[idx]["fields"]["kota"].toString() +
  //                   ", " +
  //                   contact.data[idx]["fields"]["provinsi"].toString(),
  //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  //             ),
  //           ),
  //         ]));
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
                                    "Suplier Alat Kesehatan")
                                ? Icon(Icons.medical_services,
                                    size: 40, color: Colors.white)
                                : Icon(Icons.other_houses,
                                    size: 40, color: Colors.white)),
          ));
}
