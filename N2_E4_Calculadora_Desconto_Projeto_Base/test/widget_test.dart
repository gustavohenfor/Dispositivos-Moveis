import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_desconto/main.dart';

void main() {
  testWidgets(
    'Calcula desconto pela interface',
    (WidgetTester tester) async {
      await tester.pumpWidget(const DiscountApp());

      // TODO 1: digite 100 no campo identificado pela Key 'valueField'.

      // TODO 2: digite 10 no campo identificado pela Key 'discountField'.

      // TODO 3: toque no botão identificado pela Key 'calculateButton'.

      // TODO 4: atualize a interface com pump().

      // TODO 5: verifique com expect() se o texto
      // 'Valor final: R$ 90.00' aparece na tela.
    },
  );
}
