import 'dart:io';

Future<String> Reload() async {
  var status = await Process.run("git", ["status"]);
  return status.stdout().toString();
}
