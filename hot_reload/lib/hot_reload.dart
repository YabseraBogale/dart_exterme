import 'dart:io';

Future<void> server() async {
  try {
    final serve = await HttpServer.bind("localhost", 8080);
    await for (HttpRequest request in serve) {
      print("server started in localhost:8080");
      if (request.uri.path == "/") {
        try {
          var status = await Process.run("git", ["status"]);
          print(status.stdout);
        } catch (e) {
          print(e);
        }
      }
    }
  } catch (e) {
    print(e);
  }
}
