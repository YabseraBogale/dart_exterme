import 'dart:io';

dynamic Reload() async {
  var status = await Process.run("git", ["status"]);
  return status.stdout();
}
