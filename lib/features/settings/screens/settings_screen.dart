import 'package:autolog/core/database/isar_database.dart';
import 'package:autolog/core/widgets/app_card.dart';
import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const Color brandColor = Color.fromARGB(255, 30, 8, 70);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nastavení',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(4, 12, 4, 24),
        children: [
          AppCard(
            onTap: () {
              context.push('/about');
            },
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: brandColor,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'O aplikaci',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Informace o AutoLogu',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.chevron_right_rounded, color: Colors.black45),
              ],
            ),
          ),

          const SizedBox(height: 4),

          AppCard(
            onTap: () {
              _showDeleteConfirmation(context, ref);
            },
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                    size: 25,
                  ),
                ),

                const SizedBox(width: 16),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vymazat všechna data',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Odstraní všechna vozidla a záznamy',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final firstConfirmation = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Vymazat všechna data?'),
          content: const Text(
            'Budou odstraněna všechna vozidla, tankování, '
            'servisní záznamy a připomínky. '
            'Tuto akci nelze vrátit zpět.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Zrušit'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Pokračovat'),
            ),
          ],
        );
      },
    );

    if (firstConfirmation != true || !context.mounted) {
      return;
    }

    final secondConfirmation = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Opravdu vymazat data?'),
          content: const Text(
            'Všechna data aplikace budou nenávratně odstraněna.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Zrušit'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('ANO, VYMAZAT'),
            ),
          ],
        );
      },
    );

    if (secondConfirmation != true || !context.mounted) {
      return;
    }

    await IsarDatabase.clearAllData();

    // Aktualizuje stav garáže po vymazání databáze.
    ref.invalidate(carProvider);

    if (!context.mounted) {
      return;
    }

    context.go('/');
  }
}
