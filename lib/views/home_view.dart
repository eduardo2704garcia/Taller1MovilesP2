import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/crypto_provider.dart';
import '../widgets/crypto_summary_card.dart';
import 'detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CryptoProvider>();
    final crypto = provider.selectedCrypto;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Crypto Widget'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: provider.isLoading
              ? const Center(child: CupertinoActivityIndicator())
              : provider.error != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: CupertinoColors.destructiveRed,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CupertinoButton.filled(
                          onPressed: () {
                            provider.loadCryptos();
                          },
                          child: const Text('Reintentar'),
                        ),
                      ],
                    )
                  : crypto == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No hay datos disponibles.',
                              style: TextStyle(
                                fontSize: 16,
                                color: CupertinoColors.label,
                              ),
                            ),
                            const SizedBox(height: 12),
                            CupertinoButton(
                              onPressed: () {
                                provider.loadCryptos();
                              },
                              child: const Text('Volver a intentar'),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Criptomonedas en tiempo real',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.label,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Vista resumen tipo widget. Toca la tarjeta para ver '
                              'los detalles de la moneda seleccionada.',
                              style: TextStyle(
                                fontSize: 13,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            const SizedBox(height: 16),

                            CryptoSummaryCard(
                              crypto: crypto,
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (_) =>
                                        DetailView(crypto: crypto),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Mostrando: ${crypto.name} (${crypto.symbol})',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  onPressed: () {
                                    provider.nextCrypto();
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrow_2_squarepath,
                                        size: 18,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Cambiar moneda',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  onPressed: () {
                                    provider.loadCryptos();
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        CupertinoIcons.refresh,
                                        size: 18,
                                      ),
                                      SizedBox(width: 6),
                                      Text('Actualizar datos'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
        ),
      ),
    );
  }
}
