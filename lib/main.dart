import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:beatsplayer/screens/player_screen.dart';
import 'package:beatsplayer/shared/loadings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player by Dh',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoard(),
    );
  }
}

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  // Stream getSongs() async{

  // }
  //key for loading

// var retriever = new MetadataRetriever();
// await retriever.setFile();
// Metadata metadata = await retriever.metadata;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  late List<FileSystemEntity> songsList;
  Widget? albumArt;
  // List<Metadata> songsData = [];

  Future<List<Metadata>> loadMeta(List<FileSystemEntity> paths) async {
    List<Metadata> songsData = [];
    for (var item in paths) {
      Metadata metadata = await MetadataRetriever.fromFile(new File(item.path));
      // print(metadata.albumArt);
      songsData.add(metadata);
    }

    return songsData;
  }

  List<FileSystemEntity> songs = [];
  Future<List<Metadata>> getList() async {
    Directory dir = Directory('/storage/emulated/0/');
    String mp3Path = dir.toString();
    print(mp3Path);
    List<FileSystemEntity> _files;

    _files = dir.listSync(recursive: true, followLinks: false);

    for (FileSystemEntity entity in _files) {
      String path = entity.path;
      if (!path.contains("Android") &&
          !path.contains("Call") &&
          !path.contains("WhatsApp")) {
        if (path.endsWith('.mp3')) {
          songs.add(entity);
        }
      }
    }
    List<Metadata> _songsdata = await loadMeta(songs);

    // return _songs;
    return _songsdata;
  }

  PermissionStatus _permissionStatus = PermissionStatus.denied;

  checkPermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status == _permissionStatus) {
      Permission.storage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
    // songsList = getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Music Player"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              //TODO: refresh the songs list
              Loadings.showLoadingDialog(context, _keyLoader);
              await Future.delayed(Duration(seconds: 2));
              Navigator.of(_keyLoader.currentContext!, rootNavigator: true)
                  .pop();
            },
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Metadata>>(
          future: getList(),
          builder: (context, AsyncSnapshot<List<Metadata>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                List<Metadata> data = snapshot.data!;
                print(data);
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        AudioPlayer audioPlayer = new AudioPlayer();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlayerScreen(songs[index].path, audioPlayer),
                          ),
                        );
                      },
                      leading: data[index].albumArt != null
                          ? Container(
                              width: 30,
                              height: 30,
                              // color: Colors.blue,
                              child: Image.memory(data[index].albumArt!))
                          : Container(
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              child: Icon(Icons.music_note),
                            ),
                      title: Text(data[index].albumName.toString()),
                    );
                  },
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      // body: Container(
      //   child: FutureBuilder<FileSystemEntity>(
      //     // future: getList().asStream(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         var length = snapshot.data.
      //         return ListView.builder
      //         (
      //           itemCount: ,
      //           itemBuilder: (context, index) {
      //             return ListTile();
      //           },
      //         );
      //       } else {
      //         return CircularProgressIndicator();
      //       }
      //     },
      //   ),
      // ),
    );
  }
}


//body
// Container(
//         child: ListView.builder(
//           itemCount: getList().length,
//           itemBuilder: (context, index) {
//             // List<FileSystemEntity> data = getList();
//             if (songsList.isEmpty) {
//               return CircularProgressIndicator();
//             }

//             String title =
//                 songsList[index].path.split(Platform.pathSeparator).last;
//             return ListTile(
//               leading: Container(
//                 width: 30,
//                 height: 30,
//                 color: Colors.yellow,
//               ),
//               title: Text(title),
//               onTap: () {
               
//               },
//             );
//           },
//         ),
//       ),