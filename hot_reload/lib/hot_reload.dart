import 'dart:io';

Future<void> server() async {
  try {
    final serve = await HttpServer.bind("localhost", 8080);
    await for (HttpRequest request in serve) {
      print("server started in localhost:8080");
      if (request.uri.path == "/") {
        try {
          var status = await Process.run("git", ["status"]);
          var result = status.stdout.toString().split("\n")[3];
          if (result == "Changes not staged for commit:") {
          } else if (result == "nothing to commit, working tree clean") {}
        } catch (e) {
          print(e);
        }
      }
    }
  } catch (e) {
    print(e);
  }
}
