import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/screens/project_form.dart';
import 'package:myportfolio_mobile/screens/experience_form.dart';
import 'package:myportfolio_mobile/screens/project_list_screen.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  Widget app(AuthState auth, ApiClient api) => MultiProvider(
    providers: [
      Provider<ApiClient>.value(value: api),
      ChangeNotifierProvider<AuthState>.value(value: auth),
    ],
    child: MaterialApp(home: MyHomePage()),
  );

  ApiClient api({bool logoutFails = false}) => ApiClient(
    client: MockClient((request) async {
      if (request.url.path.endsWith('/token/')) {
        return http.Response('{"token":"mock-token"}', 200);
      }
      if (request.url.path.endsWith('/logout/')) {
        return http.Response('', logoutFails ? 500 : 204);
      }
      return http.Response('[]', 200);
    }),
  );

  testWidgets('public list and experience remain available', (tester) async {
    final client = api();
    final auth = AuthState(client);
    await tester.pumpWidget(app(auth, client));
    expect(find.text('Login'), findsOneWidget);
    await tester.tap(find.text('Lihat Proyek'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectListScreen), findsOneWidget);
    Navigator.of(tester.element(find.byType(ProjectListScreen))).pop();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tambah Pengalaman'));
    await tester.pumpAndSettle();
    expect(find.byType(ExperienceFormPage), findsOneWidget);
  });

  testWidgets('project guard handles cancel and successful login', (
    tester,
  ) async {
    final client = api();
    final auth = AuthState(client);
    await tester.pumpWidget(app(auth, client));
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField, 'Username'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsNothing);
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
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
    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(auth.isLoggedIn, isTrue);
  });

  testWidgets('authenticated project form opens directly', (tester) async {
    final client = api();
    final auth = AuthState(client, initialToken: 'mock-token');
    await tester.pumpWidget(app(auth, client));
    expect(find.text('Logout'), findsOneWidget);
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Username'), findsNothing);
  });

  for (final failure in [false, true]) {
    testWidgets(
      'logout ${failure ? 'failure' : 'success'} clears session and updates drawer',
      (tester) async {
        final client = api(logoutFails: failure);
        final auth = AuthState(client, initialToken: 'mock-token');
        await tester.pumpWidget(app(auth, client));
        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle();
        expect(auth.isLoggedIn, isFalse);
        expect(find.text('Login'), findsOneWidget);
        expect(
          find.text(
            failure
                ? 'Sesi lokal telah dihapus, tetapi pencabutan token di server belum dapat dipastikan.'
                : 'Logout berhasil.',
          ),
          findsOneWidget,
        );
        await tester.tap(find.byTooltip('Open navigation menu'));
        await tester.pumpAndSettle();
        expect(
          find.descendant(
            of: find.byType(Drawer),
            matching: find.text('Login'),
          ),
          findsOneWidget,
        );
      },
    );
  }

  testWidgets('drawer guards add project and permits cancellation', (
    tester,
  ) async {
    final client = api();
    final auth = AuthState(client);
    await tester.pumpWidget(app(auth, client));
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField, 'Username'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsNothing);
  });
}
