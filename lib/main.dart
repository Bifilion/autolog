import 'package:autolog/core/router/app_router.dart';
import 'package:autolog/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: AutoLog()));
}

class AutoLog extends StatelessWidget {
  const AutoLog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'AutoLog',

      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
