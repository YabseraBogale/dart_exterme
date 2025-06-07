import 'dart:io';

import 'package:excel/excel.dart';

void main(List<String> arguments) {
  var file = File("paper.xlsx").readAsBytesSync();
  var excel = Excel.decodeBytes(file);
  // Get the name of the first sheet
  String firstSheetName = excel.tables.keys.first;
  var sheet = excel.tables[firstSheetName];

  print('Reading first sheet: $firstSheetName');
  for (var row in sheet!.rows) {
    print(row.map((cell) => cell?.value).toList()[1].toString() == "P");
  }
}
