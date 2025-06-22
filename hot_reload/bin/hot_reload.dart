import 'package:hot_reload/hot_reload.dart' as hot_reload;

void main(List<String> arguments) async {
  var result = await hot_reload.reload();
  print(result);
}
