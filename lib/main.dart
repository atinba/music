import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:music/pages/song_list.dart';
import 'package:music/services/audio_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioService(),
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  String dirPath = "/storage/emulated/0/media";

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus status = await Permission.storage.request();
    if (!status.isGranted) {
      throw ErrorDescription("Permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SongList(dirPath: dirPath));
  }
}
