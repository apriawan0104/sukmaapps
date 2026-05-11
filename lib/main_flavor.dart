import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppFlavor { dev, uat, prd }

String _envFileName(AppFlavor flavor) {
  return switch (flavor) {
    AppFlavor.dev => '.env.dev',
    AppFlavor.uat => '.env.uat',
    AppFlavor.prd => '.env',
  };
}

/// Loads the env file for this flavor, then calls [runApp].
Future<void> runSukmaApp(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: _envFileName(flavor));
  runApp(SukmaApp(flavor: flavor));
}

class SukmaApp extends StatelessWidget {
  const SukmaApp({required this.flavor, super.key});

  final AppFlavor flavor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _FlavorHomePage(flavor: flavor),
    );
  }

  String get _appTitle {
    switch (flavor) {
      case AppFlavor.dev:
        return 'Sukma Dev';
      case AppFlavor.uat:
        return 'Sukma Uat';
      case AppFlavor.prd:
        return 'Sukma';
    }
  }
}

class _FlavorHomePage extends StatelessWidget {
  const _FlavorHomePage({required this.flavor});

  final AppFlavor flavor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sukma Apps'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Active flavor: ${flavor.name.toUpperCase()}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (kDebugMode) ...[
              const SizedBox(height: 16),
              Text(
                'env: ${dotenv.maybeGet('environment') ?? '—'}',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  dotenv.maybeGet('baseUrl') ?? '—',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
