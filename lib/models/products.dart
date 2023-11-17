import 'sizes.dart';

class Products {
  String? name;
  String? style;
  String? codeColor;
  String? colorSlug;
  String? color;
  bool onSale=false;
  String? regularPrice;
  String? actualPrice;
  String? discountPercentage;
  String? installments;
  String? image;
  List<Sizes>? sizes;
  int? index;

  Products({
    this.name="",
    this.style="",
    this.codeColor="",
    this.colorSlug="",
    this.color="",
    this.onSale=false,
    this.regularPrice="",
    this.actualPrice="",
    this.discountPercentage="",
    this.installments="",
    this.image="",
    this.sizes,
    this.index
  });

  @override
  String toString() {
    return 'Products(name: $name, style: $style, codeColor: $codeColor, colorSlug: $colorSlug, color: $color, onSale: $onSale, regularPrice: $regularPrice, actualPrice: $actualPrice, discountPercentage: $discountPercentage, installments: $installments, image: $image, sizes: $sizes)';
  }

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        name: json['name'] as String?,
        style: json['style'] as String?,
        codeColor: json['code_color'] as String?,
        colorSlug: json['color_slug'] as String?,
        color: json['color'] as String?,
        onSale: json['on_sale'] as bool,
        regularPrice: json['regular_price'] as String?,
        actualPrice: json['actual_price'] as String?,
        discountPercentage: json['discount_percentage'] as String?,
        installments: json['installments'] as String?,
        image: json['image'] as String?,
        sizes: (json['sizes'] as List<dynamic>?)
            ?.map((e) => Sizes.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'style': style,
        'code_color': codeColor,
        'color_slug': colorSlug,
        'color': color,
        'on_sale': onSale,
        'regular_price': regularPrice,
        'actual_price': actualPrice,
        'discount_percentage': discountPercentage,
        'installments': installments,
        'image': image,
        'sizes': sizes?.map((e) => e.toJson()).toList(),
      };
}
