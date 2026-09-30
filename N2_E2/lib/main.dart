import 'package:flutter/material.dart';
import 'screens/catalogo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _lifecycleListener;

  final ValueNotifier<List<AppLifecycleState>> _lifecycleHistory =
      ValueNotifier<List<AppLifecycleState>>([]);

  @override
  void initState() {
    super.initState();

    _lifecycleListener = AppLifecycleListener(
      onStateChange: _handleLifecycleChange,
    );
  }

  void _handleLifecycleChange(AppLifecycleState state) {
    final history = List<AppLifecycleState>.from(_lifecycleHistory.value);
    history.add(state);
    _lifecycleHistory.value = history;
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    _lifecycleHistory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo de Jogos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: CatalogoScreen(
        lifecycleHistory: _lifecycleHistory,
      ),
    );
  }
}