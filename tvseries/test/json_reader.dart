import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/tvseries/test')) {
    dir = dir.replaceAll('/tvseries/test', '');
  }
  return File('$dir/tvseries/test/$name').readAsStringSync();
}
