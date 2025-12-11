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

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'] ?? '',
      symbol: (json['symbol'] ?? '').toString().toUpperCase(),
      name: json['name'] ?? '',
      imageUrl: json['image']?['large'] ??
          json['image']?['small'] ??
          json['image']?['thumb'] ??
          '',
      currentPrice: (json['market_data']?['current_price']?['usd'] ?? 0).toDouble(),
      priceChange24h:
          (json['market_data']?['price_change_24h_in_currency']?['usd'] ?? 0).toDouble(),
      priceChangePercentage24h:
          (json['market_data']?['price_change_percentage_24h_in_currency']?['usd'] ?? 0)
              .toDouble(),
      marketCapRank: (json['market_cap_rank'] ?? 0) is int
          ? json['market_cap_rank']
          : 0,
      high24h: (json['market_data']?['high_24h']?['usd'] ?? 0).toDouble(),
      low24h: (json['market_data']?['low_24h']?['usd'] ?? 0).toDouble(),
      marketCap: (json['market_data']?['market_cap']?['usd'] ?? 0).toDouble(),
      totalVolume: (json['market_data']?['total_volume']?['usd'] ?? 0).toDouble(),
      circulatingSupply:
          (json['market_data']?['circulating_supply'] ?? 0).toDouble(),
      maxSupply: json['market_data']?['max_supply'] != null
          ? (json['market_data']?['max_supply']).toDouble()
          : null,
    );
  }
}
