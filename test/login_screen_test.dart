import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:myportfolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

void main() {
  Widget app(AuthState auth) => ChangeNotifierProvider<AuthState>.value(
    value: auth,
    child: MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () async {
              final result = await ensureLoggedIn(context);
              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('result: $result')));
              }
            },
            child: const Text('Open guard'),
          ),
        ),
      ),
    ),
  );

  Future<void> openLogin(WidgetTester tester) async {
    await tester.tap(find.text('Open guard'));
    await tester.pumpAndSettle();
  }

  testWidgets('guard immediately succeeds for authenticated user', (
    tester,
  ) async {
    final auth = AuthState(
      ApiClient(client: MockClient((_) async => http.Response('', 500))),
      initialToken: 'mock-token',
    );
    await tester.pumpWidget(app(auth));
    await openLogin(tester);
    expect(find.text('result: true'), findsOneWidget);
    expect(find.byType(TextFormField), findsNothing);
  });

  testWidgets('cancelled login returns false', (tester) async {
    final auth = AuthState(
      ApiClient(client: MockClient((_) async => http.Response('', 500))),
    );
    await tester.pumpWidget(app(auth));
    await openLogin(tester);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('result: false'), findsOneWidget);
  });

  testWidgets('validates fields and logs in once', (tester) async {
    final response = Completer<http.Response>();
    var calls = 0;
    final auth = AuthState(
      ApiClient(
        client: MockClient((_) {
          calls++;
          return response.future;
        }),
      ),
    );
    await tester.pumpWidget(app(auth));
    await openLogin(tester);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    expect(find.text('Username wajib diisi.'), findsOneWidget);
    expect(find.text('Password wajib diisi.'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'mock-user',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'mock-password',
    );
    expect(
      tester
          .widget<EditableText>(
            find.descendant(
              of: find.widgetWithText(TextFormField, 'Password'),
              matching: find.byType(EditableText),
            ),
          )
          .obscureText,
      isTrue,
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(calls, 1);
    expect(
      tester.widget<ElevatedButton>(find.byType(ElevatedButton).last).onPressed,
      isNull,
    );
    response.complete(http.Response('{"token":"mock-token"}', 200));
    await tester.pumpAndSettle();
    expect(auth.isLoggedIn, isTrue);
    expect(find.text('result: true'), findsOneWidget);
  });

  testWidgets('failed login shows friendly message', (tester) async {
    final auth = AuthState(
      ApiClient(
        client: MockClient((_) async => http.Response('private response', 400)),
      ),
    );
    await tester.pumpWidget(app(auth));
    await openLogin(tester);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'mock-user',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'mock-password',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();
    expect(find.text('Username atau password tidak valid.'), findsOneWidget);
    expect(find.text('private response'), findsNothing);
    expect(auth.isLoggedIn, isFalse);
  });
}
