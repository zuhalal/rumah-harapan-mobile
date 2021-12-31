import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  CardWidget(this.author, this.title, this.body, this.date);
  final author;
  final title;
  final body;
  final date;

  Widget build(BuildContext context) {
      return Container(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffade8f4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(author),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18,
                    ),
                    Text(date),
                  ],
                ),
                Text(title),
                SizedBox(height: 10),
                Text(body),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
    }
  }
