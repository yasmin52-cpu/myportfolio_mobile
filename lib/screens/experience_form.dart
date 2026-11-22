import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _organization = '';
  String _position = '';
  String _experienceType = 'Internship';
  String _description = '';

  DateTime? _startDate;
  DateTime? _endDate;

  bool _currentlyWorking = false;

  final List<String> _experienceTypes = [
    'Internship',
    'Organization',
    'Work',
    'Volunteer',
    'Other',
  ];

  Future<void> _selectDate({required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && mounted) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';

    return '${date.day}/${date.month}/${date.year}';
  }

  void _saveExperience() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Experience Added Successfully!'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Organization: ${_organization.trim()}'),
                  Text('Position: ${_position.trim()}'),
                  Text('Type: $_experienceType'),
                  Text('Start Date: ${_formatDate(_startDate)}'),
                  Text(
                    'End Date: ${_currentlyWorking ? "Present" : _formatDate(_endDate)}',
                  ),
                  Text(
                    'Description: ${_description.trim().isEmpty ? "-" : _description.trim()}',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Experience Form'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === Organization ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Organization / Company',
                  hintText: 'e.g. Google Developer Groups',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                maxLength: 100,
                onChanged: (value) {
                  _organization = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Organization cannot be empty!';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === Position ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Position / Role',
                  hintText: 'e.g. UI/UX Designer',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work_outline),
                ),
                maxLength: 100,
                onChanged: (value) {
                  _position = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Position cannot be empty!';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === Experience Type ===
              DropdownButtonFormField<String>(
                initialValue: _experienceType,
                decoration: const InputDecoration(
                  labelText: 'Experience Type',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: _experienceTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _experienceType = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // === Start Date ===
              FormField<DateTime>(
                validator: (_) {
                  if (_startDate == null) {
                    return 'Start date is required!';
                  }
                  return null;
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () async {
                          await _selectDate(isStartDate: true);
                          field.didChange(_startDate);
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text('Start Date: ${_formatDate(_startDate)}'),
                      ),
                      if (field.hasError)
                        Text(
                          field.errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),

              // === Currently Working ===
              CheckboxListTile(
                title: const Text('I currently work here'),
                value: _currentlyWorking,
                onChanged: (value) {
                  setState(() {
                    _currentlyWorking = value ?? false;

                    if (_currentlyWorking) {
                      _endDate = null;
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              // === End Date ===
              if (!_currentlyWorking)
                FormField<DateTime>(
                  validator: (_) {
                    if (_endDate == null) {
                      return 'End date is required!';
                    }

                    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                      return 'End date cannot be before start date!';
                    }

                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () async {
                            await _selectDate(isStartDate: false);
                            field.didChange(_endDate);
                          },
                          icon: const Icon(Icons.event),
                          label: Text('End Date: ${_formatDate(_endDate)}'),
                        ),
                        if (field.hasError)
                          Text(
                            field.errorText!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                      ],
                    );
                  },
                ),

              const SizedBox(height: 16),

              // === Description ===
              TextFormField(
                maxLines: 4,
                maxLength: 500,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Describe your experience...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                onChanged: (value) {
                  _description = value;
                },
              ),

              const SizedBox(height: 24),

              // === Save Button ===
              ElevatedButton(
                onPressed: _saveExperience,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save Experience'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
