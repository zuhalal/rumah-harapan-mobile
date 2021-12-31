import '../models/list_all_kontak.dart';

//import '../models/list_all_kontak.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  //final Lesson lesson;

  final Fields field;
  // ignore: prefer_const_constructors_in_immutables
  DetailPage({Key? key, required this.field}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Text(
          field.region,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          field.kategori,
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        Container(
          width: 90.0,
          child: Divider(color: Colors.blue),
        ),
        SizedBox(height: 10.0),
        Text(
          field.namakontak,
          style: TextStyle(color: Colors.black, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Icon(
                Icons.location_on,
                color: Colors.black,
                size: 36.0,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  field.kota + ", " + field.provinsi,
                  style: const TextStyle(color: Colors.black),
                )),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          //height: MediaQuery.of(context).size.height * 0.5,
          color: Color.fromRGBO(173, 232, 242, 1),
        ),
        Container(
          //height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          //width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(173, 232, 242, 1)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black26),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      "Alamat Kontak: " +
          field.alamatkontak +
          "\n" +
          "\n"
              "Keterangan: " +
          field.keterangan,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(13, 110, 253, 1),
      ),
      width: MediaQuery.of(context).size.width,
      child: Text(field.nomorkontak, style: TextStyle(color: Colors.white)),
    );
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/man.jpg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
