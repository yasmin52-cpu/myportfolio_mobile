import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportfolio_mobile/screens/project_form.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  const payload = {
    'title': 'Judul',
    'description': 'Deskripsi',
    'image_url': '/static/gambar.png',
    'play_url': 'https://example.test/play',
  };
  Widget app(ApiClient api, AuthState auth) => MultiProvider(
    providers: [
      Provider<ApiClient>.value(value: api),
      ChangeNotifierProvider<AuthState>.value(value: auth),
    ],
    child: const MaterialApp(home: ProjectFormPage()),
  );

  Future<void> fill(
    WidgetTester tester, {
    String url = 'https://example.test/play',
  }) async {
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Judul Proyek'),
      ' Judul ',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Deskripsi Proyek'),
      ' Deskripsi ',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'URL/Path Gambar'),
      ' /static/gambar.png ',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'URL Proyek / Play URL'),
      url,
    );
    await tester.ensureVisible(find.text('Save'));
  }

  Future<void> save(WidgetTester tester) async {
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pump();
  }

  testWidgets('validates required fields and play URL', (tester) async {
    final api = ApiClient(
      client: MockClient((_) async => http.Response('', 500)),
    );
    await tester.pumpWidget(app(api, AuthState(api, initialToken: 'mock')));
    await save(tester);
    expect(find.text('Field ini wajib diisi.'), findsNWidgets(4));
    await fill(tester, url: 'not-a-url');
    await save(tester);
    expect(
      find.text('Masukkan URL HTTP atau HTTPS yang valid.'),
      findsOneWidget,
    );
  });

  testWidgets('cancelled login does not submit', (tester) async {
    var calls = 0;
    final api = ApiClient(
      client: MockClient((_) async {
        calls++;
        return http.Response('', 500);
      }),
    );
    await tester.pumpWidget(app(api, AuthState(api)));
    await fill(tester);
    await save(tester);
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(calls, 0);
    expect(find.text('Judul'), findsNothing);
    expect(
      tester
          .widget<TextFormField>(
            find.widgetWithText(TextFormField, 'Judul Proyek'),
          )
          .controller!
          .text,
      ' Judul ',
    );
  });

  testWidgets('sends writable fields once and confirms returned project', (
    tester,
  ) async {
    final pending = Completer<http.Response>();
    var calls = 0;
    final api = ApiClient(
      client: MockClient((request) {
        calls++;
        expect(request.method, 'POST');
        expect(request.url.path, '/api/v1/projects/');
        expect(request.headers['authorization'], 'Token mock-token');
        expect(jsonDecode(request.body), payload);
        return pending.future;
      }),
    );
    await tester.pumpWidget(
      app(api, AuthState(api, initialToken: 'mock-token')),
    );
    await fill(tester);
    await save(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
      isNull,
    );
    expect(calls, 1);
    pending.complete(
      http.Response(
        jsonEncode({...payload, 'title': 'Judul dari server'}),
        201,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
    expect(find.text('Judul: Judul dari server'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextFormField>(
            find.widgetWithText(TextFormField, 'Judul Proyek'),
          )
          .controller!
          .text,
      isEmpty,
    );
    expect(
      tester
          .widget<TextFormField>(
            find.widgetWithText(TextFormField, 'URL/Path Gambar'),
          )
          .controller!
          .text,
      isEmpty,
    );
  });

  for (final status in [400, 403, 500]) {
    testWidgets('HTTP $status preserves input and shows failure', (
      tester,
    ) async {
      final api = ApiClient(
        client: MockClient((_) async => http.Response('private', status)),
      );
      final auth = AuthState(api, initialToken: 'mock-token');
      await tester.pumpWidget(app(api, auth));
      await fill(tester);
      await save(tester);
      await tester.pumpAndSettle();
      expect(find.text('Proyek berhasil ditambahkan!'), findsNothing);
      expect(
        find.text(
          status == 400
              ? 'Data tidak valid. Periksa kembali isian proyek.'
              : status == 403
              ? 'Pembuatan proyek memerlukan akun Django superuser.'
              : 'Proyek gagal disimpan. Silakan coba lagi.',
        ),
        findsOneWidget,
      );
      expect(auth.isLoggedIn, isTrue);
      expect(
        tester
            .widget<TextFormField>(
              find.widgetWithText(TextFormField, 'Judul Proyek'),
            )
            .controller!
            .text,
        ' Judul ',
      );
    });
  }

  testWidgets('401 clears session and requests login without resubmitting', (
    tester,
  ) async {
    var posts = 0;
    final api = ApiClient(
      client: MockClient((request) async {
        if (request.url.path.endsWith('/projects/')) {
          posts++;
          return http.Response('', 401);
        }
        return http.Response('', 500);
      }),
    );
    final auth = AuthState(api, initialToken: 'mock-token');
    await tester.pumpWidget(app(api, auth));
    await fill(tester);
    await save(tester);
    await tester.pumpAndSettle();
    expect(auth.isLoggedIn, isFalse);
    expect(find.widgetWithText(TextFormField, 'Username'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(posts, 1);
    expect(
      tester
          .widget<TextFormField>(
            find.widgetWithText(TextFormField, 'Judul Proyek'),
          )
          .controller!
          .text,
      ' Judul ',
    );
    expect(find.text('Proyek berhasil ditambahkan!'), findsNothing);
  });

  testWidgets('network error preserves input without success dialog', (
    tester,
  ) async {
    final api = ApiClient(
      client: MockClient((_) async => throw http.ClientException('network')),
    );
    await tester.pumpWidget(
      app(api, AuthState(api, initialToken: 'mock-token')),
    );
    await fill(tester);
    await save(tester);
    await tester.pumpAndSettle();
    expect(
      find.text('Tidak dapat terhubung. Periksa jaringan dan coba lagi.'),
      findsOneWidget,
    );
    expect(find.text('Proyek berhasil ditambahkan!'), findsNothing);
    expect(
      tester
          .widget<TextFormField>(
            find.widgetWithText(TextFormField, 'Judul Proyek'),
          )
          .controller!
          .text,
      ' Judul ',
    );
  });
}
