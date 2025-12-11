import 'package:flutter/cupertino.dart';
import '../models/crypto.dart';

class CryptoSummaryCard extends StatelessWidget {
  final Crypto crypto;
  final VoidCallback onTap;

  const CryptoSummaryCard({
    super.key,
    required this.crypto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = crypto.priceChangePercentage24h >= 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              CupertinoColors.systemIndigo,
              CupertinoColors.systemBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: CupertinoColors.systemGrey4,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icono / logo
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                crypto.imageUrl,
                width: 44,
                height: 44,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    CupertinoIcons.bitcoin_circle,
                    size: 44,
                    color: CupertinoColors.white,
                  );
                },
              ),
            ),
            const SizedBox(width: 14),
            // Nombre y precio
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${crypto.name} (${crypto.symbol})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: CupertinoColors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${crypto.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Variación y hint
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      isPositive
                          ? CupertinoIcons.arrow_up_right
                          : CupertinoIcons.arrow_down_right,
                      size: 18,
                      color: isPositive
                          ? CupertinoColors.systemGreen
                          : CupertinoColors.systemRed,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isPositive
                            ? CupertinoColors.systemGreen
                            : CupertinoColors.systemRed,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Toca para ver detalles',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
