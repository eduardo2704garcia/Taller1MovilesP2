import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/crypto.dart';

class CoinGeckoService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<Crypto>> fetchMarketData(List<String> ids) async {
    final idsParam = ids.join(',');

    final url = Uri.parse(
      '$_baseUrl/coins/markets'
      '?vs_currency=usd'
      '&ids=$idsParam'
      '&order=market_cap_desc'
      '&per_page=${ids.length}'
      '&page=1'
      '&sparkline=false'
      '&price_change_percentage=24h',
    );

    if (kDebugMode) {
      print('🌐 [CoinGeckoService] GET $url');
    }

    final response = await http.get(url);

    if (kDebugMode) {
      print('🌐 [CoinGeckoService] Status code: ${response.statusCode}');
    }

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body is List) {
        return body
            .map((jsonItem) => Crypto.fromJson(jsonItem as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Respuesta inesperada de CoinGecko (no es lista)');
      }
    } else {
      throw Exception(
        'Error al obtener datos de CoinGecko. Status: ${response.statusCode}',
      );
    }
  }
}
