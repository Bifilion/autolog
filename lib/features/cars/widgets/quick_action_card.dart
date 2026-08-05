import 'package:autolog/core/widgets/app_card.dart';
import 'package:flutter/material.dart';

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: onTap,

      child: AppCard(
        margin: const EdgeInsets.symmetric(horizontal: 0),

        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              width: 38,
              height: 38,

              decoration: BoxDecoration(
                color: const Color(0xff7B6EF6),

                borderRadius: BorderRadius.circular(12),
              ),

              child: Icon(icon, size: 22, color: Colors.white),
            ),

            const SizedBox(height: 6),

            Text(
              title,

              maxLines: 1,

              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
