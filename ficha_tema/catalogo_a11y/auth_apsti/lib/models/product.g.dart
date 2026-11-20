// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  productId: (json['product_id'] as num).toInt(),
  productName: json['product_name'] as String,
  unitPrice: (json['unit_price'] as num).toDouble(),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'product_id': instance.productId,
  'product_name': instance.productName,
  'unit_price': instance.unitPrice,
};
