import 'dart:async';

import 'package:flutter/material.dart';
import 'package:klasha_app/features/dashboard/data/model/ingredients.dart';
import 'package:klasha_app/features/dashboard/presentation/screens/recipes_screen.dart';
import 'package:klasha_app/features/dashboard/presentation/viewmodel/dashboard_vm.dart';
import 'package:klasha_app/utils/func.dart/validators.dart';
import 'package:klasha_app/utils/ui/app_button.dart';
import 'package:klasha_app/utils/ui/future_bottom_sheet.dart';
import 'package:klasha_app/utils/ui/text_fields.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool obscurePassword = true;
  final dateTEC = TextEditingController();

  List<String> selectedIngredients = [];

  @override
  void initState() {
    dateTEC.text = DateTime.now().toIso8601String().split('T').first;
    Future.microtask(() => context.read<DashboardVM>().getIngredients());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardVM>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Select Preference Lunch Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ClickableFormField(
              labelText: 'Use By Date',
              hintText: 'Select date',
              key: const ValueKey('456'),
              controller: dateTEC,
              validator: (input) => Validators.validateString(
                error: 'This field is required',
              )(input),
              onPressed: () async {
                if (provider.getRecipesRES.isLoading ||
                    provider.getIngredientsRES.isLoading) return;
                final result = await FutureBottomSheet<IngredientsModel>(
                  future: () =>
                      Future.value(provider.getIngredientsRES.data ?? []),
                  title: "Select an option",
                  itemBuilder: (context, item) {
                    return ListTile(
                      title: Text(
                        item.title ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        item.useBy ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ).show(context);
                if (result != null) {
                  dateTEC.text = (result as IngredientsModel).useBy ?? '';
                  if (!selectedIngredients.contains((result).title)) {
                    setState(() => selectedIngredients.add(result.title ?? ''));
                  }
                }
              },
              suffixIcon: provider.getIngredientsRES.isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Icon(
                      Icons.calendar_month,
                      size: 18,
                    ),
            ),
            const SizedBox(height: 24),
            if (selectedIngredients.isEmpty) ...[
              const Text(
                'No Ingredients Selected',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 14),
            ] else
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ...selectedIngredients
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIngredients.remove(e);
                              if (selectedIngredients.isEmpty) {
                                dateTEC.text = DateTime.now()
                                    .toIso8601String()
                                    .split('T')
                                    .first;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              e,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            const SizedBox(height: 40),
            AppButton(
              textTitle: 'Get Recipes',
              showLoading: provider.getRecipesRES.isLoading,
              action: () {
                if (selectedIngredients.isNotEmpty) {
                  provider.getRecipes(selectedIngredients).then((value) {
                    if (provider.getRecipesRES.isSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipesScreen(
                            recipes: provider.getRecipesRES.data ?? [],
                          ),
                        ),
                      );
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
