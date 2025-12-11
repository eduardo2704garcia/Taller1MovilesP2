import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/crypto.dart';

class CoinGeckoService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<Crypto> fetchBitcoinData() async {
    final url = Uri.parse(
      '$_baseUrl/coins/bitcoin?localization=false&tickers=false&community_data=false&developer_data=false&sparkline=false',
    );

    if (kDebugMode) {
      print('🌐 [CoinGeckoService] GET $url');
    }

    final response = await http.get(url);

    if (kDebugMode) {
      print('🌐 [CoinGeckoService] Status code: ${response.statusCode}');
    }

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Crypto.fromJson(data);
    } else {
      throw Exception('Error al obtener datos de CoinGecko. Status: ${response.statusCode}');
    }
  }
}
