import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/core')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/packages/core/test/$name').readAsStringSync();
}
