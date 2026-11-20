import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:auth_apsti/models/product.dart';

void main() {
  test('Product lee claves snake_case sin @JsonKey', () {
    const raw = '{"product_id":7,"product_name":"Cuaderno A4","unit_price":3.5}';
    final p = Product.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(p.productId, 7);
    expect(p.productName, 'Cuaderno A4');
    expect(p.unitPrice, 3.5);

    expect(p.toJson()['product_id'], 7);
    expect(p.toJson()['product_name'], 'Cuaderno A4');
    expect(p.toJson()['unit_price'], 3.5);
  });
}
