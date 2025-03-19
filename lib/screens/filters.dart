import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/switch_tile.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Filters")),
      body: Column(
        children: [
          SwitchTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged:
                (isChecked) => ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, isChecked),
            title: "Gluten free",
            subtitle: "Only includes gluten free meals",
          ),
          SwitchTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged:
                (isChecked) => ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, isChecked),
            title: "Lactose free",
            subtitle: "Only includes lactose free meals",
          ),
          SwitchTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged:
                (isChecked) => ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegetarian, isChecked),
            title: "Vegeterian",
            subtitle: "Only includes Vegeterian meals",
          ),
          SwitchTile(
            value: activeFilters[Filter.vegan]!,
            onChanged:
                (isChecked) => ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegan, isChecked),
            title: "Vegan",
            subtitle: "Only includes Vegan meals",
          ),
        ],
      ),
    );
  }
}
