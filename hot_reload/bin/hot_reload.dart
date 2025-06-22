import 'dart:io';

void main(List<String> arguments) async {
  var status = await Process.run("git", ["status"]);
  var test = status.stdout.toString().split("\n")[3];
  if (test == "Changes not staged for commit:") {
    print("ok");
  } else if (test == "") {}
}
