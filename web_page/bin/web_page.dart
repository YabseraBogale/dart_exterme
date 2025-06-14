import 'dart:io';

void main(List<String> arguments) {
  print("Enter operation: ");
  String? cal = stdin.readLineSync();
  print("Enter number ");
  String? number = stdin.readLineSync();
  String? number2 = stdin.readLineSync();
  switch (cal) {
    case "+":
      if (number2 != null && number != null) {
        print(int.parse(number) + int.parse(number2));
      }
    case "-":
      if (number2 != null && number != null) {
        print(int.parse(number) - int.parse(number2));
      }
    case "*":
      if (number2 != null && number != null) {
        print(int.parse(number) * int.parse(number2));
      }
    case "/":
      if (number2 != null && number != null) {
        print(int.parse(number) / int.parse(number2));
      }
    default:
      print("error");
  }
}
