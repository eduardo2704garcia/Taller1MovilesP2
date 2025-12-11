import '../models/crypto.dart';
import '../services/coingecko_service.dart';

class CryptoController {
  final CoinGeckoService _service;

  CryptoController(this._service);

  Future<Crypto> getBitcoin() async {
    return await _service.fetchBitcoinData();
  }
}
