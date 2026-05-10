import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Tablet Layout\n(Medium Grid)",
          textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 32)),
    );
  }
}