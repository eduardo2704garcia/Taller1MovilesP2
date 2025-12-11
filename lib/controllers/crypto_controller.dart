import '../models/crypto.dart';
import '../services/coingecko_service.dart';

class CryptoController {
  final CoinGeckoService _service;

  CryptoController(this._service);

  /// Lista de criptomonedas que se mostrarán en el widget
  static const List<String> cryptoIds = [
    'bitcoin',
    'ethereum',
    'solana',
  ];

  /// Obtiene los datos completos del mercado para las criptos seleccionadas
  Future<List<Crypto>> getTopCryptos() async {
    return _service.fetchMarketData(cryptoIds);
  }
}
