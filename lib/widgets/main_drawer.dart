import 'package:flutter/material.dart';
import 'package:meals_app/widgets/drawer/drawer_item.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onTileTap});

  final void Function(String) onTileTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                Text(
                  "Cooking Up!",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          DrawerItem(
            icon: Icons.restaurant,
            title: "Meals",
            onTap: () => onTileTap('meals'),
          ),
          DrawerItem(
            icon: Icons.settings,
            title: "Filters",
            onTap: () => onTileTap('filters'),
          ),
        ],
      ),
    );
  }
}
