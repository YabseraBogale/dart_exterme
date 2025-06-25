import 'dart:io';

void main(List<String> arguments) async {
  try {
    var server = await HttpServer.bind("localhost", 8080);
    WebSocket socket;
    await for (HttpRequest request in server) {}
  } catch (e) {
    print(e);
  }
}
