import 'dart:io';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<void> main(List<String> arguments) async {
  // hentai force .container-xl
  var uri = Uri.parse("https://hentaiforce.net/view/203032");
  var data = await http.get(uri);
  if (data.statusCode == 200) {
    var dom = parse(data.body);
    var result = dom.querySelectorAll(".single-thumb");
    for (var i in result) {
      var image = i.getElementsByTagName("img");
      String? imageSrc = image[0].attributes["data-src"];
      if (imageSrc != null) {
        var respone = await http.get(Uri.parse(imageSrc));
        final file = File("./download/${result.indexOf(i)}.jpg");
        await file.writeAsBytes(respone.bodyBytes);
        print("downloaded file: ./download/${result.indexOf(i)}.jpg");
      }
    }
  } else {
    print('Failed to load data, status code: ${data.statusCode}');
  }
}
