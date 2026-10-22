import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalogo_a11y/main.dart';

void main() {
  testWidgets('La pantalla cumple las guías de accesibilidad', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      const MaterialApp(home: PantallaHeladas()),
    );

    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}