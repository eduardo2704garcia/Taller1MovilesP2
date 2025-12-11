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

    return CupertinoPageScaffold(
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
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 12),
                        CupertinoButton.filled(
                          onPressed: () {
                            provider.loadBitcoin();
                          },
                          child: const Text('Reintentar'),
                        ),
                      ],
                    )
                  : provider.crypto == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No hay datos disponibles.',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            CupertinoButton(
                              onPressed: () {
                                provider.loadBitcoin();
                              },
                              child: const Text('Volver a intentar'),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Widget informativo',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CryptoSummaryCard(
                              crypto: provider.crypto!,
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (_) =>
                                        DetailView(crypto: provider.crypto!),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            CupertinoButton(
                              onPressed: () {
                                provider.loadBitcoin();
                              },
                              child: const Text('Actualizar información'),
                            ),
                          ],
                        ),
        ),
      ),
    );
  }
}
