import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sukmaapps/main_flavor.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  testWidgets('SukmaApp shows app bar and active flavor', (tester) async {
    await tester.pumpWidget(const SukmaApp(flavor: AppFlavor.dev));
    await tester.pumpAndSettle();

    expect(find.text('Sukma Apps'), findsOneWidget);
    expect(find.textContaining('Active flavor: DEV'), findsOneWidget);
  });
}
