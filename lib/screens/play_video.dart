import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final String linkVideo;

  const PlayVideo({Key key, this.linkVideo}) : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();

    listener = () {
      setState(() {});
    };

    createVideo();
  }

  Future<void> createVideo() async{
    // Kiểm tra xem nếu như controller video chưa có dữ liệu thì khởi tạo
    if (playerController == null) {
      playerController = VideoPlayerController.network(widget.linkVideo)
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    }
  }
  

  @override
  void dispose() {
    super.dispose();
    playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                child: (playerController != null
                    ? VideoPlayer(
                        playerController,
                      )
                    : Container()),
              ))),
    );
  }
}
