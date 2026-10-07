import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiffinwala/main.dart';

void main() {
  testWidgets('TiffinWala app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TiffinWalaApp());
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
