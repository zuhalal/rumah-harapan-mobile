import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:rumah_harapan/screens/login_screen.dart';
import 'package:vaksin/models/konten_vaksin.dart';
import 'package:vaksin/screens/add_forum_vaksin.dart';

class ForumInformasiContainer extends StatefulWidget {
  const ForumInformasiContainer(
      {Key? key, required this.konten, required this.isUser})
      : super(key: key);
  final AllForum konten;
  final bool isUser;

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

    return SizedBox(
      width: double.infinity,
      child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 50,
                  color: Color.fromRGBO(89, 165, 216, 1),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      judul,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Penulis: ' + penulis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    Text(
                                      "Tanggal Publikasi: " +
                                          DateFormat('kk:mm - dd-MM-yyyy')
                                              .format(tanggalPublikasi),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
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
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            konten,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          )),
    );
  }
}
