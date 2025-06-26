import 'dart:io';

Future<void> main(List<String> arguments) async {
  try {
    var server = await HttpServer.bind("localhost", 8080);
    await for (HttpRequest request in server) {
      var path = request.uri.path;
      var index = File("index.html");
      if (path == "" || path == "/index.html") {
        request.response.headers.contentType = ContentType.parse(
          "text/html; charset=utf-8",
        );
        index.openRead().pipe(request.response);
      } else {
        break;
      }
    }
  } catch (e) {
    print(e);
  }
}
