import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const TextStyle styleTitle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0);

class _HomeScreenState extends State<HomeScreen> {
  bool wifiStatus = false;

  _getStatusWifi() {
    return wifiStatus == true ? "ON" : "OFF";
  }

  // DETECT WIFI
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  void initDetectWifi() {
    connectivity = new Connectivity();
    // Tạo 1 listener để lắng nghe các sự thay đổi
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print("WIFI status: $wifiStatus");

      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setStateWifi(true);
      }
    });

    // CHECK WIFI
    (Connectivity().checkConnectivity()).then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        setStateWifi(true);
        print("WIFI DETECT: $wifiStatus");
      }
    });
  }

  void setStateWifi(state) {
    setState(() {
      wifiStatus = true;
    });
  }

  @override
  void initState() {
    super.initState();

    initDetectWifi();
  }

  @override
  void dispose() {
    // Huỷ lắng nghe khi không cần thiết nữa
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text("WIFI: " + _getStatusWifi(), style: styleTitle)),
            Container(
                child: Text(
              "DATA API ",
              style: styleTitle,
            ))
          ],
        ),
      ),
    );
  }
}
