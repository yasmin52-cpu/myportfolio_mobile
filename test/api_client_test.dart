import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/services/api_client.dart';

void main() {
  const baseUrl = 'https://example.test/';
  const responseProject = {
    'id': '550e8400-e29b-41d4-a716-446655440000',
    'title': 'Portofolio',
    'description': 'Deskripsi',
    'image_url': '/image.png',
    'play_url': 'https://example.test/play',
    'star_count': 2,
    'is_starred': true,
    'starred_by_names': 'alice, bob',
  };
  const project = Project(
    id: 'server-id',
    title: 'Portofolio',
    description: 'Deskripsi',
    imageUrl: '/image.png',
    playUrl: 'https://example.test/play',
    starCount: 2,
    isStarred: true,
    starredByNames: 'alice, bob',
  );

  test('getProjects sends public GET and parses projects', () async {
    final api = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.toString(), '${baseUrl}api/v1/projects/');
        expect(request.headers['accept'], 'application/json');
        expect(request.headers.containsKey('authorization'), isFalse);
        return http.Response.bytes(
          utf8.encode(jsonEncode([responseProject])),
          200,
        );
      }),
    );
    final result = await api.getProjects();
    expect(result.single.id, responseProject['id']);
    expect(result.single.starredByNames, 'alice, bob');
    expect(result.single.starCount, 2);
  });

  test('getProjects handles empty lists and other successful 2xx', () async {
    final api = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((_) async => http.Response('[]', 202)),
    );
    expect(await api.getProjects(), isEmpty);
  });

  test('getProjects throws ApiException for HTTP errors', () async {
    final api = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((_) async => http.Response('error', 500)),
    );
    await expectLater(
      api.getProjects(),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 500),
      ),
    );
  });

  test('createProject posts writable fields and parses 201', () async {
    final api = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.toString(), '${baseUrl}api/v1/projects/');
        expect(request.headers['authorization'], 'Token mock-token');
        expect(request.headers['accept'], 'application/json');
        expect(
          request.headers['content-type'],
          'application/json; charset=UTF-8',
        );
        expect(jsonDecode(request.body), {
          'title': 'Portofolio',
          'description': 'Deskripsi',
          'image_url': '/image.png',
          'play_url': 'https://example.test/play',
        });
        return http.Response(jsonEncode(responseProject), 201);
      }),
    );
    final result = await api.createProject(project, token: 'mock-token');
    expect(result.id, responseProject['id']);
    expect(result.isStarred, isTrue);
  });

  for (final status in [401, 403]) {
    test('createProject reports HTTP $status', () async {
      final api = ApiClient(
        baseUrl: baseUrl,
        client: MockClient((_) async => http.Response('error', status)),
      );
      await expectLater(
        api.createProject(project, token: 'mock-token'),
        throwsA(
          isA<ApiException>().having((e) => e.statusCode, 'statusCode', status),
        ),
      );
    });
  }

  test('obtainToken posts credentials and extracts token', () async {
    final api = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.toString(), '${baseUrl}api/v1/auth/token/');
        expect(request.headers['accept'], 'application/json');
        expect(
          request.headers['content-type'],
          'application/json; charset=UTF-8',
        );
        expect(jsonDecode(request.body), {
          'username': 'mock-user',
          'password': 'mock-password',
        });
        return http.Response('{"token":"mock-token"}', 200);
      }),
    );
    expect(await api.obtainToken('mock-user', 'mock-password'), 'mock-token');
  });

  test('obtainToken reports unsuccessful login', () async {
    final api = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((_) async => http.Response('invalid', 400)),
    );
    await expectLater(
      api.obtainToken('mock-user', 'mock-password'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 400),
      ),
    );
  });

  test('logout posts token and accepts empty 204', () async {
    final api = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.toString(), '${baseUrl}api/v1/auth/logout/');
        expect(request.headers['authorization'], 'Token mock-token');
        return http.Response('', 204);
      }),
    );
    await api.logout(token: 'mock-token');
  });

  test('logout reports HTTP errors', () async {
    final api = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((_) async => http.Response('error', 401)),
    );
    await expectLater(
      api.logout(token: 'mock-token'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 401),
      ),
    );
  });
}
