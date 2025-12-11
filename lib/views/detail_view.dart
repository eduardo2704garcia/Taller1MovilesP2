import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/crypto.dart';
import '../providers/crypto_provider.dart';
import '../widgets/info_card_row.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CryptoProvider>(context);
    final Crypto? crypto = provider.selectedCrypto;

    if (crypto == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'No hay datos disponibles',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(crypto.name, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGEN + NOMBRE + PRECIO
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(crypto.imageUrl, width: 70, height: 70),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crypto.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      crypto.symbol,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${crypto.currentPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// ROW HORIZONTAL DE CARDS
            InfoCardRow(crypto: crypto),

            const SizedBox(height: 25),

            /// EXTRA (opcional): descripción corta
            Text(
              'Información de mercado',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aquí puedes ver estadísticas clave de ${crypto.name} como precio, volumen, '
              'máximo y mínimo del día, además de su capitalización de mercado.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
