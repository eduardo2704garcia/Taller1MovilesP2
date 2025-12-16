class Crypto {
  final String id;
  final String symbol;
  final String name;
  final String imageUrl;
  final double currentPrice;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final int marketCapRank;
  final double high24h;
  final double low24h;
  final double marketCap;
  final double totalVolume;
  final double circulatingSupply;
  final double? maxSupply;

  Crypto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.imageUrl,
    required this.currentPrice,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.marketCapRank,
    required this.high24h,
    required this.low24h,
    required this.marketCap,
    required this.totalVolume,
    required this.circulatingSupply,
    required this.maxSupply,
  });

  // Helper para convertir a double de forma segura
  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'] ?? '',
      symbol: (json['symbol'] ?? '').toString().toUpperCase(),
      name: json['name'] ?? '',
      imageUrl: json['image'] ?? '',
      currentPrice: _toDouble(json['current_price']),
      priceChange24h: _toDouble(json['price_change_24h']),
      priceChangePercentage24h:
          _toDouble(json['price_change_percentage_24h']),
      marketCapRank: _toInt(json['market_cap_rank']),
      high24h: _toDouble(json['high_24h']),
      low24h: _toDouble(json['low_24h']),
      marketCap: _toDouble(json['market_cap']),
      totalVolume: _toDouble(json['total_volume']),
      circulatingSupply: _toDouble(json['circulating_supply']),
      maxSupply: json['max_supply'] != null
          ? _toDouble(json['max_supply'])
          : null,
    );
  }

  Map<String, dynamic> toJsonShort() {
    return {
      'id': id,
      'name': name,
      'price': '\$${currentPrice.toStringAsFixed(2)}',
      'image': imageUrl,
    };
  }
}
