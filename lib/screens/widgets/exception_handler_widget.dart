import 'package:flutter/material.dart';

class ExceptionHandlerWidget extends StatelessWidget {
  final String errMsg;
  ExceptionHandlerWidget({this.errMsg});
  @override
  Widget build(BuildContext context) {
    Map<String, String> _data = {};
    if (errMsg.contains("Internet")) {
      _data = handlers["internet"];
    } else if (errMsg.contains("Not Found")) {
      _data = handlers["not-found"];
    } else if (errMsg.contains("Nothing to Display")) {
      _data = handlers["no-display"];
    } else {
      _data = handlers["default"];
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              _data['image'],
              height: 180,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              _data['msg'],
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

const handlers = {
  "internet": {
    'image': 'assets/images/under_maintainance.png',
    'msg': 'Not Internet',
  },
  "not-found": {
    'image': 'assets/images/under_maintainance.png',
    'msg': 'Not Found',
  },
  "no-display": {
    'image': 'assets/images/under_maintainance.png',
    'msg': 'Try again later',
  },
  "default": {
    'image': 'assets/images/under_maintainance.png',
    'msg': 'We are Currently under maintainance. Please try again later',
  },
};
