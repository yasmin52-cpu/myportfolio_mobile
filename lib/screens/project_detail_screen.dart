import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:provider/provider.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final imagePath = project.imageUrl.trim();
    Uri? imageUri;
    if (imagePath.isNotEmpty) {
      final base = Uri.tryParse(context.read<ApiClient>().baseUrl);
      final reference = Uri.tryParse(imagePath);
      if (base != null && reference != null) {
        imageUri = base.resolveUri(reference);
        if (!['http', 'https'].contains(imageUri.scheme) ||
            imageUri.host.isEmpty) {
          imageUri = null;
        }
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagePath.isNotEmpty)
              if (imageUri == null)
                const Text('Gambar tidak tersedia.')
              else
                Image.network(
                  imageUri.toString(),
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('Gambar tidak tersedia.'),
                ),
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(project.description),
            const SizedBox(height: 12),
            Text('URL: ${project.playUrl}'),
            Text('Star: ${project.starCount}'),
            if (project.starredByNames.isNotEmpty)
              Text('Disukai oleh: ${project.starredByNames}'),
          ],
        ),
      ),
    );
  }
}
