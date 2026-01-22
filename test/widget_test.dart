import 'package:ai_study_companion/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:studyora/main.dart';

void main() {
  testWidgets('App launches', (WidgetTester tester) async {
    await tester.pumpWidget(const StudyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
