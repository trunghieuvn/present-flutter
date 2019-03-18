import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:present_flutter/Config.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      width: Dimension.getWidth(1.0),
      height: Dimension.getHeight(1.0),
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );

    // return new FlareActor("assets/animations/Trim.flr",
    //     alignment: Alignment.bottomCenter,
    //     fit: BoxFit.contain,
    //     animation: "Untitled");
  }
}
