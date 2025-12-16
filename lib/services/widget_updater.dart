import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'coingecko_service.dart';

class WidgetUpdater {
  static const MethodChannel _channel = MethodChannel('com.example.widgets_cripto/widget');

  static Future<void> fetchAndUpdate(String id) async {
    final service = CoinGeckoService();
    try {
      final list = await service.fetchMarketData([id]);
      if (list.isNotEmpty) {
        final c = list[0];
        final price = '\$${c.currentPrice.toStringAsFixed(2)}';
        final text = '${c.name}: $price';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('crypto_price', text);
        // Save image URL so the native widget can show the icon
        await prefs.setString('crypto_image', c.imageUrl);

        await _channel.invokeMethod('refreshWidget');
      }
    } catch (e, st) {
      if (kDebugMode) print('WidgetUpdater failed: $e\n$st');
    }
  }
}
