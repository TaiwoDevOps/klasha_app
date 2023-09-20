import 'package:flutter/material.dart';
import 'package:klasha_app/features/dashboard/data/model/recipes.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key, required this.recipes});
  final List<GetRecipesModel> recipes;

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Recipes'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {},
            children: [
              ...widget.recipes.map((e) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        e.title ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'Ingredients to make recipe:',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            ...e.ingredients!.map((i) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  i,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                  isExpanded: true,
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
