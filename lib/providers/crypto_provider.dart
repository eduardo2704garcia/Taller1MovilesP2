import 'package:flutter/foundation.dart';
import '../controllers/crypto_controller.dart';
import '../models/crypto.dart';

class CryptoProvider extends ChangeNotifier {
  final CryptoController controller;

  CryptoProvider({required this.controller}) {
    loadCryptos();
  }

  List<Crypto> _cryptos = [];
  int _selectedIndex = 0;

  List<Crypto> get cryptos => _cryptos;
  int get selectedIndex => _selectedIndex;

  Crypto? get selectedCrypto =>
      _cryptos.isNotEmpty ? _cryptos[_selectedIndex] : null;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadCryptos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (kDebugMode) {
        print('🔄 [CryptoProvider] Cargando datos de criptomonedas...');
      }

      final data = await controller.getTopCryptos();
      _cryptos = data;

      if (_cryptos.isNotEmpty && _selectedIndex >= _cryptos.length) {
        _selectedIndex = 0;
      }

      if (kDebugMode) {
        print('✅ [CryptoProvider] Datos cargados. Total: ${_cryptos.length}');
      }
    } catch (e, s) {
      _error = 'ERROR: $e';
      if (kDebugMode) {
        print('❌ [CryptoProvider] Error al cargar criptos: $e');
        print(s);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void nextCrypto() {
    if (_cryptos.isEmpty) return;
    _selectedIndex = (_selectedIndex + 1) % _cryptos.length;
    notifyListeners();
  }
}
