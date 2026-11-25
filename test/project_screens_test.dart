import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/screens/project_detail_screen.dart';
import 'package:myportfolio_mobile/screens/project_list_screen.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  Widget wrap(ApiClient api, Widget child) => MultiProvider(
    providers: [
      Provider<ApiClient>.value(value: api),
      ChangeNotifierProvider(create: (_) => AuthState(api)),
    ],
    child: MaterialApp(home: child),
  );
  const data = {
    'title': 'Proyek Satu',
    'description': 'Deskripsi proyek',
    'image_url': '',
    'play_url': 'https://example.test/play',
    'star_count': 3,
    'is_starred': false,
    'starred_by_names': 'Ana',
  };

  testWidgets('loading, list, navigation and detail with empty image', (
    tester,
  ) async {
    final response = Completer<http.Response>();
    final api = ApiClient(client: MockClient((_) => response.future));
    await tester.pumpWidget(wrap(api, const ProjectListScreen()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    response.complete(http.Response(jsonEncode([data]), 200));
    await tester.pumpAndSettle();
    expect(find.text('Proyek Satu'), findsOneWidget);
    expect(find.text('Deskripsi proyek'), findsOneWidget);
    await tester.tap(find.text('Proyek Satu'));
    await tester.pumpAndSettle();
    expect(find.text('URL: https://example.test/play'), findsOneWidget);
    expect(find.text('Star: 3'), findsOneWidget);
    expect(find.text('Disukai oleh: Ana'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });

  testWidgets('empty list can be refreshed', (tester) async {
    var calls = 0;
    final api = ApiClient(
      client: MockClient((_) async {
        calls++;
        return http.Response('[]', 200);
      }),
    );
    await tester.pumpWidget(wrap(api, const ProjectListScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada proyek.'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, 350));
    await tester.pumpAndSettle();
    expect(calls, 2);
  });

  testWidgets('retry after error loads projects', (tester) async {
    var calls = 0;
    final api = ApiClient(
      client: MockClient((_) async {
        calls++;
        return calls == 1
            ? http.Response('private error', 500)
            : http.Response(jsonEncode([data]), 200);
      }),
    );
    await tester.pumpWidget(wrap(api, const ProjectListScreen()));
    await tester.pumpAndSettle();
    expect(find.text('private error'), findsNothing);
    await tester.tap(find.text('Coba lagi'));
    await tester.pumpAndSettle();
    expect(find.text('Proyek Satu'), findsOneWidget);
  });

  testWidgets('relative image path resolves against backend', (tester) async {
    final api = ApiClient(baseUrl: 'https://backend.test');
    const project = Project(
      title: 'Proyek',
      description: 'Deskripsi',
      imageUrl: '/static/a.png',
      playUrl: 'https://example.test',
    );
    await tester.pumpWidget(
      wrap(api, const ProjectDetailScreen(project: project)),
    );
    final image = tester.widget<Image>(find.byType(Image));
    expect(
      (image.image as NetworkImage).url,
      'https://backend.test/static/a.png',
    );
  });
}
