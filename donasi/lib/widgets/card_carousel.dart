import 'package:donasi/models/model.dart';
import 'package:flutter/material.dart';

class CardCarousel extends StatefulWidget {
  const CardCarousel({Key? key, required this.data, required this.isUser})
      : super(key: key);
  final AllDonasi data;
  final bool isUser;

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(children: [
            Image.network(
                'https://res.cloudinary.com/dnrjqdl6n/' +
                    widget.data.fields.image,
                height: 160),
            Container(
              padding: EdgeInsets.all(12),
              child: Text(widget.data.fields.deskripsi,
                  textAlign: TextAlign.justify),
            ),
          ]),
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
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/donasi-detail');
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
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 8, bottom: 8),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0))),
                        onPressed: () {},
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
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 8, bottom: 8),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0))),
                        onPressed: () {},
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
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/donasi-detail');
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
