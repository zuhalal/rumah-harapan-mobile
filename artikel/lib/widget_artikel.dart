import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  CardWidget(this.author, this.title, this.body, this.date);
  final author;
  final title;
  final body;
  final date;

  Widget build(BuildContext context) {
      return Card(
        child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffade8f4),
            ),
            height: 150,
            child: Row(
              children: [
                Text(author),
                Text(title),
                Text(body),
                Text(date),
              ],
            )),
        elevation: 8,
        margin: EdgeInsets.all(20),
      );
    }
  }
