import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: SpinKitChasingDots(
            color: new Color(0xFF2699FB),
            size: 50.0,
          ),
        ));
  }
}
