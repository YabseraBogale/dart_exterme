import 'dart:io';

Future<void> main(List<String> arguments) async {
  try {
    var server = await HttpServer.bind("localhost", 8080);
    WebSocket socket;
    await for (HttpRequest request in server) {
      var path = request.uri.path;
      if (path == "" && path == "/index.html") {}
    }
  } catch (e) {
    print(e);
  }
}
