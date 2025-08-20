import 'package:flutter/material.dart';

pushTo(BuildContext context, Widget newPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => newPage));
}

pushWithReplacement(BuildContext context, Widget newPage) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => newPage),
  );
}

pushUntil(BuildContext context, Widget newPage) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => newPage),
    (route) => false,
  );
}
