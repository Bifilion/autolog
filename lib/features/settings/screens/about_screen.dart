import 'package:autolog/core/widgets/app_card.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Text(
          'O aplikaci',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 32),
        children: [
          AppCard(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
            child: Column(
              children: [
                Container(
                  width: 140,
                  height: 140,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 30, 8, 70),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Image.asset(
                    'assets/branding/autolog_splash.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),

                const SizedBox(height: 8),

                Text(
                  'Jednoduchá aplikace pro evidenci\n'
                  'provozu a nákladů vašeho vozidla.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 28),

                Container(
                  width: 50,
                  height: 1,
                  color: colorScheme.outlineVariant,
                ),

                const SizedBox(height: 24),

                Text(
                  'Vytvořil',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  'JPsoftware',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 28),

                Text(
                  'Verze 1.0.0',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '© 2026 JPsoftware',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
