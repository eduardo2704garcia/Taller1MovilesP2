import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'controllers/crypto_controller.dart';
import 'providers/crypto_provider.dart';
import 'services/coingecko_service.dart';
import 'views/home_view.dart';

void main() {
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final service = CoinGeckoService();
    final controller = CryptoController(service);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CryptoProvider(controller: controller),
        ),
      ],
      child: const CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Widget',
        home: HomeView(),
      ),
    );
  }
}
