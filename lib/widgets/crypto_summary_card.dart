import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                crypto.imageUrl,
                width: 40,
                height: 40,
                errorBuilder: (_, __, ___) => const Icon(
                  CupertinoIcons.bitcoin_circle,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${crypto.name} (${crypto.symbol})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${crypto.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  isPositive
                      ? CupertinoIcons.arrow_up_right
                      : CupertinoIcons.arrow_down_right,
                  size: 18,
                  color:
                      isPositive ? CupertinoColors.systemGreen : CupertinoColors.systemRed,
                ),
                const SizedBox(height: 4),
                Text(
                  '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 13,
                    color: isPositive
                        ? CupertinoColors.systemGreen
                        : CupertinoColors.systemRed,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
