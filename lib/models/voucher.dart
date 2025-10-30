class Voucher {
  final int id;
  final String image;
  final String name;
  final String description;
  final double discountInPercent;
  final double discountPrice;
  final double price;

  Voucher({
    this.id = 0,
    this.image = "",
    this.name = "x1",
    this.discountPrice = 0,
    this.discountInPercent = 0,
    this.price = 0,
    this.description = "",
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      discountInPercent:
          double.tryParse(json['discount_in_percent'].toString()) ?? 0.0,
      discountPrice: double.tryParse(json['discount_price'].toString()) ?? 0.0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] ?? "",
    );
  }
}
