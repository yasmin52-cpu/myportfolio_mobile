import 'package:flutter_test/flutter_test.dart';
import 'package:myportfolio_mobile/models/project.dart';

void main() {
  test('parses the Django response and sends only writable fields', () {
    final project = Project.fromJson({
      'id': '550e8400-e29b-41d4-a716-446655440000',
      'title': 'Portfolio',
      'description': 'A project',
      'image_url': '/images/project.png',
      'play_url': 'https://example.com/project',
      'star_count': 2,
      'is_starred': true,
      'starred_by_names': 'alice, bob',
    });

    expect(project.id, '550e8400-e29b-41d4-a716-446655440000');
    expect(project.imageUrl, '/images/project.png');
    expect(project.playUrl, 'https://example.com/project');
    expect(project.starCount, 2);
    expect(project.isStarred, isTrue);
    expect(project.starredByNames, 'alice, bob');
    expect(project.toJson(), {
      'title': 'Portfolio',
      'description': 'A project',
      'image_url': '/images/project.png',
      'play_url': 'https://example.com/project',
    });
  });

  test('defaults server-managed star fields when absent', () {
    final project = Project.fromJson({
      'title': 'Portfolio',
      'description': 'A project',
      'image_url': '/images/project.png',
      'play_url': 'https://example.com/project',
    });

    expect(project.id, isNull);
    expect(project.starCount, 0);
    expect(project.isStarred, isFalse);
    expect(project.starredByNames, isEmpty);
  });

  test('rejects missing required writable fields', () {
    expect(() => Project.fromJson({}), throwsA(isA<TypeError>()));
  });
}
