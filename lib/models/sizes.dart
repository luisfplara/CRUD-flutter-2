class Sizes {
  bool? available;
  String? size;
  String? sku;

  Sizes({this.available, this.size, this.sku});

  @override
  String toString() {
    return 'Sizes(available: $available, size: $size, sku: $sku)';
  }

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        available: json['available'] as bool?,
        size: json['size'] as String?,
        sku: json['sku'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'available': available,
        'size': size,
        'sku': sku,
      };
}
