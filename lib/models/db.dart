import 'products.dart';

class Db {
  List<Products>? products;

  Db({this.products});

  @override
  String toString() => 'Db(products: $products)';

  factory Db.fromJson(Map<String, dynamic> json) => Db(
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'products': products?.map((e) => e.toJson()).toList(),
      };
}
