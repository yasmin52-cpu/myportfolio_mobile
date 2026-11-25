import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/screens/project_detail_screen.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = context.read<ApiClient>().getProjects();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getProjects();
    setState(() {
      _projectsFuture = future;
    });
    try {
      await future;
    } catch (_) {
      // FutureBuilder displays the error without leaking it from onRefresh.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Proyek')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Tidak dapat memuat proyek. Silakan coba lagi.'),
                  ElevatedButton(
                    onPressed: _reload,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            );
          }
          final projects = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _reload,
            child: projects.isEmpty
                ? LayoutBuilder(
                    builder: (context, constraints) => ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: constraints.maxHeight,
                          child: const Center(child: Text('Belum ada proyek.')),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return Card(
                        child: ListTile(
                          title: Text(project.title),
                          subtitle: Text(project.description),
                          trailing: Text('★ ${project.starCount}'),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProjectDetailScreen(project: project),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
