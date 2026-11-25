import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.apiClient});

  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    return Provider<ApiClient>.value(
      value: apiClient,
      child: MaterialApp(
        title: 'MyPortfolio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            secondary: Colors.amber[700],
          ),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
