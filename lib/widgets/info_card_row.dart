import 'package:flutter/material.dart';
import '../models/crypto.dart';

class InfoCardRow extends StatelessWidget {
  final Crypto crypto;

  const InfoCardRow({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      _Metric(
        title: 'Precio Actual',
        value: '\$${crypto.currentPrice.toStringAsFixed(2)}',
        icon: Icons.attach_money,
        color: Colors.green.shade600,
      ),
      _Metric(
        title: 'Cambio 24h',
        value: '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
        icon: crypto.priceChangePercentage24h >= 0
            ? Icons.trending_up
            : Icons.trending_down,
        color: crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
      ),
      _Metric(
        title: 'Máximo 24h',
        value: '\$${crypto.high24h.toStringAsFixed(2)}',
        icon: Icons.arrow_circle_up,
        color: Colors.orange.shade700,
      ),
      _Metric(
        title: 'Mínimo 24h',
        value: '\$${crypto.low24h.toStringAsFixed(2)}',
        icon: Icons.arrow_circle_down,
        color: Colors.blue.shade800,
      ),
      _Metric(
        title: 'Market Cap',
        value: crypto.marketCap.toStringAsFixed(0),
        icon: Icons.pie_chart,
        color: Colors.purple.shade700,
      ),
      _Metric(
        title: 'Volumen Total',
        value: crypto.totalVolume.toStringAsFixed(0),
        icon: Icons.bar_chart,
        color: Colors.blue.shade600,
      ),
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: metrics.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final m = metrics[index];
          return Container(
            width: 160,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: m.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: m.color, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(m.icon, size: 28, color: m.color),
                const SizedBox(height: 6),
                Text(
                  m.title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: m.color),
                ),
                Text(
                  m.value,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Metric {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  _Metric({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}
