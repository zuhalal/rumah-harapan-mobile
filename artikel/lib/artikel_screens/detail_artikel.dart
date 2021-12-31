import 'package:flutter/material.dart';
import 'package:artikel/artikel_models/get_artikel.dart';

class DetailArtikel extends StatefulWidget {
  const DetailArtikel ({Key? key, required this.data}) : super(key: key);
  final Fields data;

  @override
  _DetailArtikelState createState() => _DetailArtikelState();
}

class _DetailArtikelState extends State<DetailArtikel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Artikel"),
        ),
