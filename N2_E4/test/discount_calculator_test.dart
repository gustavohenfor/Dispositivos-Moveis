import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_desconto/discount_calculator.dart';

void main() {
  group('DiscountCalculator', () {
    test('10% de desconto em R\$ 100', () {
      final resultado = DiscountCalculator.calculate(100, 10);
expect(resultado, 90);
      });

    test('25% de desconto em R\$ 200', () {
      final resultado = DiscountCalculator.calculate(200, 25);
expect(resultado, 150);
    });

    test('0% de desconto em R\$ 50', () {
      final resultado = DiscountCalculator.calculate(50, 0);
expect(resultado, 50);
      });
  });
}
