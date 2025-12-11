import 'package:flutter/cupertino.dart';

class CryptoTheme {
  static Color getColor(String symbol) {
    switch (symbol.toUpperCase()) {
      case "BTC":
        return const Color(0xFFFFA800);
      case "ETH":
        return const Color(0xFF627EEA);
      case "SOL":
        return const Color(0xFF9945FF);
      case "USDT":
        return const Color(0xFF26A17B);
      default:
        return CupertinoColors.systemBlue;
    }
  }
}
