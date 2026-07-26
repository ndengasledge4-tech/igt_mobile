import 'package:flutter_test/flutter_test.dart';
import 'package:igt/app/app.dart';

void main() {
  testWidgets('displays the IGT splash screen', (tester) async {
    await tester.pumpWidget(const IgtApp());
    expect(find.text('IGT Campus'), findsOneWidget);
  });
}
