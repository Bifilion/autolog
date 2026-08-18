import 'package:autolog/core/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Text(
          'Nastavení',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 32),
        children: [
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            onTap: () {
              context.push('/settings/about');
            },
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),

                const SizedBox(width: 16),

                const Expanded(
                  child: Text(
                    'O aplikaci',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),

                Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
