import 'package:donasi/models/all_donasi.dart';
import 'package:donasi/screens/donasi_detail.dart';
import 'package:donasi/screens/donasi_edit_form.dart';
import 'package:donasi/screens/donasi_home.dart';
import 'package:flutter/material.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class CardCarousel extends StatefulWidget {
  const CardCarousel({Key? key, required this.data, required this.isUser})
      : super(key: key);
  final AllDonasi data;
  final bool isUser;

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {

  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(children: [
            Image.network(
              "" + widget.data.fields.linkGambar,
              height: 180,
              width: 272,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Text(widget.data.fields.deskripsi,
                  textAlign: TextAlign.justify),
            ),
          ]),
          Column(
            children: !widget.isUser
                ? [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Target:",
                                    style: TextStyle(
                                        color: const Color(0xff27ae60),
                                        fontSize: 16)),
                                Text("${widget.data.fields.target}",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: const Color(0xff27ae60),
                                        fontSize: 16)),
                              ]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tenggat Waktu:",
                                  style: TextStyle(fontSize: 16)),
                              Text("${widget.data.fields.dueDate}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]
                : [],
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: widget.isUser
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: widget.isUser
                  ? [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          onPrimary: Colors.white,
                          primary: const Color(0xff023E8A),
                          side: BorderSide(
                              width: 2, color: const Color(0xff023E8A)),
                          padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) =>
                                  DonasiDetail(data: widget.data.fields));
                          Navigator.push(context, route);
                        },
                        child: const Text('Lihat'),
                      ),
                      SizedBox(height: 4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            primary: Colors.white,
                            side: BorderSide(
                                width: 2, color: const Color(0xff023E8A)),
                            padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0))),
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) =>
                                  EditDonasiForm(id: widget.data.pk, data: widget.data.fields));
                          Navigator.push(context, route);
                        },
                        child: const Text('Edit',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(height: 4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            onPrimary: Colors.white,
                            primary: const Color(0xffEB5757),
                            side: BorderSide(
                                width: 2, color: const Color(0xffEB5757)),
                            padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0))),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Hapus Donasi',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                    'Apakah anda yakin ingin menghapus donasi ini?',
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                            onPrimary: Colors.white,
                                            primary: const Color(0xffEB5757),
                                            side: BorderSide(
                                                width: 2,
                                                color: const Color(0xffEB5757)),
                                            padding: EdgeInsets.fromLTRB(
                                                12.0, 8.0, 12.0, 8.0),
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0))),
                                        onPressed: () async {
                                            final request = Provider.of<CookieRequest>(context, listen: false);
                                            final response =
                                                await request.postJson('http://rumah-harapan.herokuapp.com/donasi/delete/' + widget.data.pk.toString(),
                                                  convert.jsonEncode(<String, String>{'id': widget.data.pk.toString(),}
                                                  )
                                                );
                                            if (response['status'] == 'success') {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text("Donasi berhasil dihapus!")));
                                              Navigator.pushReplacementNamed(context,DonasiHome.routeName);
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text(
                                                    "An error occured, please try again."),
                                              ));
                                            }
                                        },
                                        child: Text("Hapus")),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        textStyle:
                                            const TextStyle(fontSize: 20),
                                        primary: Colors.black12,
                                        onPrimary: Colors.white,
                                        side: BorderSide(
                                            width: 2,
                                            color: const Color(0xff023E8A)),
                                        padding: EdgeInsets.fromLTRB(
                                            12.0, 8.0, 12.0, 8.0),
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(8.0)),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Batal'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text(
                          'Hapus',
                        ),
                      ),
                    ]
                  : [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          onPrimary: Colors.white,
                          primary: const Color(0xff023E8A),
                          side: BorderSide(
                              width: 2, color: const Color(0xff023E8A)),
                          padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) =>
                                  DonasiDetail(data: widget.data.fields));
                          Navigator.push(context, route);
                        },
                        child: const Text('Lihat'),
                      ),
                      SizedBox(height: 4),
                    ],
            ),
          )
        ],
      ),
    );
  }
}
