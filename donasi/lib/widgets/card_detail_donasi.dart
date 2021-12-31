import 'package:flutter/material.dart';

class CardDetailDonasi extends StatefulWidget {
  const CardDetailDonasi(
      {Key? key, required this.title, required this.icon, required this.name})
      : super(key: key);
  final String title;
  final IconData icon;
  final String name;

  @override
  _CardDetailDonasiState createState() => _CardDetailDonasiState();
}

class _CardDetailDonasiState extends State<CardDetailDonasi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff59A5D8),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 24, color: const Color(0xff59A5D8)),
              )
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(widget.icon, color: const Color(0xff59A5D8)),
              SizedBox(
                width: 24,
              ),
              Text(
                widget.name,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20, color: const Color(0xff59A5D8)),
              )
            ],
          )
        ],
      ),
    );
  }
}
