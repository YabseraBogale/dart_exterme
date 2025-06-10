import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<void> main(List<String> arguments) async {
  // hentai force .container-xl
  var uri = Uri.parse("https://hentaiforce.net/view/203032");
  var data = await http.get(uri);
  if (data.statusCode == 200) {
    var dom = parse(data.body);
    var result = dom.querySelectorAll("lazy small-bg-load entered loaded");
    print(result.length);
  } else {
    print('Failed to load data, status code: ${data.statusCode}');
  }
}
