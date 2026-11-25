import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportfolio_mobile/main.dart';
import 'package:myportfolio_mobile/services/api_client.dart';

void main() {
  testWidgets('homepage displays its menu', (tester) async {
    final api = ApiClient(
      client: MockClient((_) async => http.Response('[]', 200)),
    );
    await tester.pumpWidget(MyApp(apiClient: api));
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Pengalaman'), findsOneWidget);
  });
}
