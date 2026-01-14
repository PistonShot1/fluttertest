import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class Product with _$Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  @JsonKey(name: 'id')
  @override
  final int? id;

  @JsonKey(name: 'title')
  @override
  final String? title;

  @JsonKey(name: 'price')
  @override
  final double? price;

  @JsonKey(name: 'description')
  @override
  final String? description;

  @JsonKey(name: 'category')
  @override
  final String? category;

  @JsonKey(name: 'image')
  @override
  final String? image;

  @JsonKey(name: 'rating')
  @override
  final Rating? rating;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);

  Map<String, Object?> toJson() => _$ProductToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class Rating with _$Rating {
  const Rating({required this.rate, required this.count});

  @JsonKey(name: 'rate')
  @override
  final double? rate;

  @JsonKey(name: 'count')
  @override
  final int? count;

  factory Rating.fromJson(Map<String, Object?> json) => _$RatingFromJson(json);

  Map<String, Object?> toJson() => _$RatingToJson(this);
}
