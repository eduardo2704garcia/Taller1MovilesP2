import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crypto_provider.dart';
import '../models/crypto.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Color _colorForCrypto(String id) {
    switch (id) {
      case 'bitcoin':
        return const Color(0xFFFFA800); // naranja
      case 'ethereum':
        return const Color(0xFF627EEA); // azul ETH
      case 'solana':
        return const Color(0xFF14F195); // verde SOL
      default:
        return Colors.grey;
    }
  }

  IconData _iconForCrypto(String id) {
    switch (id) {
      case 'bitcoin':
        return Icons.currency_bitcoin;
      case 'ethereum':
        return Icons.token;
      case 'solana':
        return Icons.blur_circular;
      default:
        return Icons.monetization_on;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CryptoProvider>(context);
    final List<Crypto> cryptos = provider.cryptos;
    final Crypto? selected = provider.selectedCrypto;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Crypto Tracker',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : cryptos.isEmpty
          ? const Center(
              child: Text(
                'No hay datos disponibles.',
                style: TextStyle(color: Colors.white),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// SWITCHER DE CRYPTOS CON ICONOS
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: cryptos.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final c = cryptos[index];
                        final isSelected = index == provider.selectedIndex;
                        final color = _colorForCrypto(c.id);

                        return GestureDetector(
                          onTap: () {
                            provider.nextCrypto();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 75,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? color.withOpacity(0.25)
                                  : Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? color : Colors.white24,
                                width: 1.3,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _iconForCrypto(c.id),
                                  color: isSelected ? color : Colors.white54,
                                  size: 28,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  c.symbol,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isSelected ? color : Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (selected != null)
                    /// CARD PRINCIPAL CUADRADA
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/detail');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _colorForCrypto(selected.id),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                selected.imageUrl,
                                width: 60,
                                height: 60,
                              ),
                            ),
                            const SizedBox(width: 16),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selected.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  selected.symbol,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '\$${selected.currentPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: _colorForCrypto(selected.id),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
