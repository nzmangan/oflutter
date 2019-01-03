import 'dart:convert';

class Shared {
  static String getSuffix(int number) {
    var suffix = "th";

    var digit = number % 10;
    if ((digit > 0 && digit < 4) && (number < 11 || number > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }

    return suffix;
  }

  static List<T> convertList<T>(String content, Function resultMapper) {
    return (json.decode(content) as List)
        .map((e) {
          return resultMapper(e);
        })
        .toList()
        .cast<T>();
  }

  static double parseStringToDouble(String input) {
    if (input == null || input.trim() == '') {
      return null;
    }

    double value;

    try {
      value = double.parse(input);
    } catch (Exception) {
      value = null;
    }

    if (value == 0 || value == 0.000000) {
      return null;
    }

    return value;
  }
}
