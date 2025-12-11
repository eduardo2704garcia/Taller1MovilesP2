import 'package:flutter/foundation.dart';
import '../controllers/crypto_controller.dart';
import '../models/crypto.dart';

class CryptoProvider extends ChangeNotifier {
  final CryptoController controller;

  CryptoProvider({required this.controller}) {
    // Cargar Bitcoin automáticamente cuando se crea el provider
    loadBitcoin();
  }

  Crypto? _crypto;
  Crypto? get crypto => _crypto;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadBitcoin() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (kDebugMode) {
        print('🔄 [CryptoProvider] Cargando datos de Bitcoin...');
      }
      final data = await controller.getBitcoin();
      _crypto = data;
      if (kDebugMode) {
        print('✅ [CryptoProvider] Datos cargados correctamente');
      }
    } catch (e) {
      _error = 'No se pudo cargar la información. Intenta de nuevo.';
      if (kDebugMode) {
        print('❌ [CryptoProvider] Error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
