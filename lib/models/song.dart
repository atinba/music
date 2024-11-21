import 'dart:io';

class Song {
  late final String _title;
  late final String _artist;
  // late final String _album;
  // late final int _length;
  late final String _fileName;
  late final File _file;
  late String _displayName;

  // Public getters
  File get file => _file;
  String get title => _title;
  String get artist => _artist;
  String get fileName => _fileName;
  String get displayName => _displayName;

  set displayName(String name) {
    _displayName = name;
  }

  Song({required File file}) {
    _file = file;
    _fileName = file.path.split('/').last;
    final parts = _fileName.split(' - ');

    if (parts.length > 1) {
      _artist = parts.first;
      _title = parts.skip(1).join(' - ');
    } else {
      _title = parts.join(' - ');
      _artist = "Unknown";
    }

    _displayName = _fileName;
  }
}
