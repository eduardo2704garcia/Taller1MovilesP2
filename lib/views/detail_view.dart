import 'package:flutter/cupertino.dart';
import '../models/crypto.dart';
import '../widgets/stat_chip.dart';

class DetailView extends StatelessWidget {
  final Crypto crypto;

  const DetailView({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    final bool isPositive = crypto.priceChangePercentage24h >= 0;

    String formatNumber(double value) {
      if (value >= 1e12) {
        return '\$${(value / 1e12).toStringAsFixed(2)}T';
      } else if (value >= 1e9) {
        return '\$${(value / 1e9).toStringAsFixed(2)}B';
      } else if (value >= 1e6) {
        return '\$${(value / 1e6).toStringAsFixed(2)}M';
      } else if (value >= 1e3) {
        return '\$${(value / 1e3).toStringAsFixed(2)}K';
      }
      return '\$${value.toStringAsFixed(2)}';
    }

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('${crypto.name} (${crypto.symbol})'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card de encabezado
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: CupertinoColors.systemGrey4,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        crypto.imageUrl,
                        width: 60,
                        height: 60,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            CupertinoIcons.bitcoin_circle,
                            size: 60,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            crypto.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.label,
                            ),
                          ),
                          Text(
                            crypto.symbol,
                            style: const TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${crypto.currentPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.label,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          isPositive
                              ? CupertinoIcons.arrow_up_right
                              : CupertinoIcons.arrow_down_right,
                          color: isPositive
                              ? CupertinoColors.systemGreen
                              : CupertinoColors.systemRed,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: isPositive
                                ? CupertinoColors.systemGreen
                                : CupertinoColors.systemRed,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Sección resumen
              const Text(
                'Resumen de mercado',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Datos expresados en dólares estadounidenses (USD) '
                'para el intervalo de las últimas 24 horas.',
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  StatChip(
                    label: 'Ranking',
                    value: '#${crypto.marketCapRank}',
                  ),
                  StatChip(
                    label: 'High 24h',
                    value: '\$${crypto.high24h.toStringAsFixed(2)}',
                  ),
                  StatChip(
                    label: 'Low 24h',
                    value: '\$${crypto.low24h.toStringAsFixed(2)}',
                  ),
                  StatChip(
                    label: 'Market Cap',
                    value: formatNumber(crypto.marketCap),
                  ),
                  StatChip(
                    label: 'Volumen 24h',
                    value: formatNumber(crypto.totalVolume),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Sección suministro
              const Text(
                'Suministro',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Información sobre la cantidad de monedas en circulación y '
                'el suministro máximo estimado.',
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  StatChip(
                    label: 'Circulante',
                    value: crypto.circulatingSupply.toStringAsFixed(0),
                  ),
                  StatChip(
                    label: 'Máximo',
                    value: crypto.maxSupply != null
                        ? crypto.maxSupply!.toStringAsFixed(0)
                        : 'No definido',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Nota
              const Text(
                'Nota',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Esta pantalla muestra información básica de la criptomoneda '
                'seleccionada, obtenida en tiempo real desde la API pública '
                'de CoinGecko. Los valores se actualizan dinámicamente y pueden '
                'cambiar de forma significativa debido a la volatilidad del mercado.',
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.label,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
