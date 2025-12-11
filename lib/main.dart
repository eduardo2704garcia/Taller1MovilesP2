import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/crypto_controller.dart';
import 'providers/crypto_provider.dart';
import 'services/coingecko_service.dart';
import 'views/home_view.dart';
import 'views/detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              CryptoProvider(controller: CryptoController(CoinGeckoService())),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),

        /// AQUI VAN LAS RUTAS
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeView(),
          '/detail': (context) => const DetailView(),
        },
      ),
    );
  }
}
