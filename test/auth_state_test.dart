import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';

void main() {
  test('login stores token and logout clears it with notifications', () async {
    final api = ApiClient(
      client: MockClient(
        (request) async => request.url.path.contains('token')
            ? http.Response('{"token":"mock-token"}', 200)
            : http.Response('', 204),
      ),
    );
    final auth = AuthState(api);
    var notifications = 0;
    auth.addListener(() => notifications++);
    await auth.login('mock-user', 'mock-password');
    expect(auth.token, 'mock-token');
    expect(auth.isLoggedIn, isTrue);
    expect(notifications, 1);
    await auth.logout();
    expect(auth.token, isNull);
    expect(auth.isLoggedIn, isFalse);
    expect(notifications, 2);
    auth.dispose();
  });

  test('failed login does not change state or notify', () async {
    final auth = AuthState(
      ApiClient(client: MockClient((_) async => http.Response('error', 400))),
    );
    var notifications = 0;
    auth.addListener(() => notifications++);
    await expectLater(
      auth.login('mock-user', 'mock-password'),
      throwsA(isA<ApiException>()),
    );
    expect(auth.token, isNull);
    expect(notifications, 0);
    auth.dispose();
  });

  test('failed logout still clears token and notifies', () async {
    final auth = AuthState(
      ApiClient(client: MockClient((_) async => http.Response('error', 500))),
      initialToken: 'mock-token',
    );
    var notifications = 0;
    auth.addListener(() => notifications++);
    await expectLater(auth.logout(), throwsA(isA<ApiException>()));
    expect(auth.isLoggedIn, isFalse);
    expect(notifications, 1);
    auth.dispose();
  });
}
