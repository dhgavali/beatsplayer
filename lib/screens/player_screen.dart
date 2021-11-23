import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
// import 'audio';

class PlayerScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final String path;

  const PlayerScreen(this.path, this.audioPlayer);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
// // Play or pause; that is, pause if currently playing, otherwise play
// AudioManager.instance.playOrPause()
  double value = 0.0;
  // AudioManager audioManager;
  //  AudioPlayer audioPlayer = new AudioPlayer();
  void loadFile() async {
    // read bundle file to local path
    // final audioFile = await rootBundle.load("assets/aLIEz.m4a");
    // final audio = audioFile.buffer.asUint8List();

    // final appDocDir = await getApplicationDocumentsDirectory();
    // print(appDocDir);

    // final file = File("${appDocDir.path}/aLIEz.m4a");
    // file.writeAsBytesSync(audio);

    // AudioInfo info = AudioInfo("file://${file.path}",
    //     title: "file", desc: "local file", coverUrl: "assets/aLIEz.jpg");

    // list.add(info.toJson());
    // AudioManager.instance.audioList.add(info);
    // setState(() {});
  }
  // late AudioPlayer audioPlayer;
  bool _isplaying = false;

  playAudio() async {
    int response = await widget.audioPlayer.play(widget.path, isLocal: true);

    if (response == 1) {
      print("success");
    } else {
      print("false");
    }

    //play method
  }

  pauseAudio() async {
    int response = await widget.audioPlayer.pause();
    if (response == 1) {
      print("success");
    } else {
      print("false");
    }

    //pause
  }

  stopAudio() async {
    int response = await widget.audioPlayer.stop();
    if (response == 1) {
      print("success");
    } else {
      print("false");
    }
  }

  resumeAudio() async {
    int response = await widget.audioPlayer.resume();
    if (response == 1) {
      print("success");
    } else {
      print("false");
    }

    // start
  }

  bool isart = false;
  Widget albumArt = Container(
    color: Colors.red,
    width: 200,
    height: 200,
  );

  Future<void> loadMeta(String path) async {
    Metadata metadata = await MetadataRetriever.fromFile(new File(path));
    // print(metadata.albumLength);
    print(metadata.albumArt);
    setState(() {
      if (metadata.albumArt != null) {
        albumArt = Image.memory(
          metadata.albumArt!,
          width: 350,
          height: 350,
        );
      }
    });

    // print(metadata.albumName);
    // print(metadata.trackDuration);
    // print(metadata.authorName);
  }

  late Metadata metadata;
  @override
  void initState() {
    // TODO: implement initState
    // size = MediaQuery.of(context).size;
    super.initState();
    loadMeta(widget.path);
    // print()
    // AudioManager.instance
// 	.start(

// 		// "network format resource"
// 		// "local resource (file://${file.path})"
// 		"title",
// 		desc: "desc",
// 		// cover: "network cover image resource"
// 		cover: "assets/ic_launcher.png")
// 	.then((err) {
// 	print(err);
// });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 24.00, vertical: 12.00),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text("title : Mein teri hogaiyaan"),
              ),
              Container(
                child: albumArt,
              ),
              Container(
                child: mySlider(),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    prevButton(),
                    playButton(),
                    nextButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget prevButton() {
    return GestureDetector(
      onTap: () {
        pauseAudio();
        print(
          "prev Button pressed",
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: _boxDecoration(),
        child: Icon(
          Icons.skip_previous,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        print("next Button pressed");
        resumeAudio();
      },
      child: Container(
        decoration: _boxDecoration(),
        width: 50,
        height: 50,
        child: Icon(Icons.skip_next, color: Colors.white),
      ),
    );
  }

  Widget playButton() {
    return GestureDetector(
      onTap: () {
        print("play Button pressed");
        // TODO: play audio

        playAudio();
      },
      child: Container(
        width: 65,
        height: 65,
        decoration: _playBtnDecoration(),
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(50),
    );
  }

  BoxDecoration _playBtnDecoration() {
    return BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.circular(50.0),
    );
  }

  Widget mySlider() {
    return Slider(
      value: value,
      min: 0.0,
      divisions: 300,
      max: 5.0,
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      label: value.toString(),
      onChanged: (val) {
        setState(() {
          this.value = val;
          print(value);
        });
      },
    );
  }
}
