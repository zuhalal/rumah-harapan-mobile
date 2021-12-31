import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:vaksin/models/konten_vaksin.dart';

class ForumInformasiContainer extends StatefulWidget {
  const ForumInformasiContainer(
      {Key? key,
      required this.forum})
      : super(key: key);
  final AllForum forum;

  @override
  _ForumInformasiContainer createState() => _ForumInformasiContainer();
}

class _ForumInformasiContainer extends State<ForumInformasiContainer> {
  String judul = '';
  String penulis = '';
  DateTime tanggalPublikasi = '' as DateTime;
  String konten = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    judul = widget.forum.fields.judul;
    penulis = widget.forum.fields.penulis;
    tanggalPublikasi = widget.forum.fields.tanggalPublikasi;
    konten = widget.forum.fields.konten;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 50,
          color: Color.fromRGBO(89, 165, 216, 1),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.person_pin,
                          size: 32,
                        ),
                        Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              judul,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              penulis,
                              style: const TextStyle(
                                  fontSize: 14),
                            ),
                            Text(
                              "   " +
                                  DateFormat('kk:mm – dd-MM-yyyy')
                                      .format(tanggalPublikasi)
                                      .toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 60,
          color: Color.fromRGBO(89, 165, 216, 1),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    konten,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ]),
          ),
        ),
        
      ],
    );
  }
}