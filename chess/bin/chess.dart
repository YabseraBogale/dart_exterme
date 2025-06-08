import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

Future<void> main(List<String> arguments) async {
  var handler = createStaticHandler('web', defaultDocument: 'index.html');

  var server = await io.serve(handler, 'localhost', 8080);
  print(
    'Static file server running at http://${server.address.host}:${server.port}',
  );
}
