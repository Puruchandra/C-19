import 'package:flutter/material.dart';

class TextStatsCard extends StatelessWidget {
  final String label;
  final String numbers;
  final color;
  TextStatsCard({this.label, this.numbers, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "$numbers",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                color: color.withOpacity(0.0),
                borderRadius: BorderRadius.circular(2.0)),
            child: Text(
              "$label",
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
