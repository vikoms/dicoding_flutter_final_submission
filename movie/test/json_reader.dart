import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/movie')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/movie/test/$name').readAsStringSync();
}
