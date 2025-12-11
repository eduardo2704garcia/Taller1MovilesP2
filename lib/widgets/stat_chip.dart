import 'package:flutter/cupertino.dart';
import '../widgets/crypto_colors.dart';

class StatChip extends StatelessWidget {
  final String label;
  final String value;
  final String symbol;

  const StatChip({
    super.key,
    required this.label,
    required this.value,
    required this.symbol,
  });

  IconData _iconForLabel() {
    switch (label) {
      case "Ranking":
        return CupertinoIcons.number;
      case "High 24h":
        return CupertinoIcons.arrow_up;
      case "Low 24h":
        return CupertinoIcons.arrow_down;
      case "Market Cap":
        return CupertinoIcons.graph_square;
      case "Volumen 24h":
        return CupertinoIcons.chart_bar;
      case "Circulante":
        return CupertinoIcons.circle_fill;
      case "Máximo":
        return CupertinoIcons.arrow_up_bin;
      default:
        return CupertinoIcons.info_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = CryptoTheme.getColor(symbol);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_iconForLabel(), size: 18, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: color)),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
