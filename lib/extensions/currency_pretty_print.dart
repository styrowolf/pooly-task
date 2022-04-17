import 'package:pooly_task/models/money.dart';

extension PrettyPrint on Currency {
  String prettyPrint() {
    if (this == Currency.EUR) {
      return "Euro";
    } else if (this == Currency.TRY) {
      return "Türk Lirası";
    } else if (this == Currency.USD) {
      return "US Dollar";
    } else {
      //unreachable
      return "";
    }
  }
}