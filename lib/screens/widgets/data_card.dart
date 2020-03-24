import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final List<Widget> children;
  final alignVertical;
  final bgColor;
  final verticalPadding;
  final horizontalPadding;

  DataCard(
      {this.children,
      this.alignVertical = false,
      this.bgColor = Colors.black38,
      this.verticalPadding = 16.0,
      this.horizontalPadding = 10.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: Color(0xff1b232f),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.3),
          //   offset: Offset(0.0, 2.0),
          //   blurRadius: 4.0,
          // )
        ],
      ),
      child: alignVertical
          ? Column(
              children: children,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: children,
            ),
    );
  }
}
