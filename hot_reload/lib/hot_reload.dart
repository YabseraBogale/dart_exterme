import 'dart:io';

Future<String> reload() async {
  var status = await Process.run("git", ["status"]);
  return status.stdout;
}

Future<void> server() async {
  try {
    var serve = await HttpServer.bind("localhost", 8080);
  } catch (e) {
    print(e);
  }
}
