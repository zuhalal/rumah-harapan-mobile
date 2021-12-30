import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:provider/provider.dart';
import 'package:update_covid/models/harapan.dart';

class CardHarapan extends StatefulWidget {
  const CardHarapan({Key? key, required this.data, required this.userPk, required this.userName}) 
      : super(key: key);
  final Harapan data;
  final Map<String,int> userPk;
  final Map<int,String> userName;
  

  @override
  _CardHarapanState createState() => _CardHarapanState();
}

class _CardHarapanState extends State<CardHarapan> {
  String harapan = "";
  int like = 0;
  Icon x = Icon(Icons.thumb_down,color:Colors.yellow);
  String status = "Tidak Suka";
  DateTime tanggal = DateTime.now();
  int idAuthor = 0;
  int idUser = 0;
  String username = "admin";
  bool isUser = false;

  void _incrementCounter(String status) {
    setState(() {
      if (status == "Suka") {
        status = "Tidak Suka";
        x = Icon(Icons.thumb_down,color: Colors.yellow,);
        like++;
      } else {
        status = "Suka";
        x = Icon(Icons.thumb_up,color: Colors.yellow,);
        like--;
      }
    });
  }

  String _getUsername(Map<int,String> map, int pk) {
    String x = map[pk].toString();
    print(x);
    return x;
  }

  int _getPK(Map<String,int> map, String username) {
    int x = 0;
    if (map[username] != null)
      x = map[username]!.toInt();
    return x;
  }
  
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    idAuthor = widget.data.fields.author;
    harapan = widget.data.fields.message;
    like = widget.data.fields.like.length;
    tanggal = widget.data.fields.publishedDate;
    username = _getUsername(widget.userName, idAuthor);
    idUser = _getPK(widget.userPk, request.username);

    if (request.username == username) username = "Anda";

    if (widget.data.fields.like.contains(idUser)) status = "Suka";

    if (status == "Suka") x = Icon(Icons.thumb_up, color:Colors.yellow);

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
                  children: <Widget> [
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget> [
                        Icon(
                          Icons.person_pin,
                          size: 32,
                        ),
                        Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(username,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Text("   " + DateFormat('kk:mm – dd-MM-yyyy').format(tanggal).toString(), 
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
              children: <Widget> [Text(harapan,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),]
            ),
          ),
        ), 
        request.loggedIn == true ?
        Container(
          height: 65,
          color: Color.fromRGBO(89, 165, 216, 1),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    FlatButton.icon(
                      onPressed: () {
                        _incrementCounter(status);
                      }, 
                      icon: x, 
                      label: Text(status),
                    ),
                    Text(like.toString() + " Suka  ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ) : Text(""),
        Text(" ",),
      ],
    );
  }
}


  // void _incrementCounter() {
  //   setState(() {
  //     if (status == "Suka") {
  //       status = "Tidak Suka";
  //       x = Icon(Icons.thumb_down,color: Colors.yellow,);
  //       like++;
  //     } else {
  //       status = "Suka";
  //       x = Icon(Icons.thumb_up,color: Colors.yellow,);
  //       like--;
  //     }
  //   });
  // }