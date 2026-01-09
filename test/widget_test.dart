import 'package:flutter_test/flutter_test.dart';

import 'package:hirakata/app/app.dart';

void main() {
  testWidgets('App shows kana selection', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Kana'), findsOneWidget);
  });
}
