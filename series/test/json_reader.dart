import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/series')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/series/test/$name').readAsStringSync();
}
