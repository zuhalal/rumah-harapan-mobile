import 'package:donasi/models/all_donasi.dart';
import 'package:flutter/material.dart';
import 'package:donasi/widgets/card_detail_donasi.dart';
import 'package:url_launcher/url_launcher.dart';

class DonasiDetail extends StatefulWidget {
  const DonasiDetail({Key? key, required this.data}) : super(key: key);
  final Fields data;

  @override
  _DonasiDetailState createState() => _DonasiDetailState();
}

class _DonasiDetailState extends State<DonasiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Donasi Details"),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Text("Author: ",
                        //     textAlign: TextAlign.left,
                        //     style: TextStyle(
                        //         fontSize: 20, color: const Color(0xff59A5D8)))
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      widget.data.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36, color: const Color(0xff59A5D8)),
                    ),
                    SizedBox(height: 24),
                    Image.network('https://res.cloudinary.com/dnrjqdl6n/' +
                        widget.data.image),
                    SizedBox(height: 48),
                    Row(
                      children: [
                        Text("Deskripsi",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 28, color: const Color(0xff59A5D8))),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          widget.data.deskripsi,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(height: 48),
                    Row(
                      children: [
                        Text("Detail",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 28,
                                color: const Color(0xff59A5D8)
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    CardDetailDonasi(
                      icon: Icons.monetization_on,
                      title: "Penggalang Dana:",
                      name: widget.data.penggalang,
                    ),
                    SizedBox(height: 24),
                    CardDetailDonasi(
                        icon: Icons.people_sharp,
                        title: "Penerima Dana:",
                        name: widget.data.penerima),
                    SizedBox(height: 16),
                    CardDetailDonasi(
                        icon: Icons.attach_money,
                        title: "Target:",
                        name: "${widget.data.target}"),
                    SizedBox(height: 24),
                    CardDetailDonasi(
                        icon: Icons.calendar_today,
                        title: "Tenggat Waktu:",
                        name: widget.data.dueDate),
                    SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            primary: Colors.black12,
                            onPrimary: Colors.white,
                            side: BorderSide(
                                width: 2, color: const Color(0xff023E8A)),
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 8, bottom: 8),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0)),
                          ),
                          onPressed: () => launch('https://www.twitter.com/share?url=http://rumah-harapan.herokuapp.com/donasi/'),
                          child: const Text('Bagikan'),
                        ),
                        SizedBox(height: 4),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              onPrimary: Colors.white,
                              primary: const Color(0xff023E8A),
                              side: BorderSide(width: 2, color: const Color(0xff023E8A)),
                              padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0))),
                          onPressed: () => launch(
                              widget.data.linkDonasi.contains("http")
                              ? widget.data.linkDonasi
                              : "https://" + widget.data.linkDonasi),
                          child: const Text('Donasi Sekarang'),
                        ),
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }
}
