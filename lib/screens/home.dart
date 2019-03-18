import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:present_flutter/Config.dart';
import 'package:present_flutter/model_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:present_flutter/screens/play_video.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// ====================== Define Style ======================
TextStyle styleTitle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0);

TextStyle styleData = TextStyle(color: Colors.black, fontSize: 16.0);

TextStyle txtBtn =
    TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold);

class _HomeScreenState extends State<HomeScreen> {
  // //========================================= LIFE CYCLE //=========================================
  @override
  void initState() {
    super.initState();

    _initDetectWifi().then((onValue) {
      _getData();
    });
  }

  @override
  void dispose() {
    // Huỷ lắng nghe khi không cần thiết nữa
    subscription.cancel();
    super.dispose();
  }

  //========================================= DETECT WIFI ==============================
  bool wifiStatus = false;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  _getStatusWifi() {
    return wifiStatus == true ? "ON" : "OFF";
  }

  void setStateWifi(state) {
    setState(() {
      wifiStatus = true;
    });
  }

  Future<void> _initDetectWifi() async {
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
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setStateWifi(true);
      print("WIFI DETECT: $wifiStatus");
    }
  }

// ========================================= LOAD DATA RESTFUL API=========================================
  ScreenState mState;
  DataModel dataModel;
  Future<void> _getData() async {
    if (this.wifiStatus == false) {
      print("[_getData] NO WIFI");
      return;
    }
    print("[_getData] load data");

    http.get(Configs.DOMAIN_API).then(((http.Response lResp) {
      var result = json.decode(lResp.body);
      print("result $result");
      if (lResp.statusCode == 200) {
        if (result["name"] != null) {
          print("[_getData] load data DONE");
          setState(() {
            dataModel = DataModel.fromJson(result);
          });
        }
      } else {
        setState(() {
          mState = ScreenState.DONE;
        });
      }
    }));
  }
// ========================================= LOAD DATA RESTFUL API=========================================
  void _onTapPlayVideo() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => new PlayVideo(linkVideo: dataModel.linkintro)));
  }

  @override
  Widget build(BuildContext context) {
    Dimension.height = MediaQuery.of(context).size.height;
    Dimension.witdh = MediaQuery.of(context).size.width;

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
            )),
            dataModel == null
                ? Text("ERROR LOAD DATA")
                : Container(
                    child: Column(
                      children: <Widget>[
                        Text("Age: " + dataModel.age.toString(),
                            style: styleData),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text("Name: " + dataModel.name,
                                style: styleData)),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text("Platfrom: " + dataModel.platfrom,
                                style: styleData)),
                        Container(
                          height: Dimension.getWidth(0.25),
                          width: Dimension.getWidth(0.25),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    dataModel.urlImg),
                              )),
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            color: Colors.red,
                            child: Text(
                              "Play video",
                              style: txtBtn,
                            ),
                          ),
                          onTap: () {
                            _onTapPlayVideo();
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
