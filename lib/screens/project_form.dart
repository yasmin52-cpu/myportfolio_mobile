import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:myportfolio_mobile/widgets/auth_guard.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _image = TextEditingController();
  final _play = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _image.dispose();
    _play.dispose();
    super.dispose();
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Field ini wajib diisi.' : null;

  void _message(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      final allowed = await ensureLoggedIn(context);
      if (!mounted || !allowed) return;
      final token = context.read<AuthState>().token;
      if (token == null) return;
      final project = Project(
        title: _title.text.trim(),
        description: _description.text.trim(),
        imageUrl: _image.text.trim(),
        playUrl: _play.text.trim(),
      );
      final created = await context.read<ApiClient>().createProject(
        project,
        token: token,
      );
      if (!mounted) return;
      _formKey.currentState!.reset();
      _title.clear();
      _description.clear();
      _image.clear();
      _play.clear();
      setState(() => _submitting = false);
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Judul: ${created.title}'),
                Text('Deskripsi: ${created.description}'),
                Text('URL/Path Gambar: ${created.imageUrl}'),
                Text('URL Proyek: ${created.playUrl}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        final auth = context.read<AuthState>();
        try {
          await auth.logout();
        } catch (_) {
          // AuthState clears the local token even when revocation fails.
        }
        if (!mounted) return;
        _message('Sesi berakhir. Silakan login kembali dan tekan Save lagi.');
        await ensureLoggedIn(context);
      } else if (error.statusCode == 400) {
        _message('Data tidak valid. Periksa kembali isian proyek.');
      } else if (error.statusCode == 403) {
        _message('Pembuatan proyek memerlukan akun Django superuser.');
      } else {
        _message('Proyek gagal disimpan. Silakan coba lagi.');
      }
    } catch (_) {
      if (!mounted) return;
      _message('Tidak dapat terhubung. Periksa jaringan dan coba lagi.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _field(_title, 'Judul Proyek', maxLength: 255),
              _field(_description, 'Deskripsi Proyek', maxLines: 5),
              _field(_image, 'URL/Path Gambar', maxLength: 255),
              _field(
                _play,
                'URL Proyek / Play URL',
                maxLength: 200,
                validator: (value) {
                  final requiredError = _required(value);
                  if (requiredError != null) return requiredError;
                  final uri = Uri.tryParse(value!.trim());
                  if (uri == null ||
                      !['http', 'https'].contains(uri.scheme.toLowerCase()) ||
                      uri.host.isEmpty ||
                      uri.userInfo.isNotEmpty ||
                      uri.toString().contains(RegExp(r'\s'))) {
                    return 'Masukkan URL HTTP atau HTTPS yang valid.';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _submitting ? null : _submit,
                    child: _submitting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int? maxLength,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) => Padding(
    padding: const EdgeInsets.all(8),
    child: TextFormField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      validator: validator ?? _required,
    ),
  );
}
