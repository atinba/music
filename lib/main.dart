import 'dart:io';
import 'package:flutter/material.dart';
import 'package:music/ui/custom_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final String path;

  const HomePage({super.key, this.path = '/storage/emulated/0/media'});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      _listFiles(widget.path);
    } else {
      throw ErrorDescription("Permission denied");
    }
  }

  Future<void> _listFiles(String path) async {
    final directory = Directory(path);
    if (!await directory.exists()) {
      throw ErrorDescription('Directory does not exist');
    }

    final fileEntities = directory.listSync()
      ..sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));

    final List<Widget> widgetList = [];
    widgetList.addAll(fileEntities
        .whereType<Directory>()
        .map((dir) => DirectoryEntry(dir: dir)));

    final Map<String, List<File>> songMap = {};

    fileEntities.whereType<File>().forEach((file) {
      // TODO: decide how to handle artist name different case
      final artist = file.path.split('/').last.split(' - ').first.toLowerCase();
      songMap.putIfAbsent(artist, () => []).add(file);
    });

    widgetList.addAll(songMap.entries.map((entry) {
      return entry.value.length == 1
          ? FileEntry(file: entry.value.single)
          : ArtistSongList(songs: entry.value);
    }));

    setState(() {
      widgets = widgetList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: widgets,
      ),
    );
  }
}
